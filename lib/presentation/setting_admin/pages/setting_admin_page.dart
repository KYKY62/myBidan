import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core.dart';
import 'package:mybidan/data/models/settingadmin_model.dart';
import 'package:mybidan/presentation/setting_admin/controller/setting_admin_controller.dart';
import 'package:mybidan/presentation/setting_admin/widgets/row_container_admin.dart';

class SettingAdminPage extends StatelessWidget {
  final settingAdminC = Get.put(SettingAdminController());
  SettingAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: AppColors.primary,
    ));
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(
                  "Pengaturan Admin",
                  style: CustomTextStyle.primaryText.copyWith(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => settingAdminC.logOut(),
                    child: const Icon(
                      Icons.exit_to_app,
                      size: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              SizedBox(
                height: 400,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Stack(
                      children: [
                        StreamBuilder<DocumentSnapshot>(
                            stream: settingAdminC.settingAdmin(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if ((snapshot.data!.data()
                                      as Map<String, dynamic>)
                                  .isEmpty) {
                                return const Center(
                                  child:
                                      Text("Data tidak ditemukan atau kosong"),
                                );
                              }

                              var setting =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image.asset(
                                        Assets.images.backgroundHome.path,
                                        fit: BoxFit.fill,
                                        width: Get.width,
                                      ),
                                      Positioned(
                                        top: 39,
                                        left: 20,
                                        right: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Kelola Rekening &\nPusat Dukungan",
                                              style: CustomTextStyle.primaryText
                                                  .copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                settingAdminC
                                                        .rekeningBCAController
                                                        .text =
                                                    setting['account_bca'];
                                                settingAdminC
                                                        .rekeningBNIController
                                                        .text =
                                                    setting['account_bni'];
                                                settingAdminC
                                                        .rekeningBSIController
                                                        .text =
                                                    setting['account_bsi'];
                                                settingAdminC
                                                        .rekeningMandiriController
                                                        .text =
                                                    setting['account_mandiri'];
                                                settingAdminC
                                                        .rekeningPermataController
                                                        .text =
                                                    setting['account_permata'];
                                                settingAdminC
                                                    .nomorTeleponController
                                                    .text = setting['telepon'];
                                                SettingadminModel data =
                                                    SettingadminModel(
                                                  rekeningBcaC: settingAdminC
                                                      .rekeningBCAController,
                                                  rekeningBniC: settingAdminC
                                                      .rekeningBNIController,
                                                  rekeningBriC: settingAdminC
                                                      .rekeningBRIController,
                                                  rekeningBsiC: settingAdminC
                                                      .rekeningBSIController,
                                                  rekeningMandiriC: settingAdminC
                                                      .rekeningMandiriController,
                                                  rekeningPermataC: settingAdminC
                                                      .rekeningPermataController,
                                                  nomorTelepon: settingAdminC
                                                      .nomorTeleponController,
                                                );
                                                Get.toNamed(
                                                  RouteName.editSettingAdmin,
                                                  arguments: data,
                                                );
                                              },
                                              child: const CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 109,
                                        bottom: 0,
                                        left: 20,
                                        right: 20,
                                        child: SizedBox(
                                          width: Get.width,
                                          height: 255,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RowContainerAdmin(
                                                title: 'Rekening BCA',
                                                subTitle:
                                                    setting['account_bca'],
                                              ),
                                              RowContainerAdmin(
                                                title: 'Rekening BNI',
                                                subTitle:
                                                    setting['account_bni'],
                                              ),
                                              RowContainerAdmin(
                                                title: 'Rekening BRI',
                                                subTitle:
                                                    setting['account_bri'],
                                              ),
                                              RowContainerAdmin(
                                                title: 'Rekening BSI',
                                                subTitle:
                                                    setting['account_bsi'],
                                              ),
                                              RowContainerAdmin(
                                                title: 'Rekening Mandiri',
                                                subTitle:
                                                    setting['account_mandiri'],
                                              ),
                                              RowContainerAdmin(
                                                title: 'Rekening Permata',
                                                subTitle:
                                                    setting['account_permata'],
                                              ),
                                              RowContainerAdmin(
                                                title: 'Pusat Dukungan',
                                                subTitle: setting['telepon'],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
