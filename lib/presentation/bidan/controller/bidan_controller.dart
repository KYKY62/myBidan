import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mybidan/data/models/users_model.dart';

class BidanController extends GetxController {
  var userModel = UsersModel().obs;
  final _currentUser = FirebaseAuth.instance.currentUser!;
  CollectionReference users = FirebaseFirestore.instance.collection('bidan');
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  var date = DateTime.now().toIso8601String();

  void addNewConnection({
    required String bidanEmail,
  }) async {
    bool createNewConnection = false;
    // ignore: prefer_typing_uninitialized_variables
    var chatId;
    // get collection users
    var docUsers = await users.doc(_currentUser.uid).get();
    // ubah chats jadi bentuk map dan List karna bentuk chats nya List
    final docChatUser =
        (docUsers.data() as Map<String, dynamic>)['chats'] as List;

    if (docChatUser.isNotEmpty) {
      // user sudah pernah chat dengan bidan
      for (var singleChat in docChatUser) {
        if (singleChat['connection'] == bidanEmail) {
          chatId = singleChat;
        }
      }
      if (chatId != null) {
        // sudah pernah buat koneksi dengan =>bidanEmail
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
          bidanEmail,
        ],
        [
          bidanEmail,
          _currentUser.email,
        ]
      ]).get();

      if (chatDocs.docs.isNotEmpty) {
        final chatDataId = chatDocs.docs[0].id;
        final chatData = chatDocs.docs[0].data() as Map<String, dynamic>;

        users.doc(_currentUser.uid).update({
          "chats": [
            {
              "chat_id": chatDataId,
              "connection": bidanEmail,
              "lastTime": chatData['lastTime'],
            }
          ]
        });
        userModel.update(
          (val) {
            ChatUser(
              chatId: chatDataId,
              connection: bidanEmail,
              lastTime: chatData['lastTime'],
            );
          },
        );
        chatId = chatDataId;
        userModel.refresh();
      } else {
        // add collection chats
        final newChat = await chats.add({
          "connection": [
            _currentUser.email,
            bidanEmail,
          ],
          "total_chats": 0,
          "total_reads": 0,
          "total_unreads": 0,
          "chat": [],
          "lastTime": date,
        });

        // update field chats di user collection
        users.doc(_currentUser.uid).update({
          "chats": [
            {
              "chat_id": newChat.id,
              "connection": bidanEmail,
              "lastTime": date,
            }
          ]
        });

        userModel.update(
          (val) {
            ChatUser(
              chatId: newChat.id,
              connection: bidanEmail,
              lastTime: date,
            );
          },
        );
        chatId = newChat.id;
        userModel.refresh();
      }
    }
  }
}
