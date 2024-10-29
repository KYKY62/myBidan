import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TextEditingController searchDoctor = TextEditingController();

  RxInt currentIndex = 0.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DocumentSnapshot> getUser() =>
      db.collection('users').doc(_auth.currentUser!.email).get();

  Stream<QuerySnapshot>? getBidan() => db
      .collection('bidan')
      .orderBy('timestamp', descending: true)
      .limit(3)
      .snapshots();

  Stream<QuerySnapshot> getIklan() => db.collection('iklan').snapshots();

  Stream<QuerySnapshot>? getArticle() => db
      .collection('article')
      .orderBy('timestamp', descending: true)
      .snapshots();
}
