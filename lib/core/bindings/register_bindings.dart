import 'package:get/get.dart';
import 'package:mybidan/presentation/auth/controller/register_controller.dart';

class RegisterBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}
