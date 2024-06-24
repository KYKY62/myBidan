import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/components/custom_text_field.dart';
import 'package:mybidan/core/components/small_card.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/presentation/home/controller/home_controller.dart';

class HomePage extends StatelessWidget {
  final homeC = Get.put(HomeController());
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
      // stack dibody agar bisa di timpa
      body: SizedBox(
        height: Get.height,
        child: ListView(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 510,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Stack(
                        children: [
                          // Alas Stack Pertama agar widget kedua bisa menimpa
                          Column(
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                    Assets.images.backgroundHome.path,
                                    fit: BoxFit.fill,
                                    width: Get.width,
                                  ),
                                  const Positioned(
                                    top: 49,
                                    left: 20,
                                    child: Text(
                                      "Pagi yang cerah, semoga hari ini penuh keceriaan.",
                                      style: CustomTextStyle.smText,
                                    ),
                                  ),
                                  const Positioned(
                                    top: 68,
                                    left: 20,
                                    child: Text(
                                      "Hi Syela, Apa kabar?",
                                      style: CustomTextStyle.biggerText,
                                    ),
                                  ),
                                  Positioned(
                                    top: 115,
                                    left: 8,
                                    child: SizedBox(
                                      width: 339,
                                      child: CustomTextField(
                                        controller: homeC.searchDoctor,
                                        label: 'Search Doctor or Symptoms',
                                        keyboardType: TextInputType.text,
                                        prefixIcon: const Icon(
                                          Icons.search,
                                          size: 24.0,
                                          color: Colors.grey,
                                        ),
                                        textStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 211,
                                    left: 20,
                                    child: SizedBox(
                                      width: 336,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SmallCard(
                                            padding: const EdgeInsets.all(18),
                                            icon: Assets.icons.chat.path,
                                            label: 'Konsultasi',
                                          ),
                                          SmallCard(
                                            padding: const EdgeInsets.all(18),
                                            icon: Assets.icons.map.path,
                                            label: 'Maps',
                                          ),
                                          SmallCard(
                                            padding: const EdgeInsets.all(18),
                                            icon: Assets.icons.education.path,
                                            label: 'Edukasi',
                                          ),
                                          SmallCard(
                                            padding: const EdgeInsets.all(18),
                                            icon: Assets.icons.cart.path,
                                            label: 'E-commerce',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Alas stack kedua menimpa widget pertama pada iniasiasi stack
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 320,
                  left: 10,
                  right: 10,
                  child: Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 4,
                        itemBuilder: (context, index, realIndex) {
                          return SizedBox(
                            height: 150,
                            child: Card(
                              color: AppColors.neon,
                              child: Row(
                                children: [
                                  Image.asset(Assets.images.doctor.path),
                                  SizedBox(
                                    width: 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Dapatkan Informasi Kesehatan Secara Gratis",
                                          style: CustomTextStyle.greenText
                                              .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        SizedBox(
                                          height: 29,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Selengkapnya",
                                              style: CustomTextStyle.smText
                                                  .copyWith(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 150,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          aspectRatio: 2.0,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) =>
                              homeC.currentIndex.value = index,
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
                            return Obx(() => Container(
                                  width: 6,
                                  height: 6,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: homeC.currentIndex.value == index
                                        ? Colors.black
                                        : Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Card(
              color: Colors.red,
              child: SizedBox(
                height: 100, // Adjust the height as needed
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          Assets.images.circleBg.path,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Card(
              color: Colors.red,
              child: SizedBox(
                height: 100, // Adjust the height as needed
                child: Center(
                  child: Text(
                    'This is a card',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.red,
              child: SizedBox(
                height: 100, // Adjust the height as needed
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          Assets.images.circleBg.path,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
