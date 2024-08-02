import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ShopControlController extends GetxController {
  RxBool isAddingShop = false.obs;
  RxBool loading = false.obs;
  RxBool isEdit = false.obs;

  String doc = '';

  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController bahanController = TextEditingController();
  final TextEditingController hargaAsliController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController hargaPromoController = TextEditingController();

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

  void editOrAdd() => isEdit.value == true ? editProduk() : addProduk();

  Stream<QuerySnapshot>? getArticle() => db
      .collection('produk')
      .orderBy('timestamp', descending: true)
      .snapshots();

  Future<String> addProduk() async {
    String resp = 'Some error Occurred';
    try {
      loading.value = true;

      String imgUrl = await uploadImage(image.value!, 'photoProduk');

      Map<String, dynamic> produkData = {
        "title": judulController.text,
        "photo": imgUrl,
        "deskripsi": deskripsiController.text,
        "bahan": bahanController.text,
        "kategori": kategoriController.text,
        "harga_asli": hargaAsliController.text,
        "harga_promo": hargaPromoController.text,
        'timestamp': DateTime.now(),
      };

      await db.collection('produk').doc().set(produkData);

      clearTextControllers();

      loading.value = false;
      isAddingShop.value = !isAddingShop.value;
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

  Future<String> editProduk() async {
    String resp = 'Some error Occurred';
    try {
      loading.value = true;
      String imgUrl = await uploadImage(image.value!, 'photoProduk');

      Map<String, dynamic> produkData = {
        "title": judulController.text,
        "photo": imgUrl,
        "deskripsi": deskripsiController.text,
        "bahan": bahanController.text,
        "kategori": kategoriController.text,
        "harga_asli": hargaAsliController.text,
        "harga_promo": hargaPromoController.text,
        'timestamp': DateTime.now(),
      };

      await db.collection('produk').doc(doc).update(produkData);

      clearTextControllers();

      loading.value = false;
      isAddingShop.value = !isAddingShop.value;
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
      db.collection('produk').doc(doc).delete();
    } on FirebaseException {
      Get.defaultDialog(middleText: 'Terjadi Kesalahan. Silahkan Coba Lagi');
    }
  }

  void clearTextControllers() {
    judulController.clear();
    deskripsiController.clear();
    bahanController.clear();
    kategoriController.clear();
    hargaAsliController.clear();
    hargaPromoController.clear();
    image.value = null;
  }

  void disposeControllers() {
    judulController.dispose();
    deskripsiController.clear();
    bahanController.clear();
    kategoriController.clear();
    hargaAsliController.clear();
    hargaPromoController.clear();
    image.value = null;
  }

  @override
  void onInit() {
    super.onInit();
    ever(isAddingShop, (bool adding) {
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
