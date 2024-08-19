import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/data/models/users_model.dart';

class ChatController extends GetxController {
  final TextEditingController searchBidan = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  var date = DateTime.now().toIso8601String();
  final _currentUser = FirebaseAuth.instance.currentUser!;

  final bool isSender = false;

  RxMap chatPageValue = {}.obs;
  var userModel = UsersModel().obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot>? getBidan() =>
      db.collection('bidan').orderBy('timestamp', descending: true).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> getListChatUser() => db
      .collection('users')
      .doc(_currentUser.email)
      .collection('chats')
      .orderBy("lastTime", descending: true)
      .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> historyChat({
    required String chatId,
  }) =>
      db
          .collection('chats')
          .doc(chatId)
          .collection('chat')
          .orderBy("time", descending: true)
          .snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProfileBidan(
          String bidanEmail) =>
      db.collection('bidan').doc(bidanEmail).snapshots();

  void addNewConnection({required String bidanEmail}) async {
    bool createNewConnection = false;
    // ignore: prefer_typing_uninitialized_variables, unused_local_variable
    var chatId;

    // ubah chats jadi bentuk map dan List karna bentuk chats nya List
    final docChatUser =
        await users.doc(_currentUser.email).collection('chats').get();

    if (docChatUser.docs.isEmpty) {
      // user sudah pernah chat dengan bidan
      final checkConnection = await users
          .doc(_currentUser.email)
          .collection("chats")
          .where("connection", isEqualTo: bidanEmail)
          .get();
      if (checkConnection.docs.isNotEmpty) {
        // sudah pernah buat koneksi dengan =>bidanEmail
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
          bidanEmail,
        ],
        [
          bidanEmail,
          _currentUser.email,
        ]
      ]).get();

      if (chatDocs.docs.isNotEmpty) {
        final chatDataId = chatDocs.docs[0].id;

        // total unread dibuat 0 karena diawal pasti belum ada yang chat
        await users
            .doc(_currentUser.email)
            .collection("chats")
            .doc(chatDataId)
            .set({
          "connection": bidanEmail,
          "lastTime": date,
          "total_unread": 0,
        });

        final listChats =
            await users.doc(_currentUser.email).collection("chats").get();

        if (listChats.docs.isNotEmpty) {
          List<ChatUser> dataListChats = [];
          for (var element in listChats.docs) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat['connection'],
              lastTime: dataDocChat["lastTime"],
              totalUnread: dataDocChat["total_unread"],
            ));
          }
          userModel.update((user) => user!.chats = dataListChats);
        } else {
          userModel.update((user) => user!.chats = []);
        }

        chatId = chatDataId;
        userModel.refresh();
      } else {
        // add collection chats
        final newChat = await chats.add({
          "connection": [
            _currentUser.email,
            bidanEmail,
          ],
        });

        chats.doc(newChat.id).collection("chat");

        await users
            .doc(_currentUser.email)
            .collection("chats")
            .doc(newChat.id)
            .set({
          "connection": bidanEmail,
          "lastTime": date,
          "total_unread": 0,
        });

        final listChats =
            await users.doc(_currentUser.email).collection("chats").get();

        if (listChats.docs.isNotEmpty) {
          List<ChatUser> dataListChats = [];
          for (var element in listChats.docs) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat["connection"],
              lastTime: dataDocChat["lastTime"],
              totalUnread: dataDocChat["total_unread"],
            ));
          }
          userModel.update((user) => user!.chats = dataListChats);
        } else {
          userModel.update((user) => user!.chats = []);
        }

        chatId = newChat.id;
        userModel.refresh();
      }
    }
  }

  void goToPrivateChat({
    required String chatId,
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
    await users
        .doc(_currentUser.email)
        .collection("chats")
        .doc(chatId)
        .update({"total_unread": 0});
  }

  Future<bool> checkAccountPremium() async {
    try {
      final docUser = await users.doc(_currentUser.email).get();

      if (docUser.exists) {
        final idPremium = docUser['idPremium'];
        print(idPremium);

        final checkTransaksi =
            await db.collection('transaksi').doc(idPremium).get();

        if (checkTransaksi.exists) {
          bool isPremium = checkTransaksi['isPremium'];
          if (isPremium) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }
}
