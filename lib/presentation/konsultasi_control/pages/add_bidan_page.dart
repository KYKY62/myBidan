import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/components/custom_text_field.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/presentation/konsultasi_control/controller/konsultasi_control_controller.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class AddBidanPage extends StatelessWidget {
  final addBidanC = Get.find<KonsultasiControlController>();

  AddBidanPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget stackProfileBidan() {
      return Stack(
        children: [
          Stack(
            children: [
              const Column(
                children: [
                  SizedBox(
                    width: 88,
                    height: 108,
                  ),
                ],
              ),
              Positioned(
                top: 12,
                child: Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: AppColors.neon,
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                ),
              ),
              Obx(
                () => Positioned(
                  left: 8,
                  right: 8,
                  child: addBidanC.image.value != null
                      ? Image.memory(addBidanC.image.value!,
                          height: 98, fit: BoxFit.cover)
                      : const SizedBox(),
                ),
              )
            ],
          ),
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Tambah Data Bidan"),
          actions: const [],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      stackProfileBidan(),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => addBidanC.selectedImage(),
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Email Bidan",
                  style: CustomTextStyle.primaryText.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                CustomTextField(
                  padding: 0,
                  controller: addBidanC.emailController,
                  label: 'Email Bidan',
                  textStyle: CustomTextStyle.primaryText.copyWith(
                    color: Colors.grey,
                  ),
                  keyboardType: TextInputType.text,
                  inputColor: Colors.black,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Text(
                  "Password Akun",
                  style: CustomTextStyle.primaryText.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                CustomTextField(
                  padding: 0,
                  controller: addBidanC.passwordController,
                  label: 'Password',
                  textStyle: CustomTextStyle.primaryText.copyWith(
                    color: Colors.grey,
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  inputColor: Colors.black,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Text(
                  "Nama Bidan",
                  style: CustomTextStyle.primaryText.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                CustomTextField(
                  padding: 0,
                  controller: addBidanC.nameController,
                  label: 'Nama Bidan',
                  textStyle: CustomTextStyle.primaryText.copyWith(
                    color: Colors.grey,
                  ),
                  keyboardType: TextInputType.text,
                  inputColor: Colors.black,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Text(
                  "Specialist Bidan",
                  style: CustomTextStyle.primaryText.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                CustomTextField(
                  padding: 0,
                  controller: addBidanC.specialistController,
                  label: 'Specialist Bidan',
                  textStyle: CustomTextStyle.primaryText.copyWith(
                    color: Colors.grey,
                  ),
                  keyboardType: TextInputType.text,
                  inputColor: Colors.black,
                ),
                const SizedBox(height: 24),
                Text(
                  "Jam Kerja",
                  style: CustomTextStyle.primaryText.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TimePickerSpinnerPopUp(
                        mode: CupertinoDatePickerMode.time,
                        initTime: DateTime(2000, 1, 1, 0, 0),
                        onChange: (dateTime) {
                          Timestamp timestamp = Timestamp.fromDate(dateTime);
                          addBidanC.updateTimeAwal(timestamp);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "-",
                      style: CustomTextStyle.biggerText
                          .copyWith(color: Colors.black),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TimePickerSpinnerPopUp(
                        mode: CupertinoDatePickerMode.time,
                        initTime: DateTime(
                            DateTime.now().year, DateTime.now().month, 1, 0, 0),
                        onChange: (dateTime) {
                          Timestamp timestamp = Timestamp.fromDate(dateTime);
                          addBidanC.updateTimeAkhir(timestamp);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 49.0,
                ),
                addBidanC.loading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          fixedSize: Size.fromWidth(Get.width),
                        ),
                        onPressed: () => addBidanC.addBidan(),
                        child: Text(
                          'Tambah Data',
                          style: CustomTextStyle.primaryText.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ));
  }
}
