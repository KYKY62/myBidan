import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/routes/route_name.dart';
import 'package:mybidan/data/models/bidan_model.dart';

class BidanChatController extends GetxController {
  var bidanModel = BidanModel().obs;
  final _currentUser = FirebaseAuth.instance.currentUser!;
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference bidan = FirebaseFirestore.instance.collection('bidan');
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  var date = DateTime.now().toIso8601String();

  final TextEditingController chatUser = TextEditingController();

  void addNewConnection({
    required String userEmail,
  }) async {
    bool createNewConnection = false;
    // ignore: prefer_typing_uninitialized_variables, unused_local_variable
    var chatId;
    // get collection users
    var docUsers = bidan.doc(_currentUser.email);
    // ubah chats jadi bentuk map dan List karna bentuk chats nya List
    final docChatUser = await docUsers.collection('chats').get();

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

  Stream<QuerySnapshot<Map<String, dynamic>>> getListChatBidan() => bidan
      .doc(_currentUser.email)
      .collection('chats')
      .orderBy("lastTime", descending: true)
      .snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProfileUsers(
          String usersEmail) =>
      db.collection('users').doc(usersEmail).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> historyChat({
    required String chatId,
  }) =>
      db
          .collection('chats')
          .doc(chatId)
          .collection('chat')
          .orderBy("time", descending: true)
          .snapshots();

  void goToPrivateChat({
    required String chatId,
    required String penerimaEmail,
    required String namaBidan,
  }) async {
    final updateStatusChat = await chats
        .doc(chatId)
        .collection("chat")
        .where("isRead", isEqualTo: false)
        .where("penerima", isEqualTo: _currentUser.email)
        .get();

    // Mengambil data di chats lalu update IsRead
    for (var statusChat in updateStatusChat.docs) {
      await chats
          .doc(chatId)
          .collection("chat")
          .doc(statusChat.id)
          .update({"isRead": true});
    }
    // update users
    await bidan
        .doc(_currentUser.email)
        .collection("chats")
        .doc(chatId)
        .update({"total_unread": 0});

    Get.toNamed(RouteName.roomBidanPrivate, arguments: {
      'chatId': chatId,
      'nameBidan': namaBidan,
      'penerima': penerimaEmail,
    });
  }
}
