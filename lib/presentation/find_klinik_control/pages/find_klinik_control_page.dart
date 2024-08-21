import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/components/card_find_klinik_control.dart';
import 'package:mybidan/core/components/custom_text_field.dart';
import 'package:mybidan/core/components/list_article.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/core/extension/date_time_ext.dart';
import 'package:mybidan/core/routes/route_name.dart';
import 'package:mybidan/presentation/find_klinik_control/controller/find_klinik_control_controller.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class FindKlinikControlPage extends StatelessWidget {
  final findBidanC = Get.find<FindKlinikControlController>();
  FindKlinikControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: AppColors.primary,
    ));

    Widget shortCutTextFormField(
        {required String title,
        required TextEditingController controller,
        required String hintLabel,
        TextInputType? keyboardType,
        List<TextInputFormatter>? inputFormatters}) {
      return Column(
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
            label: hintLabel,
            textStyle: CustomTextStyle.primaryText.copyWith(
              color: Colors.grey,
            ),
            keyboardType: keyboardType ?? TextInputType.text,
            inputColor: Colors.black,
            inputFormatters: inputFormatters ?? [],
          ),
        ],
      );
    }

    Widget shortCutMultiTextFrom({
      required String title,
      required TextEditingController controller,
      required String hintLabel,
    }) {
      return Column(
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
          TextFormField(
            controller: controller,
            minLines: 5,
            maxLines: null,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintStyle: CustomTextStyle.primaryText.copyWith(
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              hintText: hintLabel,
              fillColor: Colors.white,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          "KLINIK",
          style: CustomTextStyle.primaryText.copyWith(
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () => Get.offAllNamed(RouteName.login),
              child: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: Get.height,
        child: ListView(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 400,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Stack(
                        children: [
                          Column(
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
                                    child: Text(
                                      "Daftar Klinik",
                                      style:
                                          CustomTextStyle.primaryText.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 90,
                                    left: 20,
                                    child: SizedBox(
                                      width: Get.width,
                                      // height: 255,
                                      child: AspectRatio(
                                        aspectRatio: 0.9,
                                        child: StreamBuilder(
                                          stream: findBidanC.getKlinik(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return Text(
                                                "Data Klinik Belum Ada",
                                                style: CustomTextStyle.bigText
                                                    .copyWith(
                                                  color: Colors.white,
                                                ),
                                              );
                                            }
                                            var daftarKlinik =
                                                snapshot.data!.docs;

                                            return ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.only(
                                                  right: 30),
                                              itemCount: daftarKlinik.length,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(width: 20),
                                              itemBuilder: (context, index) {
                                                Timestamp timeAwalstampConvert =
                                                    daftarKlinik[index]
                                                        ['jamAwalKerja'];
                                                Timestamp
                                                    timeAkhirstampConvert =
                                                    daftarKlinik[index]
                                                        ['jamAkhirKerja'];

                                                String dateTimeAwal =
                                                    timeAwalstampConvert
                                                        .toDate()
                                                        .toFormattedInHours();
                                                String dateTimeAkhir =
                                                    timeAkhirstampConvert
                                                        .toDate()
                                                        .toFormattedInHours();

                                                return CardFindKlinikControl(
                                                  namaKlinik:
                                                      daftarKlinik[index]
                                                          ['namaKlinik'],
                                                  namaBidan: daftarKlinik[index]
                                                      ['namaBidan'],
                                                  jamKerja:
                                                      "$dateTimeAwal - $dateTimeAkhir",
                                                  photo: daftarKlinik[index]
                                                      ['photo'],
                                                  alamat: daftarKlinik[index]
                                                      ['alamat'],
                                                  telepon: daftarKlinik[index]
                                                      ['telepon'],
                                                  jamPraktek:
                                                      daftarKlinik[index]
                                                          ['jamPraktek'],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 36),
                child: Obx(
                  () => ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Manajement Klinik",
                            style: CustomTextStyle.bigText,
                          ),
                          GestureDetector(
                            onTap: () {
                              findBidanC.isEdit.value = false;
                              findBidanC.isAddingKlinik.value =
                                  !findBidanC.isAddingKlinik.value;
                              findBidanC.image.value = null;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: AppColors.primary,
                                ),
                              ),
                              child: findBidanC.isAddingKlinik.value
                                  ? const Icon(
                                      Icons.keyboard_arrow_left_outlined)
                                  : const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      findBidanC.isAddingKlinik.value
                          // ! ADD BLOG
                          ? SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  shortCutTextFormField(
                                    title: 'Nama Klinik',
                                    controller: findBidanC.namaKlinikController,
                                    hintLabel: 'Nama Klinik',
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
                                  Obx(
                                    () => Row(
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            fixedSize:
                                                const Size.fromWidth(150),
                                          ),
                                          onPressed: () =>
                                              findBidanC.selectedImage(),
                                          child: Text(
                                            'Upload Gambar',
                                            style: CustomTextStyle.smallerText,
                                          ),
                                        ),
                                        const SizedBox(width: 20.0),
                                        findBidanC.image.value != null
                                            ? const CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.green,
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24.0,
                                  ),
                                  shortCutTextFormField(
                                    title: 'Nama Bidan',
                                    controller: findBidanC.namaBidanController,
                                    hintLabel: 'Nama Bidan',
                                  ),
                                  const SizedBox(
                                    height: 24.0,
                                  ),
                                  shortCutMultiTextFrom(
                                    title: 'Alamat',
                                    controller: findBidanC.alamatController,
                                    hintLabel: 'Alamat',
                                  ),
                                  const SizedBox(height: 24),
                                  shortCutTextFormField(
                                    title: 'Telepon',
                                    controller: findBidanC.teleponController,
                                    hintLabel: 'Telepon(diawali 62)',
                                  ),
                                  const SizedBox(height: 24),
                                  shortCutTextFormField(
                                    title: 'Link Google Map',
                                    controller:
                                        findBidanC.linkGoogleMapController,
                                    hintLabel: 'Link Google Map',
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
                                  Obx(
                                    () => Row(
                                      children: [
                                        Expanded(
                                          child: TimePickerSpinnerPopUp(
                                            mode: CupertinoDatePickerMode.time,
                                            initTime: findBidanC.isEdit.value
                                                ? findBidanC
                                                    .selectedTimeAwal.value
                                                    .toDate()
                                                : DateTime(2000, 1, 1, 0, 0),
                                            onChange: (dateTime) {
                                              Timestamp timestamp =
                                                  Timestamp.fromDate(dateTime);
                                              findBidanC
                                                  .updateTimeAwal(timestamp);
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
                                            initTime: findBidanC.isEdit.value
                                                ? findBidanC
                                                    .selectedTimeAkhir.value
                                                    .toDate()
                                                : DateTime(2000, 1, 1, 0, 0),
                                            onChange: (dateTime) {
                                              Timestamp timestamp =
                                                  Timestamp.fromDate(dateTime);
                                              findBidanC
                                                  .updateTimeAkhir(timestamp);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  shortCutMultiTextFrom(
                                    title: 'Jam Praktek',
                                    controller: findBidanC.jamPraktekController,
                                    hintLabel: 'Hari-Jam Praktek',
                                  ),
                                  const SizedBox(
                                    height: 49.0,
                                  ),
                                  findBidanC.loading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            fixedSize:
                                                Size.fromWidth(Get.width),
                                          ),
                                          onPressed: () =>
                                              findBidanC.editOrAdd(),
                                          child: Text(
                                            'GET STARTED',
                                            style: CustomTextStyle.primaryText
                                                .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            )
                          : StreamBuilder(
                              stream: findBidanC.getKlinik(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.docs.isEmpty) {
                                  return SizedBox(
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Data Klinik Belum Ada",
                                          style: CustomTextStyle.bigText,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                var produkData = snapshot.data!.docs;
// nampilkan data
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: produkData.length,
                                  itemBuilder: (context, index) {
                                    dynamic onTapEdits() {
                                      findBidanC.doc = produkData[index].id;
                                      findBidanC.namaKlinikController.text =
                                          produkData[index]['namaKlinik'];
                                      findBidanC.namaBidanController.text =
                                          produkData[index]['namaBidan'];
                                      findBidanC.teleponController.text =
                                          produkData[index]['telepon'];
                                      findBidanC.linkGoogleMapController.text =
                                          produkData[index]['map'];
                                      findBidanC.alamatController.text =
                                          produkData[index]['alamat'];
                                      findBidanC.jamPraktekController.text =
                                          produkData[index]['jamPraktek'];
                                      findBidanC.selectedTimeAwal.value =
                                          produkData[index]['jamAwalKerja'];
                                      findBidanC.selectedTimeAkhir.value =
                                          produkData[index]['jamAkhirKerja'];
                                      findBidanC.isEdit.value = true;
                                      findBidanC.isAddingKlinik.value =
                                          !findBidanC.isAddingKlinik.value;
                                    }

                                    return produkData.length == 1
                                        ? SizedBox(
                                            height: 150,
                                            child: Column(
                                              children: [
                                                ListArticle(
                                                  photo: produkData[index]
                                                      ['photo'],
                                                  nameArticle: produkData[index]
                                                      ['namaKlinik'],
                                                  onTapEdit: () => onTapEdits(),
                                                  onTapDelete: () =>
                                                      findBidanC.deleteArticle(
                                                    doc: produkData[index].id,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : ListArticle(
                                            photo: produkData[index]['photo'],
                                            nameArticle: produkData[index]
                                                ['namaKlinik'],
                                            onTapEdit: () => onTapEdits(),
                                            onTapDelete: () =>
                                                findBidanC.deleteArticle(
                                              doc: produkData[index].id,
                                            ),
                                          );
                                  },
                                );
                              },
                            )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
