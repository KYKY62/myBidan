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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customEditSetting(
                  controller: data.rekeningBcaC,
                  title: 'Rekening BCA',
                ),
                customEditSetting(
                  controller: data.rekeningBniC,
                  title: 'Rekening BNI',
                ),
                customEditSetting(
                  controller: data.rekeningBsiC,
                  title: 'Rekening BSI',
                ),
                customEditSetting(
                  controller: data.rekeningMandiriC,
                  title: 'Rekening Mandiri',
                ),
                customEditSetting(
                  controller: data.rekeningPermataC,
                  title: 'Rekening Permata',
                ),
                customEditSetting(
                  controller: data.nomorTelepon,
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
                            : 'Tambah Data',
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
      ),
    );
  }
}

class customEditSetting extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  const customEditSetting({
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
