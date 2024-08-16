import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mybidan/core/routes/route_name.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // collection
  var roleUser = FirebaseFirestore.instance.collection('users');
  var roleAdmin = FirebaseFirestore.instance.collection('admin');
  var roleBidan = FirebaseFirestore.instance.collection('bidan');

  RxBool isLoading = false.obs;
  RxBool isAuth = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> firstInitialized() async {
    return await autoLogin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });
  }

  Future<bool> autoLogin() async {
    // mengubah isAuth => true
    final box = GetStorage();
    if (box.read('autoLogin') != null || box.read('autoLogin') == true) {
      return true;
    }
    return false;
  }

  Future<void> login({required String email, required String password}) async {
    try {
      isLoading.value = true;

      final credentialUser = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // check doc nya apakah ada di Firestore dan sesuai emailnya
      final checkEmail = credentialUser.user!.email;

      final adminCollection = await roleUser.doc(checkEmail).get();
      final usersCollection = await roleAdmin.doc(checkEmail).get();
      final bidanCollection = await roleBidan.doc(checkEmail).get();

      if (adminCollection.exists ||
          usersCollection.exists ||
          bidanCollection.exists) {
        String? role;

        if (adminCollection.exists) {
          role = adminCollection.data()?['role'];
        } else if (usersCollection.exists) {
          role = usersCollection.data()?['role'];
        } else {
          role = bidanCollection.data()?['role'];
        }

        // Jika role ditemukan
        if (role != null) {
          // simpan ke GetStorage
          final box = GetStorage();
          box.write('autoLogin', true);
          box.write('role', role);
          isLoading.value = false;

          emailController.clear();
          passwordController.clear();

          navigateToHomePageBasedOnRole(role);
        }
      }
    } on FirebaseAuthException catch (_) {
      isLoading.value = false;
      Get.defaultDialog(
          title: 'Terjadi Kesalahan', middleText: 'Email dan password salah');
    }
  }

  void logOut() async {
    final box = GetStorage();
    if (box.read('autoLogin') != null && box.read('role') != null) {
      await box.erase();
      isAuth.value = false;
      await _auth.signOut();
      Get.offAllNamed(RouteName.login);
    }
  }

  // untuk initialRouteDiawal jika sudah autoLogin
  void navigateToHomePageBasedOnRole(String role) {
    switch (role) {
      case 'USER':
        Get.offNamed(RouteName.main);
        break;
      case 'ADMIN':
        Get.offNamed(RouteName.dasboard);
        break;
      case 'BIDAN':
        Get.offNamed(RouteName.roomBidan);
        break;
    }
  }

  String getInitialRouteBasedOnRole(String? role) {
    switch (role) {
      case 'USER':
        return RouteName.main;
      case 'ADMIN':
        return RouteName.dasboard;
      case 'BIDAN':
        return RouteName.roomBidan;
      default:
        return RouteName.login; // Fallback ke login jika role tidak dikenal
    }
  }
}
