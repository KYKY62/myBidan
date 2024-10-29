import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mybidan/core.dart';

class SettingAdminController extends GetxController {
  final TextEditingController rekeningBCAController = TextEditingController();
  final TextEditingController rekeningBNIController = TextEditingController();
  final TextEditingController rekeningBSIController = TextEditingController();
  final TextEditingController rekeningBRIController = TextEditingController();
  final TextEditingController rekeningMandiriController =
      TextEditingController();
  final TextEditingController rekeningPermataController =
      TextEditingController();
  final TextEditingController nomorTeleponController = TextEditingController();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool loading = false.obs;
  RxBool isAuth = false.obs;

  Stream<DocumentSnapshot> settingAdmin() =>
      _db.collection('admin').doc(_auth.currentUser!.email).snapshots();

  void editAdmin() async {
    try {
      loading.value = true;
      await _db.collection('admin').doc(_auth.currentUser!.email).update({
        'account_bca': rekeningBCAController.text,
        'account_bni': rekeningBNIController.text,
        'account_bsi': rekeningBSIController.text,
        'account_bri': rekeningBRIController.text,
        'account_mandiri': rekeningMandiriController.text,
        'account_permata': rekeningPermataController.text,
        'telepon': nomorTeleponController.text,
      });
      loading.value = false;
      Get.back();
    } catch (_) {
      loading.value = false;
      Get.back();
      Get.defaultDialog(
        title: 'Data Gagal Diperbarui',
        middleText: 'Lengkapi Form Data',
      );
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
}
