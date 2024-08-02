import 'package:get/get.dart';
import 'package:mybidan/presentation/dashboard/controller/dashboard_controller.dart';
import 'package:mybidan/presentation/education_control/controller/education_control_controller.dart';
import 'package:mybidan/presentation/konsultasi_control/controller/konsultasi_control_controller.dart';
import 'package:mybidan/presentation/shop_control/controller/shop_control_controller.dart';

class DashboardBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(EducationControlController());
    Get.put(KonsultasiControlController());
    Get.put(ShopControlController());
  }
}
