import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/presentation/shop/controller/shop_controller.dart';

class ShopPage extends StatelessWidget {
  final shopC = Get.put(ShopController());
  ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 34.0,
          ),
          CarouselSlider.builder(
            itemCount: 4,
            itemBuilder: (context, index, realIndex) {
              return SizedBox(
                height: 150,
                child: Card(
                  color: AppColors.primary,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "FLASH SALE",
                                style: CustomTextStyle.biggerText.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Discount up to",
                                style: CustomTextStyle.smText,
                              ),
                              Text(
                                "80 %",
                                style: CustomTextStyle.biggerText.copyWith(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "*Term and Conditions",
                                style: CustomTextStyle.smText.copyWith(
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                          topLeft: Radius.circular(75),
                          bottomLeft: Radius.circular(75),
                        ),
                        child: Image.asset(
                          Assets.images.product.path,
                          fit: BoxFit.cover,
                          height: Get.height,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 160,
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) =>
                  shopC.currentIndex.value = index,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
              (index) {
                return Obx(
                  () => Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: shopC.currentIndex.value == index
                          ? Colors.black
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 28.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Kesehatan untuk kamu',
              style: CustomTextStyle.primaryText
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            width: 200,
            height: 200,
            color: Colors.amber,
            child: Stack(
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(Assets.images.product.path),
                ),
                Positioned(
                  top: 120,
                  left: 20,
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
