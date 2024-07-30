import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/data/models/article_model.dart';

class OtherBlog extends StatelessWidget {
  final dynamic onTap;
  final Article blog;
  const OtherBlog({
    super.key,
    required this.onTap,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            blog.image,
            fit: BoxFit.cover,
            width: Get.width,
            height: 100,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            blog.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: CustomTextStyle.primaryText.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            blog.desc,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: CustomTextStyle.smText.copyWith(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                "By",
                style: CustomTextStyle.smText.copyWith(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              SizedBox(
                width: 120,
                child: Text(
                  blog.author,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.smText.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
