import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mybidan/data/models/users_model.dart';

class ChatController extends GetxController {
  final TextEditingController searchBidan = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  var date = DateTime.now().toIso8601String();
  final _currentUser = FirebaseAuth.instance.currentUser!;

  final bool isSender = false;
  RxBool loading = false.obs;
  RxInt isSelected = 0.obs;

  RxMap chatPageValue = {}.obs;
  var userModel = UsersModel().obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  var image = Rx<Uint8List?>(null);
  final storage = FirebaseStorage.instance;
  RxString accountBank = ''.obs;

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

  Stream<QuerySnapshot<Map<String, dynamic>>> getAdmin() =>
      db.collection('admin').snapshots();

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

  Stream<bool> checkAccountPremium() async* {
    try {
      final docUser = await users.doc(_currentUser.email).get();

      if (docUser.exists) {
        final idPremium = docUser['idPremium'];

        yield* db.collection('transaksi').doc(idPremium).snapshots().map(
          (snapshot) {
            if (snapshot.exists) {
              bool isPremium = snapshot['isPremium'];
              return isPremium;
            } else {
              return false;
            }
          },
        );
      } else {
        yield false;
      }
    } catch (_) {
      yield false;
    }
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      return await xFile.readAsBytes();
    }
  }

  selectedImage() async {
    Uint8List? img = await pickImage();
    image.value = img;
    image.refresh();
  }

  Future<String> uploadImage(Uint8List file, String childName) async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = '$childName-$timestamp';
    final storageRef = storage.ref();
    final uploadTask = storageRef.child('$fileName.jpg');
    await uploadTask.putData(file);
    return await uploadTask.getDownloadURL();
  }

  void pembayaranAction() async {
    try {
      loading.value = true;
      String imgUrl = await uploadImage(image.value!, 'buktiTF');
      final docUser = await users.doc(_currentUser.email).get();
      final dataHarga =
          await db.collection('hargaLayanan').doc('hargaLayanan').get();

      final idTransaksi = docUser['idPremium'];

      Map<String, dynamic> updateData = {
        "buktiPembayaran": imgUrl,
        'harga': dataHarga['harga'],
        "time": DateTime.now().toIso8601String(),
      };

      await db.collection('transaksi').doc(idTransaksi).update(updateData);
      loading.value = false;
      image.value = null;
      Get.back();
    } catch (e) {
      loading.value = false;
      Get.defaultDialog(
        title: 'Produk Gagal Ditambahkan',
        middleText: 'Lengkapi Form Data',
      );
    }
  }

  void chipSelected({
    required int chipValue,
    required String akunBank,
  }) {
    isSelected.value = chipValue;
    accountBank.value = akunBank;
  }
}
