import 'package:flutter/material.dart';
import 'package:mybidan/core/constants/text_style.dart';

class CustomCardEducation extends StatelessWidget {
  final dynamic onTap;
  final String image;
  final String title;

  const CustomCardEducation(
      {super.key,
      required this.image,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              width: 170,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: 154,
            child: Text(
              title,
              style: CustomTextStyle.primaryText.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
