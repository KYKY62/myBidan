import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/core/extension/int_ext.dart';
import 'package:mybidan/presentation/shop/controller/detail_product_controller.dart';

class DetailProductPage extends StatelessWidget {
  final detailProductC = Get.find<DetailProductController>();

  final String image;
  final String title;
  final String type;
  final String discountPrice;
  final String normalPrice;
  final String textDesc;
  final String textBahan;

  DetailProductPage(
      {super.key,
      required this.title,
      required this.type,
      required this.discountPrice,
      required this.normalPrice,
      required this.textDesc,
      required this.textBahan,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: Container(
          width: 319,
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Beli Sekarang",
              style: CustomTextStyle.bigText.copyWith(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SizedBox(
        height: Get.height,
        child: ListView(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 550,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            image,
                            width: Get.width,
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            top: 32,
                            left: 32,
                            child: GestureDetector(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 410,
                  child: Container(
                    width: Get.width,
                    // height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 28.0),
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: CustomTextStyle.primaryText.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            type,
                            style: CustomTextStyle.smallerText.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      int.parse(discountPrice).currencyFormatRp,
                                      style: CustomTextStyle.greenText.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      int.parse(normalPrice).currencyFormatRp,
                                      style:
                                          CustomTextStyle.smallerText.copyWith(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: Get.width,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Obx(
                () => Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        detailProductC.isSelectedIndex.value = 0;
                      },
                      child: SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            Text(
                              "Deskripsi",
                              style: CustomTextStyle.primaryText.copyWith(
                                fontWeight: FontWeight.w600,
                                color: detailProductC.isSelectedIndex.value == 0
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              width: Get.width,
                              height: 4,
                              color: detailProductC.isSelectedIndex.value == 0
                                  ? AppColors.primary
                                  : Colors.grey.shade300,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        detailProductC.isSelectedIndex.value = 1;
                      },
                      child: SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            Text(
                              "Bahan",
                              style: CustomTextStyle.primaryText.copyWith(
                                fontWeight: FontWeight.w600,
                                color: detailProductC.isSelectedIndex.value == 1
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              width: Get.width,
                              height: 4,
                              color: detailProductC.isSelectedIndex.value == 1
                                  ? AppColors.primary
                                  : Colors.grey.shade300,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Obx(
                () => Text(
                  detailProductC.isSelectedIndex.value == 0
                      ? textDesc
                      : textBahan,
                ),
              ),
            ),
            const SizedBox(
              height: 180.0,
            ),
          ],
        ),
      ),
    );
  }
}
