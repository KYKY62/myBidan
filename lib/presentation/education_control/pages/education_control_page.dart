import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/components/card_data_article.dart';
import 'package:mybidan/core/components/list_article.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';

class EducationControlPage extends StatelessWidget {
  const EducationControlPage({super.key});

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
                  "EDUKASI",
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
                                      "New artikel",
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
                                          return CardDataArticle(
                                            image: Assets.images.blogimage.path,
                                            title:
                                                'Tips menjaga kesehatan janin ',
                                            desc:
                                                'Perhatikan tips ini ampuh untuk janin anda',
                                            author: 'Intan dewi',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Manajement Artikel ",
                          style: CustomTextStyle.bigText,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: AppColors.primary,
                              ),
                            ),
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return ListArticle(
                          image: Assets.images.ronaldo.path,
                          nameArticle:
                              'Tips mencegah baby blues agar kesehatan janin menjadi...',
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
