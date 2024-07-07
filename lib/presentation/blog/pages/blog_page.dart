import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/components/custom_nav_top.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/presentation/blog/controller/blog_controller.dart';
import 'package:mybidan/presentation/blog/pages/nav_page/lokal_page.dart';
import 'package:mybidan/presentation/blog/pages/nav_page/trending_page.dart';

class BlogPage extends StatelessWidget {
  final blogC = Get.put(BlogController());
  BlogPage({super.key});

  Widget body() {
    switch (blogC.navIndex.value) {
      case 0:
        return const TrendingPage();
      case 1:
        return const LokalPage();
      case 2:
        return const TrendingPage();
      case 3:
        return const TrendingPage();
      default:
        return const TrendingPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        children: [
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CustomNavTop(
                          onTap: () => blogC.navIndex.value = 0,
                          title: 'Trending',
                          controllerNav: blogC.navIndex.value,
                          value: 0,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomNavTop(
                          onTap: () => blogC.navIndex.value = 1,
                          title: 'Berita News',
                          controllerNav: blogC.navIndex.value,
                          value: 1,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomNavTop(
                          onTap: () => blogC.navIndex.value = 2,
                          title: 'Berita Lokal',
                          controllerNav: blogC.navIndex.value,
                          value: 2,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomNavTop(
                          onTap: () => blogC.navIndex.value = 3,
                          title: 'Lainnya',
                          controllerNav: blogC.navIndex.value,
                          value: 3,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: body(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
