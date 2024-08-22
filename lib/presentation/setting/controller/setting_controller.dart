import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser!;
  final storage = FirebaseStorage.instance;
  RxString labelDropdown = ''.obs;

  TextEditingController nameController = TextEditingController();
  var image = Rx<Uint8List?>(null);

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProfileUser() =>
      db.collection('users').doc(_currentUser.email).snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> getKlinikUser(final doc) =>
      db.collection('klinik').doc(doc).snapshots();

  Stream<QuerySnapshot>? getKlinik() => db
      .collection('klinik')
      .orderBy('timestamp', descending: true)
      .snapshots();

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

  void updateUser(String lastImage) async {
    try {
      String? imgUrl;
      if (image.value != null) {
        imgUrl = await uploadImage(image.value!, 'photoUser');
      }

      Map<String, dynamic> updateUser = {
        "name": nameController.text,
        "photoUrl": imgUrl ?? lastImage,
      };

      nameController.text;
      image.value = null;
      await db.collection('users').doc(_currentUser.email).update(updateUser);
      Get.back();
    } catch (_) {}
  }

  void updatePanicButton() async {
    try {
      Map<String, dynamic> updatePanicButton = {
        "uidKlinik": labelDropdown.value,
      };
      await db
          .collection('users')
          .doc(_currentUser.email)
          .update(updatePanicButton);

      labelDropdown.value = '';
      Get.back();
    } catch (_) {}
  }
}
