import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/extension/date_time_ext.dart';

class BidanPrivateChatController extends GetxController {
  final TextEditingController chatBidan = TextEditingController();
  CollectionReference chats = FirebaseFirestore.instance.collection("chats");
  CollectionReference bidan = FirebaseFirestore.instance.collection("bidan");
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  String date = DateTime.now().toIso8601String();
  final currentUser = FirebaseAuth.instance.currentUser!;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamChats(String chatId) {
    return chats.doc(chatId).collection("chat").orderBy("time").snapshots();
  }

  void newChat({
    required String email,
    required String chatId,
    required String penerima,
  }) async {
    if (chatBidan.text != '') {
      await chats.doc(chatId).collection("chat").add({
        "pengirim": email,
        "penerima": penerima,
        "msg": chatBidan.text,
        "time": date,
        "isRead": false,
        "groupTime": DateTime.parse(date).toFormattedInHours(),
      });

      chatBidan.clear();

      await bidan.doc(email).collection("chats").doc(chatId).update({
        "lastTime": date,
      });

      final checkChatsFriend =
          await users.doc(penerima).collection("chats").doc(chatId).get();

      if (checkChatsFriend.exists) {
        // first check total unread
        final checkTotalUnread = await chats
            .doc(chatId)
            .collection("chat")
            .where("isRead", isEqualTo: false)
            .where("pengirim", isEqualTo: email)
            .get();

        // total unread for friend
        var totalUnread = checkTotalUnread.docs.length;

        await users
            .doc(penerima)
            .collection("chats")
            .doc(chatId)
            .update({"lastTime": date, "total_unread": totalUnread});
      } else {
        // jika collection chats tidak ada datanya
        await users.doc(penerima).collection("chats").doc(chatId).set({
          "connection": email,
          "lastTime": date,
          "total_unread": 1,
        });
      }
    }
  }
}
