import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/components/card_data_bidan.dart';
import 'package:mybidan/core/components/list_order.dart';

import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/core/extension/int_ext.dart';

class KonsultasiControlPage extends StatelessWidget {
  const KonsultasiControlPage({super.key});

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
                                    top: 59,
                                    left: 20,
                                    child: Text(
                                      "Data lengkap bidan",
                                      style:
                                          CustomTextStyle.primaryText.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 120,
                                    left: 20,
                                    child: SizedBox(
                                      width: Get.width,
                                      height: 255,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        padding:
                                            const EdgeInsets.only(right: 40),
                                        itemCount: 4,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(width: 20),
                                        itemBuilder: (context, index) {
                                          return CardDataBidan(
                                            image: Assets.images.bidan2.path,
                                            nameBidan: 'Dr. Intan erno',
                                            specialist: 'Dermatology & Leprosy',
                                            timeOperational: '13:00 - 13:00',
                                            onTap: () {},
                                          );
                                        },
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 171,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.icons.podiumSharp.path,
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
                              Text(
                                int.parse('4000').currencyFormatRp,
                                style: CustomTextStyle.bigText.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 27.0,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Harga Layanan",
                                    style: CustomTextStyle.smallerText.copyWith(
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
                              Text(
                                int.parse('120000').currencyFormatRp,
                                style: CustomTextStyle.greenText.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return ListOrder(
                          image: Assets.images.ronaldo.path,
                          nameOrder: 'C.Ronaldo do santos',
                          dateOrder: '15 Juni 2024',
                          isSuccess: false,
                          pay: '120000',
                        );
                      },
                    )
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
