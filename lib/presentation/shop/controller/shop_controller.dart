import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ShopController extends GetxController {
  RxInt currentIndex = 0.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot>? getProduct() => db
      .collection('produk')
      .orderBy('timestamp', descending: true)
      .snapshots();
}
