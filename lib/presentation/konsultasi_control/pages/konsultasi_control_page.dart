import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:mybidan/core.dart';

class KonsultasiControlPage extends StatelessWidget {
  final konsultasiC = Get.find<KonsultasiControlController>();
  KonsultasiControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: AppColors.primary,
    ));
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SizedBox(
        height: Get.height,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  "KONSULTASI",
                  style: CustomTextStyle.primaryText.copyWith(
                    color: Colors.white,
                  ),
                ),
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
                                    right: 20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Data lengkap bidan",
                                          style: CustomTextStyle.primaryText
                                              .copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              Get.toNamed(RouteName.addBidan)!
                                                  .then(
                                            (_) =>
                                                konsultasiC.clearController(),
                                          ),
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
                                    bottom: 0,
                                    left: 20,
                                    child: SizedBox(
                                      width: Get.width,
                                      height: 255,
                                      child: StreamBuilder(
                                          stream: konsultasiC.getBidan(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return Text(
                                                "Belum Ada Bidan",
                                                style: CustomTextStyle.bigText
                                                    .copyWith(
                                                  color: Colors.white,
                                                ),
                                              );
                                            }
                                            var bidanData = snapshot.data!.docs;
                                            return ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.only(
                                                  right: 40),
                                              itemCount: bidanData.length,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(width: 20),
                                              itemBuilder: (context, index) {
                                                Timestamp timeAwalstampConvert =
                                                    bidanData[index]
                                                        ['jamAwalKerja'];
                                                Timestamp
                                                    timeAkhirstampConvert =
                                                    bidanData[index]
                                                        ['jamAkhirKerja'];

                                                String dateTimeAwal =
                                                    timeAwalstampConvert
                                                        .toDate()
                                                        .toFormattedInHours();
                                                String dateTimeAkhir =
                                                    timeAkhirstampConvert
                                                        .toDate()
                                                        .toFormattedInHours();
                                                return CardDataBidan(
                                                  image: bidanData[index]
                                                      ['photoBidan'],
                                                  nameBidan: bidanData[index]
                                                      ['name'],
                                                  specialist: bidanData[index]
                                                      ['specialistBidan'],
                                                  timeOperational:
                                                      '$dateTimeAwal-$dateTimeAkhir',
                                                  onTap: () {},
                                                );
                                              },
                                            );
                                          }),
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
              // height: Get.height,
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
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Text(
                      "Transaksi",
                      style: CustomTextStyle.bigText,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // ! Transaksi
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Assets.icons.podiumSharp.path,
                                    width: 24,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Pemasukan",
                                    style: CustomTextStyle.primaryText.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  StreamBuilder<
                                      QuerySnapshot<Map<String, dynamic>>>(
                                    stream: konsultasiC.getListOrder(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text(
                                          int.parse('0').currencyFormatRp,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              CustomTextStyle.bigText.copyWith(
                                            color: Colors.white,
                                          ),
                                        );
                                      }
                                      int totalPemasukan = 0;
                                      if (snapshot.hasData) {
                                        for (var doc in snapshot.data!.docs) {
                                          totalPemasukan += int.parse(
                                            doc['harga'],
                                          );
                                        }
                                      }
                                      return Text(
                                        totalPemasukan.currencyFormatRp,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: CustomTextStyle.bigText.copyWith(
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.defaultDialog(
                                title: 'Update Harga Layanan',
                                middleText: "",
                                content: Column(
                                  children: [
                                    CustomTextField(
                                      controller:
                                          konsultasiC.hargaLayananController,
                                      label: 'Harga layanan',
                                      keyboardType: TextInputType.number,
                                      inputColor: Colors.black,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]'),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () =>
                                          konsultasiC.updateHargaLayanan(),
                                      child: Obx(
                                        () => Text(
                                          konsultasiC.loading.value
                                              ? "Loading..."
                                              : "Simpan",
                                          style: CustomTextStyle.primaryText
                                              .copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Harga Layanan",
                                      style:
                                          CustomTextStyle.smallerText.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Image.asset(
                                      Assets.icons.create.path,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                StreamBuilder<
                                        DocumentSnapshot<Map<String, dynamic>>>(
                                    stream: konsultasiC.getHargaLayanan(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text(
                                          int.parse('0').currencyFormatRp,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: CustomTextStyle.greenText
                                              .copyWith(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }
                                      var hargaLayanan = snapshot.data!.data();
                                      return Text(
                                        int.parse(hargaLayanan!['harga'])
                                            .currencyFormatRp,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style:
                                            CustomTextStyle.greenText.copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      Assets.images.metodePembayaran1.path,
                                      fit: BoxFit.cover,
                                    ),
                                    Image.asset(
                                      Assets.icons.create.path,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 29.0,
                    ),
                    Container(
                      width: Get.width,
                      height: 1,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Order",
                      style: CustomTextStyle.bigText,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: konsultasiC.getListOrder(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          var listOrder = snapshot.data!.docs;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listOrder.length,
                            itemBuilder: (context, index) {
                              return StreamBuilder<
                                      DocumentSnapshot<Map<String, dynamic>>>(
                                  stream: konsultasiC.getProfileUser(
                                    doc: listOrder[index]['emailUser'],
                                  ),
                                  builder: (context, snapshotProfile) {
                                    if (snapshotProfile.connectionState ==
                                        ConnectionState.waiting) {
                                      return const SizedBox();
                                    }
                                    var profileUser =
                                        snapshotProfile.data!.data();
                                    return ListOrder(
                                      image: profileUser!['photoUrl'],
                                      nameOrder: profileUser['name'],
                                      dateOrder: DateTime.parse(
                                              listOrder[index]['time'])
                                          .toFormattedTime(),
                                      isSuccess: listOrder[index]['isPremium'],
                                      pay: listOrder[index]['harga'],
                                      viewDoc: () => Get.defaultDialog(
                                        title: 'Bukti Pembayaran',
                                        middleText: '',
                                        content: SizedBox(
                                          height: 240,
                                          child: InstaImageViewer(
                                            child: Image.network(
                                              listOrder[index]
                                                  ['buktiPembayaran'],
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                } else {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  );
                                                }
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Icon(
                                                  Icons.error,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      updateStatus: () {
                                        listOrder[index]['isPremium']
                                            ? () {}
                                            : Get.defaultDialog(
                                                title: 'Ubah Status Transaksi',
                                                middleText:
                                                    'Status Transaksi "Pending"',
                                                textConfirm: 'Berhasil',
                                                textCancel: 'Batal',
                                                onConfirm: () => konsultasiC
                                                        .updateStatusTransaksi(
                                                      listOrder[index].id,
                                                    ),
                                                buttonColor: AppColors.primary,
                                                confirmTextColor: Colors.white);
                                      },
                                    );
                                  });
                            },
                          );
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
