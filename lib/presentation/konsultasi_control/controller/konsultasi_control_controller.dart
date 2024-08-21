import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class KonsultasiControlController extends GetxController {
  RxBool loading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialistController = TextEditingController();
  final TextEditingController hargaLayananController = TextEditingController();
  // final TextEditingController jamAkhirPraktekController =
  //     TextEditingController();

  var selectedTimeAwal = Timestamp.now().obs;
  var selectedTimeAkhir = Timestamp.now().obs;

  final storage = FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  var image = Rx<Uint8List?>(null);

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

  void updateTimeAwal(Timestamp timestamp) =>
      selectedTimeAwal.value = timestamp;

  void updateTimeAkhir(Timestamp timestamp) =>
      selectedTimeAkhir.value = timestamp;

  Stream<QuerySnapshot>? getBidan() =>
      db.collection('bidan').orderBy('timestamp', descending: true).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> getListOrder() =>
      db.collection('transaksi').orderBy('time').snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> getHargaLayanan() =>
      db.collection('hargaLayanan').doc('hargaLayanan').snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProfileUser({
    required String doc,
  }) =>
      db.collection('users').doc(doc).snapshots();

  Future<String> addBidan() async {
    String resp = 'Some error Occurred';
    try {
      loading.value = true;
      String imgUrl = await uploadImage(image.value!, 'photoBidan');

      final currentUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // cek UID akun yang baru didaftarkan
      var checkEmail = currentUser.user!.email;

      // buat nested collection
      db.collection('bidan').doc(checkEmail).collection('chats');

      Map<String, dynamic> bidanData = {
        "email": emailController.text,
        "name": nameController.text,
        "photoBidan": imgUrl,
        "keyName": nameController.text.substring(0, 1).toUpperCase(),
        "specialistBidan": specialistController.text,
        "jamAwalKerja": selectedTimeAwal.value,
        "jamAkhirKerja": selectedTimeAkhir.value,
        'role': 'BIDAN',
        "creationTime":
            currentUser.user!.metadata.lastSignInTime!.toIso8601String(),
        "lastSignInTime":
            currentUser.user!.metadata.lastSignInTime!.toIso8601String(),
        "updatedTime": DateTime.now().toIso8601String(),
        'timestamp': DateTime.now(),
      };

      await db.collection('bidan').doc(checkEmail).set(bidanData);

      clearController();
      loading.value = false;
      Get.back();
      return resp = 'success';
    } catch (e) {
      loading.value = false;
      Get.defaultDialog(
        title: 'Produk Gagal Ditambahkan',
        middleText: 'Lengkapi Form Data',
      );
    }
    return resp;
  }

  void updateHargaLayanan() async {
    loading.value = true;
    Map<String, String> updateData = {
      'harga': hargaLayananController.text,
      'time': DateTime.now().toIso8601String(),
    };
    await db.collection('hargaLayanan').doc('hargaLayanan').update(updateData);
    hargaLayananController.clear();
    loading.value = false;
    Get.back();
  }

  void updateStatusTransaksi(String doc) async {
    Map<String, dynamic> updateData = {
      'isPremium': true,
      'status': 'BERHASIL',
    };
    await db.collection('transaksi').doc(doc).update(updateData);
    Get.back();
  }

  void clearController() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    specialistController.clear();
    image.value = null;
  }
}
