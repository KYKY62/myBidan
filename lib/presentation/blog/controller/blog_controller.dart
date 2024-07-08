import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/data/models/blog_model.dart';

class BlogController extends GetxController {
  final RxInt navIndex = 0.obs;

  var currentBlog = Blog(
    image: '',
    title: '',
    desc: '',
    author: '',
    subject: '',
    contentBlog: '',
  ).obs;

  List<Map<String, dynamic>> mapBlog = [
    {
      'image': Assets.images.blogimage.path,
      'title': 'Tips menjaga kesehatan janin',
      'desc': 'Perhatikan tips ini ampuh untuk janin anda',
      'author': 'Intan dewi',
      'subject': 'Pagi Sehat',
      'contentBlog':
          "In this course I'll show the step by step, day by day process to build better products, just as Google, Slack, KLM and manu other do. In this course I'll show the step by step, day by day process to build better products, just as Google, Slack, KLM and manu other do.  In this course I'll show the step by step, day by day process to build better products, just as Google, Slack, KLM and manu other do.",
    },
    {
      'image': Assets.images.blogImage2.path,
      'title': 'Tips mencegah baby blues.',
      'desc': 'Mencegah Lebih Baik untuk Kesehatan Anda',
      'author': 'Sri Rahayu',
      'subject': 'Pagi Sehat',
      'contentBlog':
          "In this course I'll show the step by step, In this course I'll show the step by step, day by day process to build better products, just as Google, Slack, KLM and manu other do.In this course I'll show the step by step, day by  Google, Slack, KLM and manu other do.",
    },
    {
      'image': Assets.images.ibuHamil.path,
      'title': 'Cara cepat Hamil',
      'desc': 'Ayok Segera Hamil',
      'author': 'Sri Kanjeng',
      'subject': 'Malam Sehat',
      'contentBlog':
          "In this course I'll show the step by step, In this course I'll show the step by step, day by day process to build better products, just as Google, Slack, KLM and manu other do.In this course I'll show the step by step, day by  Google, Slack, KLM and manu other do.",
    },
    {
      'image': Assets.images.ibuHamil.path,
      'title': 'Cara cepat Hamil',
      'desc': 'Ayok Segera Hamil',
      'author': 'Sri Kanjeng',
      'subject': 'Malam Sehat',
      'contentBlog':
          "In this course I'll show the step by step, In this course I'll show the step by step, day by day process to build better products, just as Google, Slack, KLM and manu other do.In this course I'll show the step by step, day by  Google, Slack, KLM and manu other do.",
    }
  ];

  void setCurrentBlog(Blog blog) {
    currentBlog.value = blog;
  }
}
