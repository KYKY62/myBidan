import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core.dart';
import 'package:mybidan/presentation/bidan/controller/bidan_controller.dart';

class BidanPage extends StatelessWidget {
  final bidanC = Get.find<BidanController>();
  final authC = Get.find<LoginController>();

  BidanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bidan"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () =>
                    bidanC.addNewConnection(bidanEmail: 'testing@gmail.com'),
                child: const Text("Save"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => authC.logOut(),
                child: const Text("Keluar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
