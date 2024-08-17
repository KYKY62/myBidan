import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mybidan/data/models/bidan_model.dart';

class BidanController extends GetxController {
  var bidanModel = BidanModel().obs;
  final _currentUser = FirebaseAuth.instance.currentUser!;
  CollectionReference bidan = FirebaseFirestore.instance.collection('bidan');
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  var date = DateTime.now().toIso8601String();

  void addNewConnection({
    required String userEmail,
  }) async {
    bool createNewConnection = false;
    // ignore: prefer_typing_uninitialized_variables
    var chatId;
    // get collection users
    var docUsers = await bidan.doc(_currentUser.email).get();
    // ubah chats jadi bentuk map dan List karna bentuk chats nya List
    final docChatUser =
        await bidan.doc(_currentUser.email).collection('chats').get();

    if (docChatUser.docs.isEmpty) {
      // user sudah pernah chat dengan bidan
      final checkConnection = await bidan
          .doc(_currentUser.email)
          .collection("chats")
          .where("connection", isEqualTo: userEmail)
          .get();
      if (checkConnection.docs.isNotEmpty) {
        // sudah pernah buat koneksi dengan =>userEmail
        //! Get.to ke?
        createNewConnection = false;
        chatId = checkConnection.docs[0].id;
      } else {
        createNewConnection = true;
      }
    } else {
      createNewConnection = true;
    }

    if (createNewConnection) {
      final chatDocs = await chats.where('connection', whereIn: [
        [
          _currentUser.email,
          userEmail,
        ],
        [
          userEmail,
          _currentUser.email,
        ]
      ]).get();

      if (chatDocs.docs.isNotEmpty) {
        final chatDataId = chatDocs.docs[0].id;
        final chatData = chatDocs.docs[0].data() as Map<String, dynamic>;

        // agar tidak mereplace data yang lama
        await bidan
            .doc(_currentUser.email)
            .collection("chats")
            .doc(chatDataId)
            .set({
          "connection": userEmail,
          "lastTime": date,
          "total_unread": 0,
        });

        final listChats =
            await bidan.doc(_currentUser.email).collection("chats").get();

        if (listChats.docs.isNotEmpty) {
          List<ChatsBidan> dataListChats = [];
          for (var element in listChats.docs) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatsBidan(
              chatId: dataDocChatId,
              connection: dataDocChat['connection'],
              lastTime: dataDocChat["lastTime"],
              totalUnread: dataDocChat["total_unread"],
            ));
          }
          bidanModel.update((bidan) => bidan!.chatsBidan = dataListChats);
        } else {
          bidanModel.update((bidan) => bidan!.chatsBidan = []);
        }
        chatId = chatDataId;
        // bidanModel.refresh();
        bidanModel.refresh();
      } else {
        // add collection chats
        final newChat = await chats.add({
          "connection": [
            _currentUser.email,
            userEmail,
          ],
        });

        await bidan
            .doc(_currentUser.email)
            .collection("chats")
            .doc(newChat.id)
            .set({
          "connection": userEmail,
          "lastTime": date,
          "total_unread": 0,
        });

        final listChats =
            await bidan.doc(_currentUser.email).collection("chats").get();

        if (listChats.docs.isNotEmpty) {
          List<ChatsBidan> dataListChats = [];
          for (var element in listChats.docs) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatsBidan(
              chatId: dataDocChatId,
              connection: dataDocChat['connection'],
              lastTime: dataDocChat["lastTime"],
              totalUnread: dataDocChat["total_unread"],
            ));
          }
          bidanModel.update((bidan) => bidan!.chatsBidan = dataListChats);
        } else {
          bidanModel.update((bidan) => bidan!.chatsBidan = []);
        }
        chatId = newChat.id;
        bidanModel.refresh();
      }
    }
  }
}
