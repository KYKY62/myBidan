import 'package:get/get.dart';
import 'package:mybidan/presentation/bidan/controller/bidan_controller.dart';

class BidanBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(BidanController());
  }
}
