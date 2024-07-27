import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KonsultasiControlController extends GetxController {
  RxBool loading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialistController = TextEditingController();
  final TextEditingController jamMulaiPraktekController =
      TextEditingController();
  final TextEditingController jamAkhirPraktekController =
      TextEditingController();

  var selectedTimeAwal = Timestamp.now().obs;
  var selectedTimeAkhir = Timestamp.now().obs;

  void updateTimeAwal(Timestamp timestamp) {
    selectedTimeAwal.value = timestamp;
  }

  void updateTimeAkhir(Timestamp timestamp) {
    selectedTimeAkhir.value = timestamp;
  }
}
