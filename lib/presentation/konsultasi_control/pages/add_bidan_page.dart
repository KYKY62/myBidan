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
                  "Gambar",
                  style: CustomTextStyle.primaryText.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        fixedSize: const Size.fromWidth(150),
                      ),
                      // onPressed: () => educationC.selectedImage(),
                      onPressed: () {},
                      child: Text(
                        'Upload Gambar',
                        style: CustomTextStyle.smallerText,
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    // educationC.image.value != null
                    //     ? const CircleAvatar(
                    //         radius: 15,
                    //         backgroundColor: Colors.green,
                    //         child: Icon(
                    //           Icons.check,
                    //           color: Colors.white,
                    //           size: 15,
                    //         ),
                    //       )
                    //     : const SizedBox(),
                  ],
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
                        initTime: DateTime(2000, 1, 1, 0, 0),
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
                        // onPressed: () => educationC.editOrAdd(),
                        onPressed: () {},
                        child: Text(
                          'GET STARTED',
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
