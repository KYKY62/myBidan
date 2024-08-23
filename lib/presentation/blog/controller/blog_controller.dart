import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mybidan/data/models/article_model.dart';

class ArticleController extends GetxController {
  final RxInt navIndex = 0.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  var currentArticle = Article(
    image: '',
    title: '',
    desc: '',
    author: '',
    subject: '',
    contentBlog: '',
  ).obs;

  Stream<QuerySnapshot>? getArticleTrending() => db
      .collection('article')
      .where('kategori', isEqualTo: 'trending')
      .snapshots();

  Stream<QuerySnapshot>? getArticleLocal() => db
      .collection('article')
      .where('kategori', isEqualTo: 'lokal')
      .snapshots();

  Stream<QuerySnapshot>? getArticleNews() =>
      db.collection('article').where('kategori', isEqualTo: 'news').snapshots();

  Stream<QuerySnapshot>? getArticleOther() => db
      .collection('article')
      .where('kategori', isEqualTo: 'lainnya')
      .snapshots();

  void setCurrentArticle(Article article) {
    currentArticle.value = article;
  }
}
