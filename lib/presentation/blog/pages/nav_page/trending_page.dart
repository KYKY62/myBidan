import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/components/other_blog.dart';
import 'package:mybidan/core/components/thumbnail_blog.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/data/models/article_model.dart';
import 'package:mybidan/presentation/blog/controller/blog_controller.dart';
import 'package:mybidan/presentation/home/controller/main_controller.dart';

class TrendingPage extends StatelessWidget {
  final mainC = Get.find<MainController>();
  final articleC = Get.find<ArticleController>();
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
            StreamBuilder(
                stream: articleC.getArticle(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text(
                      "Belum Ada Artikel",
                      style: CustomTextStyle.bigText.copyWith(
                        color: Colors.white,
                      ),
                    );
                  }
                  var articleData = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) => ThumbnailBlog(
                      image: articleData[index]['photo'],
                      title: articleData[index]['title'],
                      desc: articleData[index]['shortDesc'],
                      author: articleData[index]['author'],
                      subject: articleData[index]['subject'],
                    ),
                  );
                }),
            StreamBuilder(
                stream: articleC.getArticle(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text(
                      "Belum Ada Artikel",
                      style: CustomTextStyle.bigText.copyWith(
                        color: Colors.white,
                      ),
                    );
                  }
                  var articleData = snapshot.data!.docs;
                  return GridView.builder(
                    itemCount: articleData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      Article article = Article(
                        image: articleData[index]['photo'],
                        title: articleData[index]['title'],
                        desc: articleData[index]['shortDesc'],
                        author: articleData[index]['author'],
                        subject: articleData[index]['subject'],
                        contentBlog: articleData[index]['contentArticle'],
                      );

                      return OtherBlog(
                        blog: article,
                        onTap: () {
                          articleC.setCurrentArticle(article);
                          mainC.currentIndex.value = 7; //! Ke Detail_Blog
                        },
                      );
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
