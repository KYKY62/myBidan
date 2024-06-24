import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TextEditingController searchDoctor = TextEditingController();

  RxInt currentIndex = 0.obs;
}
