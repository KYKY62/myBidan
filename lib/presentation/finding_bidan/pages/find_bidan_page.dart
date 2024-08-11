import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:mybidan/core/components/custom_card.dart';
import 'package:mybidan/core/components/custom_text_field.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/core/extension/date_time_ext.dart';
import 'package:mybidan/presentation/finding_bidan/controller/find_bidan_controller.dart';
import 'package:mybidan/presentation/finding_bidan/pages/detail_praktik.dart';

class FindBidanPage extends StatelessWidget {
  final findBidanC = Get.put(FindBidanController());

  FindBidanPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: const Color(0xffD6F5F0),
        body: ListView(
          children: [
            SizedBox(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                        child: Image.asset(
                          Assets.images.backgroundHome.path,
                          fit: BoxFit.fitWidth,
                          width: Get.width,
                          height: 200,
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 20,
                        child: Text(
                          "Klinik Bidan Terdekat",
                          style: CustomTextStyle.bigText.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 58,
                        left: 20,
                        child: Text(
                          "Temukan klinik di samping anda",
                          style: CustomTextStyle.smText,
                        ),
                      ),
                      Positioned(
                        top: 84,
                        left: 8,
                        right: 8,
                        child: SizedBox(
                          width: 370,
                          child: CustomTextField(
                            controller: findBidanC.searchBidan,
                            label: 'Cari bidan terdekat',
                            keyboardType: TextInputType.text,
                            inputColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            textStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Obx(() {
              return findBidanC.detailObject.value != null
                  ? DetailPraktikPage(
                      klinikData: findBidanC.detailObject.value,
                    )
                  : Stack(
                      children: [
                        Image.asset(
                          Assets.images.mapPattern.path,
                          fit: BoxFit.fill,
                          width: Get.width,
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.neon,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 20),
                            child: StreamBuilder(
                              stream: findBidanC.getKlinik(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.docs.isEmpty) {
                                  return Text(
                                    "Data Klinik Belum Ada",
                                    style: CustomTextStyle.bigText.copyWith(
                                      color: Colors.white,
                                    ),
                                  );
                                }
                                var daftarKlinik = snapshot.data!.docs;
                                return ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: daftarKlinik.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 16.0,
                                  ),
                                  itemBuilder: (context, index) {
                                    Timestamp timeAwalstampConvert =
                                        daftarKlinik[index]['jamAwalKerja'];
                                    Timestamp timeAkhirstampConvert =
                                        daftarKlinik[index]['jamAkhirKerja'];

                                    String dateTimeAwal = timeAwalstampConvert
                                        .toDate()
                                        .toFormattedInHours();
                                    String dateTimeAkhir = timeAkhirstampConvert
                                        .toDate()
                                        .toFormattedInHours();

                                    return GestureDetector(
                                      onTap: () {
                                        findBidanC.selectedObject.value =
                                            !findBidanC.selectedObject.value;
                                        findBidanC.detailObject.value =
                                            daftarKlinik[index];
                                      },
                                      child: CustomCard(
                                        name: daftarKlinik[index]['namaKlinik'],
                                        description: daftarKlinik[index]
                                            ['namaBidan'],
                                        dateOperational:
                                            DateTime.now().toFormattedTime(),
                                        timeOperational:
                                            "$dateTimeAwal - $dateTimeAkhir",
                                        image: daftarKlinik[index]['photo'],
                                        horizontalGap: 25,
                                        findBidanPage: true,
                                        backgroundColor:
                                            const Color(0xfff5faf6),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    );
            })
          ],
        ),
      ),
    );
  }
}
