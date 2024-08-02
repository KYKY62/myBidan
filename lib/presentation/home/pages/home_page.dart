import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/components/custom_card.dart';
import 'package:mybidan/core/components/custom_card_education.dart';
import 'package:mybidan/core/components/custom_text_field.dart';
import 'package:mybidan/core/components/section_header.dart';
import 'package:mybidan/core/components/small_card.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/core/extension/date_time_ext.dart';
import 'package:mybidan/data/models/article_model.dart';
import 'package:mybidan/presentation/blog/controller/blog_controller.dart';
import 'package:mybidan/presentation/home/controller/home_controller.dart';
import 'package:mybidan/presentation/home/controller/main_controller.dart';

class HomePage extends StatelessWidget {
  final homeC = Get.put(HomeController());
  final mainC = Get.find<MainController>();
  final blogC = Get.find<ArticleController>();
  HomePage({super.key});

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
        body: SizedBox(
          height: Get.height,
          child: ListView(
            children: [
              Stack(
                children: [
                  // sizebox ini sebagai alas agar bisa ditimpa
                  SizedBox(
                    height: 510,
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
                                      top: 49,
                                      left: 20,
                                      child: Text(
                                        "Pagi yang cerah, semoga hari ini penuh keceriaan.",
                                        style: CustomTextStyle.smText,
                                      ),
                                    ),
                                    Positioned(
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
                                      right: 8,
                                      child: SizedBox(
                                        width: 370,
                                        child: CustomTextField(
                                          controller: homeC.searchDoctor,
                                          label: 'Search Doctor or Symptoms',
                                          keyboardType: TextInputType.text,
                                          inputColor: Colors.white,
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
                                      right: 20,
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
                  // widget yang menimpa nya
                  Positioned(
                    top: 320,
                    left: 5,
                    right: 5,
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
                                      width: 160,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Dapatkan Informasi Kesehatan Secara Gratis",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
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
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.bold,
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
                              return Obx(
                                () => Container(
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
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // ?? Layanan Konsultasi
              SectionHeader(
                title: "Layanan Konsultasi",
                onTap: () {},
              ),
              StreamBuilder(
                  stream: homeC.getBidan(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Text(
                        "Belum Ada Bidan",
                        style: CustomTextStyle.bigText.copyWith(
                          color: Colors.white,
                        ),
                      );
                    }
                    var bidanData = snapshot.data!.docs;
                    return CarouselSlider.builder(
                      itemCount: bidanData.length,
                      itemBuilder: (context, index, realIndex) {
                        Timestamp timeAwalstampConvert =
                            bidanData[index]['jamAwalKerja'];
                        Timestamp timeAkhirstampConvert =
                            bidanData[index]['jamAkhirKerja'];

                        String dateTimeAwal =
                            timeAwalstampConvert.toDate().toFormattedInHours();
                        String dateTimeAkhir =
                            timeAkhirstampConvert.toDate().toFormattedInHours();
                        return CustomCard(
                          name: bidanData[index]['name'],
                          description: bidanData[index]['specialistBidan'],
                          dateOperational: DateTime.now().toFormattedTime(),
                          timeOperational: "$dateTimeAwal - $dateTimeAkhir",
                          image: bidanData[index]['photoBidan'],
                          horizontalGap: 12,
                          backgroundColor: const Color(0xfff5faf6),
                          backgroundImageColor: AppColors.neon,
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        height: 228,
                        aspectRatio: 2,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  }),
              // ?? Akhir Layanan Konsultasi
              const SizedBox(
                height: 10.0,
              ),
              SectionHeader(
                title: "Layanan Edukasi",
                onTap: () {
                  mainC.currentIndex.value = 6;
                },
              ),
              const SizedBox(height: 10.0),
              StreamBuilder(
                  stream: homeC.getArticle(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Text(
                        "Belum Ada Artikel",
                        style: CustomTextStyle.bigText.copyWith(
                          color: Colors.white,
                        ),
                      );
                    }
                    var articleData = snapshot.data!.docs;
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount:
                          articleData.length > 2 ? 2 : articleData.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.77,
                      ),
                      itemBuilder: (context, index) {
                        Article blog = Article(
                          image: articleData[index]['photo'],
                          title: articleData[index]['title'],
                          desc: articleData[index]['shortDesc'],
                          author: articleData[index]['author'],
                          subject: articleData[index]['subject'],
                          contentBlog: articleData[index]['contentArticle'],
                        );
                        return CustomCardEducation(
                          image: articleData[index]['photo'],
                          title: articleData[index]['title'],
                          onTap: () {
                            blogC.setCurrentArticle(blog);
                            mainC.currentIndex.value = 7; //! Ke Detail_Blog
                          },
                        );
                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
