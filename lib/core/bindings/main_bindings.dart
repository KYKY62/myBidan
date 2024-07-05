import 'package:get/get.dart';
import 'package:mybidan/presentation/chat/controller/chat_controller.dart';
import 'package:mybidan/presentation/finding_bidan/controller/find_bidan_controller.dart';
import 'package:mybidan/presentation/home/controller/main_controller.dart';

class MainBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    Get.put(FindBidanController());
    Get.put(ChatController());
  }
}
