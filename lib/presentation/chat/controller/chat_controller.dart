import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/data/models/users_model.dart';

class ChatController extends GetxController {
  final TextEditingController searchBidan = TextEditingController();
  final TextEditingController chatBidan = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  var date = DateTime.now().toIso8601String();
  final _currentUser = FirebaseAuth.instance.currentUser!;

  final bool isSender = false;

  RxString nameBidan = ''.obs;
  var userModel = UsersModel().obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot>? getBidan() =>
      db.collection('bidan').orderBy('timestamp', descending: true).snapshots();

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

        docChatUser.add({
          "chat_id": chatDataId,
          "connection": bidanEmail,
          "lastTime": chatData['lastTime'],
        });
        users.doc(_currentUser.uid).update({"chats": docChatUser});

        userModel.update(
          (user) => user!.chats = [
            ChatUser(
              chatId: chatDataId,
              connection: bidanEmail,
              lastTime: chatData['lastTime'],
            )
          ],
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

        docChatUser.add({
          "chat_id": newChat.id,
          "connection": bidanEmail,
          "lastTime": date,
        });

        // update field chats di user collection
        users.doc(_currentUser.uid).update({"chats": docChatUser});

        userModel.update(
          (user) => user!.chats = [
            ChatUser(
              chatId: newChat.id,
              connection: bidanEmail,
              lastTime: date,
            )
          ],
        );
        chatId = newChat.id;
        userModel.refresh();
      }
    }
  }

  List bidan = [
    'Saefudin',
    'Dono',
    'Indro',
    'Kasino',
    'Danang',
  ];

  List<Map<String, dynamic>> chatList = [
    {
      'chat':
          'Halo, saya Sarah. Baru saja melahirkan dan rasanya mood saya seperti naik turun roller coaster. Apakah ada yang bisa membantu?',
      'isSender': false
    },
    {
      'chat':
          'Halo Sarah, saya senang Anda mencari bantuan. Saya adalah konselor di Holo Pablues. Ceritakan lebih lanjut, apa yang membuat suasana hati Anda berubah-ubah?',
      'isSender': true
    },
    {
      'chat':
          'Rasanya seperti saya berada dalam gelembung perasaan. Kadang-kadang saya bahagia, tapi kemudian tiba-tiba saya merasa cemas dan sedih. Saya khawatir ini akan berdampak pada hubungan saya dengan bayi saya.',
      'isSender': false
    },
    {
      'chat':
          'Terima kasih telah berbagi, Sarah. Anda tidak sendirian dalam perasaan ini. Bagaimana jika kita mencoba menjelajahi perasaan dan pengalaman Anda lebih dalam?',
      'isSender': true
    },
    {
      'chat':
          'Terima kasih telah berbagi, Sarah. Anda tidak sendirian dalam perasaan ini. Bagaimana jika kita mencoba menjelajahi perasaan dan pengalaman Anda lebih dalam?',
      'isSender': true
    }
  ];
}
