import 'package:get/get.dart';
import 'package:mybidan/presentation/dashboard/controller/dashboard_controller.dart';

class DashboardBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}
