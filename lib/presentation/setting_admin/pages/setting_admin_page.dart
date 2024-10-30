import 'package:carousel_slider/carousel_slider.dart';
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
                height: 320,
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
                                              "Kelola Rekening &\nNomor Telepon",
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
                                                        .rekeningBRIController
                                                        .text =
                                                    setting['account_bri'];
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
                                                  goals: 'kelola',
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
                                                title: 'Nomor Telepon',
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kelola Informasi",
                  style: CustomTextStyle.primaryText.copyWith(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    SettingadminModel data =
                        SettingadminModel(goals: 'informasi');
                    Get.toNamed(RouteName.editSettingAdmin, arguments: data)!
                        .then((value) => settingAdminC.clearController());
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
          StreamBuilder<QuerySnapshot>(
              stream: settingAdminC.getIklan(),
              builder: (context, snapshotIklan) {
                if (snapshotIklan.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                var iklan = snapshotIklan.data!.docs;
                return Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: iklan.length,
                      itemBuilder: (context, index, realIndex) {
                        return Stack(
                          children: [
                            SizedBox(
                              height: 150,
                              child: Card(
                                color: AppColors.neon,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      Assets.images.doctor.path,
                                    ),
                                    SizedBox(
                                      width: 160,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 8),
                                          Text(
                                            iklan[index]['title'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: CustomTextStyle.greenText
                                                .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () => settingAdminC
                                        .deleteInformation(iklan[index].id),
                                    child: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () {
                                      SettingadminModel data =
                                          SettingadminModel(
                                              goals: 'informasi',
                                              doc: iklan[index].id);
                                      settingAdminC.titleInformationController
                                          .text = iklan[index]['title'];
                                      Get.toNamed(
                                        RouteName.editSettingAdmin,
                                        arguments: data,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                      options: CarouselOptions(
                        height: 150,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        aspectRatio: 2.0,
                        enableInfiniteScroll: false,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) =>
                            settingAdminC.currentIndex.value = index,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        iklan.length,
                        (index) {
                          return Obx(
                            () => Container(
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: settingAdminC.currentIndex.value == index
                                    ? Colors.white
                                    : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              }),
        ],
      ),
    );
  }
}
