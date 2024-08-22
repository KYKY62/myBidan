import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core.dart';

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  void register({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      // Register Akun
      final currentUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // cek UID akun yang baru didaftarkan
      String checkUid = currentUser.user!.uid;

      // collection Transaksi
      DocumentReference transaksi = await db.collection('transaksi').add({
        'emailUser': email,
        'harga': '',
        'buktiPembayaran': '',
        'status': 'FREE',
        'isPremium': false,
        'time': '',
      });

      // simpan data login ke firestore
      await db.collection('users').doc(email).set({
        "uid": checkUid,
        "uidKlinik": '',
        "name": 'Testing',
        "keyName": 'T',
        "email": email,
        "photoUrl": '',
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
