// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mybidan/core.dart';
import 'package:mybidan/data/models/settingadmin_model.dart';
import 'package:mybidan/presentation/setting_admin/controller/setting_admin_controller.dart';

class EditSettingAdmin extends StatelessWidget {
  final settingAdminC = Get.find<SettingAdminController>();
  final SettingadminModel data;
  EditSettingAdmin({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Kelola Admin"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: data.goals == 'informasi'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomEditSetting(
                      controller: settingAdminC.titleInformationController,
                      title: 'Judul Informasi',
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          fixedSize: Size.fromWidth(Get.width),
                        ),
                        onPressed: () => settingAdminC.editInformasi(data.doc!),
                        child: Obx(
                          () => Text(
                            settingAdminC.loading.value
                                ? 'Loading...'
                                : 'Edit Data',
                            style: CustomTextStyle.primaryText.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomEditSetting(
                      controller: data.rekeningBcaC!,
                      title: 'Rekening BCA',
                    ),
                    CustomEditSetting(
                      controller: data.rekeningBniC!,
                      title: 'Rekening BNI',
                    ),
                    CustomEditSetting(
                      controller: data.rekeningBsiC!,
                      title: 'Rekening BSI',
                    ),
                    CustomEditSetting(
                      controller: data.rekeningBriC!,
                      title: 'Rekening BRI',
                    ),
                    CustomEditSetting(
                      controller: data.rekeningMandiriC!,
                      title: 'Rekening Mandiri',
                    ),
                    CustomEditSetting(
                      controller: data.rekeningPermataC!,
                      title: 'Rekening Permata',
                    ),
                    CustomEditSetting(
                      controller: data.nomorTelepon!,
                      title: 'Nomor Telpon',
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          fixedSize: Size.fromWidth(Get.width),
                        ),
                        onPressed: () => settingAdminC.editAdmin(),
                        child: Obx(
                          () => Text(
                            settingAdminC.loading.value
                                ? 'Loading...'
                                : 'Edit Data',
                            style: CustomTextStyle.primaryText.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ],
                ),
        ),
      ),
    );
  }
}

class CustomEditSetting extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  const CustomEditSetting({
    super.key,
    required this.controller,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomTextStyle.primaryText.copyWith(
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 7.0,
          ),
          CustomTextField(
            padding: 0,
            controller: controller,
            label: '',
            textStyle: CustomTextStyle.primaryText.copyWith(
              color: Colors.grey,
            ),
            keyboardType: TextInputType.text,
            inputColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
