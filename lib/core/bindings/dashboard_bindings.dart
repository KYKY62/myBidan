import 'package:get/get.dart';
import 'package:mybidan/core.dart';
import 'package:mybidan/presentation/find_klinik_control/controller/find_klinik_control_controller.dart';
import 'package:mybidan/presentation/shop_control/controller/shop_control_controller.dart';

class DashboardBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(DashboardController());
    Get.put(EducationControlController());
    Get.put(KonsultasiControlController());
    Get.put(ShopControlController());
    Get.put(FindKlinikControlController());
  }
}
