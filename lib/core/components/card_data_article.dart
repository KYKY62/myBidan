import 'package:flutter/material.dart';
import 'package:mybidan/core/constants/text_style.dart';

class CardDataArticle extends StatelessWidget {
  final dynamic onTap;
  final dynamic photo;
  final String title;
  final String desc;
  final String author;
  const CardDataArticle({
    super.key,
    required this.onTap,
    required this.title,
    required this.desc,
    required this.author,
    required this.photo,
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
              Image.network(photo, height: 100, fit: BoxFit.cover),
              const SizedBox(
                height: 12.0,
              ),
              SizedBox(
                height: 48,
                child: Text(
                  title,
                  maxLines: 2,
                  style: CustomTextStyle.primaryText.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: Text(
                    desc,
                    maxLines: 2,
                    style: CustomTextStyle.smText.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
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
                  SizedBox(
                    width: 90,
                    child: Text(
                      author,
                      maxLines: 1,
                      style: CustomTextStyle.greenText.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
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
