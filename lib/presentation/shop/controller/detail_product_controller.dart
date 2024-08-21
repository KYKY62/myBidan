import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailProductController extends GetxController {
  RxInt isSelectedIndex = 0.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> launchPesan({
    required String phoneNumber,
    required String message,
  }) async {
    final url =
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAdmin() =>
      db.collection('admin').snapshots();
}
