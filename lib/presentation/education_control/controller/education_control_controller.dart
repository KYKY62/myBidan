import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationControlController extends GetxController {
  RxBool isAdding = false.obs;

  final TextEditingController judulController = TextEditingController();
  final TextEditingController blogContentController = TextEditingController();

  void clearTextControllers() {
    judulController.clear();
    blogContentController.clear();
  }

  @override
  void onInit() {
    super.onInit();
    ever(isAdding, (bool adding) {
      if (!adding) {
        clearTextControllers();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    judulController.dispose();
  }
}
