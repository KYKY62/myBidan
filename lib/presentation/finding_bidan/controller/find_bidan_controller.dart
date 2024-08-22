import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindBidanController extends GetxController {
  final TextEditingController searchBidan = TextEditingController();
  final FocusNode focusNode = FocusNode();
  RxString searchQuery = ''.obs;
  final selectedObject = false.obs;
  final detailObject = Rx<DocumentSnapshot?>(null);

  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot>? getKlinik() => db
      .collection('klinik')
      .orderBy('timestamp', descending: true)
      .snapshots();

  Stream<QuerySnapshot<Object?>>? getKlinikWithSearch(final searchquery) => db
      .collection('klinik')
      .orderBy('kota')
      .where('kota', isGreaterThanOrEqualTo: searchquery)
      .where('kota', isLessThanOrEqualTo: '$searchquery\uf8ff')
      .snapshots();
}
