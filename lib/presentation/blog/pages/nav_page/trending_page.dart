import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/components/other_blog.dart';
import 'package:mybidan/core/components/thumbnail_blog.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/data/models/blog_model.dart';
import 'package:mybidan/presentation/blog/controller/blog_controller.dart';
import 'package:mybidan/presentation/home/controller/main_controller.dart';

class TrendingPage extends StatelessWidget {
  final mainC = Get.find<MainController>();
  final blogC = Get.find<BlogController>();
  TrendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today trending🔥",
              style: CustomTextStyle.primaryText.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ThumbnailBlog(
              image: Assets.images.ibuHamil.path,
              title: 'Tips menjaga kesehatan ibu hamil selama 9 bulan.',
              desc: 'Menjaga kehamilan itu penting bagi ibu hamil',
              author: 'Intan dewi',
              subject: 'Pagi Sehat',
            ),
            GridView.builder(
              itemCount: blogC.mapBlog.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 20,
                childAspectRatio: 2 / 2.9,
              ),
              itemBuilder: (context, index) {
                Blog blog = Blog(
                  image: blogC.mapBlog[index]['image'],
                  title: blogC.mapBlog[index]['title'],
                  desc: blogC.mapBlog[index]['desc'],
                  author: blogC.mapBlog[index]['author'],
                  subject: blogC.mapBlog[index]['subject'],
                  contentBlog: blogC.mapBlog[index]['contentBlog'],
                );

                return OtherBlog(
                  blog: blog,
                  onTap: () {
                    blogC.setCurrentBlog(blog);
                    mainC.currentIndex.value = 7;
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
