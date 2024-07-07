import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/components/thumbnail_blog.dart';
import 'package:mybidan/core/constants/text_style.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const ThumbnailBlog(),
        SizedBox(
          height: Get.height,
          child: GridView.builder(
            itemCount: 18,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // number of items in each row
              mainAxisSpacing: 8.0, // spacing between rows
              crossAxisSpacing: 8.0, // spacing between columns
            ),
            itemBuilder: (context, index) {
              return Container(
                color: Colors.blue, // color of grid items
                child: const Center(
                  child: Text(
                    'data',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
