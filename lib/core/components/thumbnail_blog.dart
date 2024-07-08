import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/constants/text_style.dart';

class ThumbnailBlog extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  final String author;
  final String subject;
  const ThumbnailBlog({
    super.key,
    required this.title,
    required this.desc,
    required this.author,
    required this.subject,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            height: 160,
            width: Get.width,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: CustomTextStyle.primaryText.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            desc,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: CustomTextStyle.smText.copyWith(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 12.0,
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
              Text(
                author,
                style: CustomTextStyle.smText.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                "For",
                style: CustomTextStyle.smText.copyWith(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                subject,
                style: CustomTextStyle.smText.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            width: Get.width,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
