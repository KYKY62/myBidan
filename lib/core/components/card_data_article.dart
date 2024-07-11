import 'package:flutter/material.dart';
import 'package:mybidan/core/constants/text_style.dart';

class CardDataArticle extends StatelessWidget {
  final dynamic onTap;
  final String image;
  final String title;
  final String desc;
  final String author;
  const CardDataArticle({
    super.key,
    required this.onTap,
    required this.image,
    required this.title,
    required this.desc,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 158,
        height: 255,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                title,
                style: CustomTextStyle.primaryText.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                desc,
                style: CustomTextStyle.smText.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'By',
                    style: CustomTextStyle.greenText.copyWith(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    author,
                    style: CustomTextStyle.greenText.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 11.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
