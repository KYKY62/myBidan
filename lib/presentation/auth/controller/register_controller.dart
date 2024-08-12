import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core.dart';

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance.collection('users');

  void register({
    required String email,
    required String password,
  }) async {
    try {
      // Register Akun
      final currentUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // cek UID akun yang baru didaftarkan
      String checkUid = currentUser.user!.uid;

      // simpan data login ke firestore
      await db.doc(checkUid).set({
        "uid": checkUid,
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
        'chats': [],
      });

      Get.offNamed(RouteName.login);
    } catch (_) {}
  }
}
