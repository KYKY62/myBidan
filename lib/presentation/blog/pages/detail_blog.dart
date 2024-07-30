import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/components/thumbnail_blog.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/data/models/article_model.dart';
import 'package:mybidan/presentation/blog/controller/blog_controller.dart';
import 'package:mybidan/presentation/home/controller/main_controller.dart';

class DetailBlogPage extends StatelessWidget {
  final mainC = Get.find<MainController>();
  final blogController = Get.find<ArticleController>();
  DetailBlogPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light,
    ));
    final Article article = blogController.currentArticle.value;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => mainC.currentIndex.value = 6, //! Ke Blog_Page
                    child: const Icon(
                      Icons.arrow_back_outlined,
                    ),
                  ),
                  Text(
                    "Edukasi kesehatan",
                    style: CustomTextStyle.primaryText.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 38),
              child: ThumbnailBlog(
                image: article.image,
                title: article.title,
                desc: article.desc,
                author: article.author,
                subject: article.subject,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                article.contentBlog,
                style: CustomTextStyle.primaryText.copyWith(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 38.0,
            ),
          ],
        ),
      ),
    );
  }
}
