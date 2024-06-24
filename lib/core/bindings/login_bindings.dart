import 'package:get/get.dart';
import 'package:mybidan/presentation/auth/controller/login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
