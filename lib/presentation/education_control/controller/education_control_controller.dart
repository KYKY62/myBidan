import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EducationControlController extends GetxController {
  RxBool isAdding = false.obs;
  RxBool loading = false.obs;

  final TextEditingController judulController = TextEditingController();
  final TextEditingController blogContentController = TextEditingController();

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

  Future<String> addArticle({required Uint8List fileGambar}) async {
    String resp = 'Some error Occurred';
    try {
      loading.value = true;
      Map<String, dynamic> articleData = {
        "title": judulController.text,
        "photo": fileGambar,
        "contentArticle": blogContentController,
        'timestamp': DateTime.now(),
      };

      await db.collection('article').doc().set(articleData);

      judulController.clear();
      blogContentController.clear();

      loading.value = false;
      isAdding.value = !isAdding.value;
      return resp = 'success';
    } catch (e) {
      loading.value = false;
      Get.defaultDialog(title: 'Produk Gagal Ditambahkan');
    }
    return resp;
  }

  void clearTextControllers() {
    judulController.clear();
    blogContentController.clear();
  }

  @override
  void onInit() {
    super.onInit();
    ever(isAdding, (bool adding) {
      if (!adding) {
        clearTextControllers();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    judulController.dispose();
  }
}
