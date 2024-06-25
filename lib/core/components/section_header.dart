import 'package:flutter/material.dart';
import 'package:mybidan/core/constants/text_style.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final dynamic onTap;
  const SectionHeader({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: CustomTextStyle.primaryText
                .copyWith(fontWeight: FontWeight.w600),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              "View All",
              style: CustomTextStyle.greenText
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
