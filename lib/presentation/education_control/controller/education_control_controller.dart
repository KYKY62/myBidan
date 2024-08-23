import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EducationControlController extends GetxController {
  RxBool isAdding = false.obs;
  RxBool loading = false.obs;
  RxBool isEdit = false.obs;

  String doc = '';

  final TextEditingController judulController = TextEditingController();
  final TextEditingController blogContentController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController shortDescController = TextEditingController();
  final TextEditingController tipeArticleController = TextEditingController();
  // final TextEditingController kategoriController = TextEditingController();

  final storage = FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxString kategori = 'lokal'.obs;

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

  void editOrAdd() => isEdit.value == true ? editArticle() : addArticle();

  Stream<QuerySnapshot>? getArticle() => db
      .collection('article')
      .orderBy('timestamp', descending: true)
      .snapshots();

  Future<String> addArticle() async {
    String resp = 'Some error Occurred';
    try {
      loading.value = true;

      String imgUrl = await uploadImage(image.value!, 'photoArticle');

      Map<String, dynamic> articleData = {
        "title": judulController.text,
        "photo": imgUrl,
        "contentArticle": blogContentController.text,
        "author": authorController.text,
        "shortDesc": shortDescController.text,
        "subject": tipeArticleController.text,
        "kategori": kategori.value,
        'timestamp': DateTime.now(),
      };

      await db.collection('article').doc().set(articleData);

      clearTextControllers();

      loading.value = false;
      isAdding.value = !isAdding.value;
      return resp = 'success';
    } catch (e) {
      loading.value = false;
      Get.defaultDialog(
        title: 'Produk Gagal Ditambahkan',
        middleText: 'Lengkapi Form Data',
      );
    }
    return resp;
  }

  Future<String> editArticle() async {
    String resp = 'Some error Occurred';
    try {
      loading.value = true;
      String imgUrl = await uploadImage(image.value!, 'photoArticle');

      Map<String, dynamic> articleData = {
        "title": judulController.text,
        "photo": imgUrl,
        "contentArticle": blogContentController.text,
        "author": authorController.text,
        "shortDesc": shortDescController.text,
        "subject": tipeArticleController.text,
        "kategori": kategori.value,
        'timestamp': DateTime.now(),
      };

      await db.collection('article').doc(doc).update(articleData);

      clearTextControllers();

      loading.value = false;
      isAdding.value = !isAdding.value;
      return resp = 'success';
    } catch (e) {
      loading.value = false;
      Get.defaultDialog(
        title: 'Produk Gagal Diubah',
        middleText: 'Lengkapi Form Data',
      );
    }
    return resp;
  }

  void deleteArticle({
    required String doc,
  }) async {
    try {
      db.collection('article').doc(doc).delete();
    } on FirebaseException {
      Get.defaultDialog(middleText: 'Terjadi Kesalahan. Silahkan Coba Lagi');
    }
  }

  final List<Map<String, String>> _kategoriList = [
    {
      "value": 'lokal',
      "label": 'Berita Lokal',
    },
    {
      "value": 'trending',
      "label": 'Berita Trending',
    },
    {
      "value": 'news',
      "label": 'Berita News',
    },
    {
      "value": 'lainnya',
      "label": 'Dan Lain-lainnya',
    }
  ];

  List<DropdownMenuItem<String>> get dropdownItems {
    return _kategoriList.map((e) {
      return DropdownMenuItem<String>(
        value: e["value"],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            e["label"]!,
          ),
        ),
      );
    }).toList();
  }

  void clearTextControllers() {
    judulController.clear();
    blogContentController.clear();
    authorController.clear();
    shortDescController.clear();
    tipeArticleController.clear();
    kategori.value = '';
    image.value = null;
  }

  void disposeControllers() {
    judulController.dispose();
    blogContentController.dispose();
    authorController.dispose();
    shortDescController.dispose();
    tipeArticleController.dispose();
    kategori.value = '';
    image.value = null;
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
    disposeControllers();
  }
}
