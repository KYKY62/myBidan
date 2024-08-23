import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mybidan/core.dart';

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController namaController = TextEditingController();

  var image = Rx<Uint8List?>(null);
  final storage = FirebaseStorage.instance;

  FirebaseAuth auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

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
  }

  Future<String> uploadImage(Uint8List file, String childName) async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = '$childName-$timestamp';
    final storageRef = storage.ref();
    final uploadTask = storageRef.child('$fileName.jpg');
    await uploadTask.putData(file);
    return await uploadTask.getDownloadURL();
  }

  void register() async {
    try {
      isLoading.value = true;
      // Register Akun
      final currentUser = await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // cek UID akun yang baru didaftarkan
      String checkUid = currentUser.user!.uid;

      // collection Transaksi
      DocumentReference transaksi = await db.collection('transaksi').add({
        'emailUser': emailController.text,
        'harga': '',
        'buktiPembayaran': '',
        'status': 'FREE',
        'isPremium': false,
        'time': '',
      });

      String imgUrl = await uploadImage(image.value!, 'photoUser');

      // simpan data login ke firestore
      await db.collection('users').doc(emailController.text).set({
        "uid": checkUid,
        "uidKlinik": '',
        "name": namaController.text,
        "keyName": namaController.text.substring(0, 1),
        "email": emailController.text,
        "photoUrl": imgUrl,
        "status": "",
        "creationTime":
            currentUser.user!.metadata.lastSignInTime!.toIso8601String(),
        "lastSignInTime":
            currentUser.user!.metadata.lastSignInTime!.toIso8601String(),
        "updatedTime": DateTime.now().toIso8601String(),
        'role': 'USER',
        'idPremium': transaksi.id,
      });
      isLoading.value = false;
      Get.offNamed(RouteName.login);
    } catch (_) {}
  }
}
