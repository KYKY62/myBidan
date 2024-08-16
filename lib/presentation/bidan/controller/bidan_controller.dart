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
        (docUsers.data() as Map<String, dynamic>)['chats'] as List;

    if (docChatUser.isNotEmpty) {
      // user sudah pernah chat dengan bidan
      for (var singleChat in docChatUser) {
        if (singleChat['connection'] == userEmail) {
          chatId = singleChat;
        }
      }
      if (chatId != null) {
        // sudah pernah buat koneksi dengan =>userEmail
        //! Get.to ke?
        createNewConnection = false;
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
        docChatUser.add({
          "chat_id": chatDataId,
          "connection": userEmail,
          "lastTime": date,
          "total_unread": 0,
        });

        bidan.doc(_currentUser.email).update({"chats": docChatUser});

        bidanModel.update(
          (bidan) => bidan!.chatsBidan = [
            ChatsBidan(
              chatId: chatDataId,
              connection: userEmail,
              lastTime: date,
              totalUnread: 0,
            )
          ],
        );
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
          "chat": [],
        });

        // agar tidak mereplace data yang lama
        // total unread dibuat 0 karena diawal pasti belum ada yang chat
        docChatUser.add({
          "chat_id": newChat.id,
          "connection": userEmail,
          "lastTime": date,
          "total_unread": 0,
        });

        // update field chats di bidan collection
        bidan.doc(_currentUser.email).update({"chats": docChatUser});

        bidanModel.update(
          (bidan) => bidan!.chatsBidan = [
            ChatsBidan(
              chatId: newChat.id,
              connection: userEmail,
              lastTime: date,
              totalUnread: 0,
            )
          ],
        );
        chatId = newChat.id;
        bidanModel.refresh();
      }
    }
  }
}
