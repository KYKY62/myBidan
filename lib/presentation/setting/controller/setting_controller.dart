import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mybidan/core/routes/route_name.dart';

class SettingController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void logOut() async {
    final box = GetStorage();
    if (box.read('DataLogin') != null) {
      await box.erase();
    }
    await _auth.signOut();
    Get.offAllNamed(RouteName.login);
  }
}
