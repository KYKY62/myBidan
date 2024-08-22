import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FindKlinikControlController extends GetxController {
  RxBool isAddingKlinik = false.obs;
  RxBool loading = false.obs;
  RxBool isEdit = false.obs;

  String doc = '';

  final TextEditingController namaKlinikController = TextEditingController();
  final TextEditingController namaBidanController = TextEditingController();
  final TextEditingController jamPraktekController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController kotaController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();
  final TextEditingController linkGoogleMapController = TextEditingController();

  final storage = FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  var selectedTimeAwal = Timestamp.now().obs;
  var selectedTimeAkhir = Timestamp.now().obs;

  var image = Rx<Uint8List?>(null);

  void updateTimeAwal(Timestamp timestamp) =>
      selectedTimeAwal.value = timestamp;

  void updateTimeAkhir(Timestamp timestamp) =>
      selectedTimeAkhir.value = timestamp;

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

  void editOrAdd() => isEdit.value == true ? editKlinik() : addKlinik();

  Stream<QuerySnapshot>? getKlinik() => db
      .collection('klinik')
      .orderBy('timestamp', descending: true)
      .snapshots();

  Future<String> addKlinik() async {
    String resp = 'Some error Occurred';
    try {
      loading.value = true;

      String imgUrl = await uploadImage(image.value!, 'photoKlinik');

      Map<String, dynamic> dataKlinik = {
        "namaKlinik": namaKlinikController.text,
        "photo": imgUrl,
        "jamAwalKerja": selectedTimeAwal.value,
        "jamAkhirKerja": selectedTimeAkhir.value,
        "namaBidan": namaBidanController.text,
        "alamat": alamatController.text,
        "kota": kotaController.text.toLowerCase(),
        "map": linkGoogleMapController.text,
        "jamPraktek": jamPraktekController.text,
        "telepon": teleponController.text,
        'timestamp': DateTime.now(),
      };

      await db.collection('klinik').doc().set(dataKlinik);

      clearTextControllers();

      loading.value = false;
      isAddingKlinik.value = !isAddingKlinik.value;
      return resp = 'success';
    } catch (e) {
      loading.value = false;
      Get.defaultDialog(
        title: 'Data Klinik Gagal Ditambahkan',
        middleText: 'Lengkapi Form Data',
      );
    }
    return resp;
  }

  Future<String> editKlinik() async {
    String resp = 'Some error Occurred';
    try {
      loading.value = true;
      String imgUrl = await uploadImage(image.value!, 'photoKlinik');

      Map<String, dynamic> dataKlinik = {
        "namaKlinik": namaKlinikController.text,
        "photo": imgUrl,
        "jamAwalKerja": selectedTimeAwal.value,
        "jamAkhirKerja": selectedTimeAkhir.value,
        "namaBidan": namaBidanController.text,
        "alamat": alamatController.text,
        "kota": kotaController.text.toLowerCase(),
        "map": linkGoogleMapController.text,
        "jamPraktek": jamPraktekController.text,
        "telepon": teleponController.text,
        'timestamp': DateTime.now(),
      };

      await db.collection('klinik').doc(doc).update(dataKlinik);

      clearTextControllers();

      loading.value = false;
      isAddingKlinik.value = !isAddingKlinik.value;
      return resp = 'success';
    } catch (e) {
      loading.value = false;
      Get.defaultDialog(
        title: 'Data Klinik Gagal Diubah',
        middleText: 'Lengkapi Form Data',
      );
    }
    return resp;
  }

  void deleteArticle({
    required String doc,
  }) async {
    try {
      db.collection('klinik').doc(doc).delete();
    } on FirebaseException {
      Get.defaultDialog(middleText: 'Terjadi Kesalahan. Silahkan Coba Lagi');
    }
  }

  void clearTextControllers() {
    namaKlinikController.clear();
    namaBidanController.clear();
    jamPraktekController.clear();
    alamatController.clear();
    teleponController.clear();
    linkGoogleMapController.clear();
    kotaController.clear();
    image.value = null;
  }

  void disposeControllers() {
    namaKlinikController.dispose();
    namaBidanController.dispose();
    jamPraktekController.dispose();
    alamatController.dispose();
    teleponController.dispose();
    linkGoogleMapController.dispose();
    kotaController.dispose();
    image.value = null;
  }

  @override
  void onInit() {
    super.onInit();
    ever(isAddingKlinik, (bool adding) {
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
