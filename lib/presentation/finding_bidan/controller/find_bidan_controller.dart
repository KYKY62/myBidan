import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindBidanController extends GetxController {
  final TextEditingController searchBidan = TextEditingController();
  final selectedObject = false.obs;
  final detailObject = Rx<DocumentSnapshot?>(null);

  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot>? getKlinik() => db
      .collection('klinik')
      .orderBy('timestamp', descending: true)
      .snapshots();
}
