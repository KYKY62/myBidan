import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/constants/text_style.dart';

class ThumbnailBlog extends StatelessWidget {
  const ThumbnailBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Assets.images.ibuHamil.path,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            "Tips menjaga kesehatan ibu hamil selama 9 bulan.",
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
            "Menjaga kehamilan itu penting bagi ibu hamil",
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
                "Intan dewi",
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
                "Pagi Sehat",
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
