import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core.dart';

class NewsPage extends StatelessWidget {
  final mainC = Get.find<MainController>();
  final articleC = Get.find<ArticleController>();
  NewsPage({super.key});

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
              "Berita News Today🔥",
              style: CustomTextStyle.primaryText.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            StreamBuilder(
                stream: articleC.getArticleNews(),
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
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Article article = Article(
                          image: articleData[index]['photo'],
                          title: articleData[index]['title'],
                          desc: articleData[index]['shortDesc'],
                          author: articleData[index]['author'],
                          subject: articleData[index]['subject'],
                          contentBlog: articleData[index]['contentArticle'],
                        );
                        articleC.setCurrentArticle(article);
                        mainC.currentIndex.value = 7; //! Ke Detail_Blog
                      },
                      child: ThumbnailBlog(
                        image: articleData[index]['photo'],
                        title: articleData[index]['title'],
                        desc: articleData[index]['shortDesc'],
                        author: articleData[index]['author'],
                        subject: articleData[index]['subject'],
                      ),
                    ),
                  );
                }),
            StreamBuilder(
                stream: articleC.getArticleNews(),
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
