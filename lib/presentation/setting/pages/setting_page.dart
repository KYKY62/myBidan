import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core.dart';
import 'package:flutter/services.dart';
import 'package:mybidan/presentation/setting/controller/setting_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  final settingC = Get.put(SettingController());
  final authC = Get.put(LoginController());
  SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> launchWhatsApp({
      required String phoneNumber,
    }) async {
      final url = "https://wa.me/$phoneNumber";
      if (!await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.primary,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarDividerColor: AppColors.primary,
          ),
        ),
        body: ListView(
          children: [
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: settingC.getProfileUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var dataUser = snapshot.data!.data();
                  return SizedBox(
                    height: Get.height,
                    child: Stack(
                      children: [
                        SizedBox(
                          child: Stack(
                            children: [
                              Container(
                                width: Get.width,
                                height: 350,
                                decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30),
                                          child: CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                              dataUser!['photoUrl'],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.defaultDialog(
                                                title: 'Ubah Profile',
                                                content: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () => settingC
                                                          .selectedImage(),
                                                      child: Obx(
                                                        () => CircleAvatar(
                                                          radius: 50,
                                                          backgroundImage: settingC
                                                                      .image
                                                                      .value !=
                                                                  null
                                                              ? MemoryImage(
                                                                  settingC.image
                                                                      .value!,
                                                                )
                                                              : NetworkImage(
                                                                  dataUser[
                                                                      'photoUrl'],
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                    CustomTextField(
                                                      controller: settingC
                                                          .nameController,
                                                      label: 'Nama',
                                                      keyboardType:
                                                          TextInputType.text,
                                                      inputColor: Colors.black,
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            AppColors.primary,
                                                        foregroundColor:
                                                            Colors.white,
                                                      ),
                                                      onPressed: () =>
                                                          settingC.updateUser(
                                                        dataUser['photoUrl'],
                                                      ),
                                                      child: Text(
                                                        "Simpan",
                                                        style: CustomTextStyle
                                                            .primaryText
                                                            .copyWith(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ).then(
                                                (value) {
                                                  settingC.nameController
                                                      .clear();
                                                  settingC.image.value = null;
                                                },
                                              );
                                            },
                                            child: const Icon(
                                              Icons.edit,
                                              size: 24.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      '${dataUser['name']}'.capitalize!,
                                      style:
                                          CustomTextStyle.primaryText.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      dataUser['email'],
                                      style: CustomTextStyle.smallerText,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 190,
                                left: 26,
                                right: 26,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  width: Get.width,
                                  height: 60,
                                  child: CardSetting(
                                    onTap: () =>
                                        Get.toNamed(RouteName.informasiAkun),
                                    icon: Assets.icons.infoAccount.path,
                                    title: 'Informasi akun',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 270,
                          left: 26,
                          right: 26,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            width: Get.width,
                            height: 260,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 22.0,
                                ),
                                StreamBuilder<
                                        DocumentSnapshot<Map<String, dynamic>>>(
                                    stream: dataUser['uidKlinik'] != ''
                                        ? settingC.getKlinikUser(
                                            dataUser['uidKlinik'])
                                        : null,
                                    builder: (context, snapshotKlinik) {
                                      if (snapshotKlinik.connectionState ==
                                          ConnectionState.waiting) {
                                        return CardSetting(
                                          onTap: () {},
                                          icon: Assets.icons.pusatDukungan.path,
                                          title: 'Pusat dukungann',
                                        );
                                      }
                                      // jika uidKlinik kosong
                                      if (dataUser['uidKlinik'] == '') {
                                        return CardSetting(
                                          onTap: () => Get.defaultDialog(
                                            title:
                                                'Panic Button Belum Tersedia',
                                            middleText:
                                                'Atur terlebih dahulu rujukan klinik cepat pada informasi akun',
                                          ),
                                          icon: Assets.icons.pusatDukungan.path,
                                          title: 'Pusat dukungann',
                                        );
                                      }

                                      var dataKlinik =
                                          snapshotKlinik.data!.data();
                                      return CardSetting(
                                        onTap: () => launchWhatsApp(
                                            phoneNumber:
                                                dataKlinik!['telepon']),
                                        icon: Assets.icons.pusatDukungan.path,
                                        title: 'Pusat dukungann',
                                      );
                                    }),
                                const SizedBox(
                                  height: 22.0,
                                ),
                                CardSetting(
                                  onTap: () =>
                                      Get.toNamed(RouteName.termsConditions),
                                  icon: Assets.icons.terms.path,
                                  title: 'Syarat dan ketentuan',
                                ),
                                const SizedBox(
                                  height: 22.0,
                                ),
                                CardSetting(
                                  onTap: () =>
                                      Get.toNamed(RouteName.privacyPolicy),
                                  icon: Assets.icons.private.path,
                                  title: 'Privasi dan kebijakan',
                                ),
                                const Expanded(
                                  child: SizedBox(
                                    height: 22.0,
                                  ),
                                ),
                                CardSetting(
                                  onTap: () => authC.logOut(),
                                  icon: Assets.icons.logout.path,
                                  title: 'Log out account',
                                ),
                                const SizedBox(
                                  height: 22.0,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
