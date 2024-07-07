import 'package:flutter/material.dart';
import 'package:mybidan/core/constants/text_style.dart';

class LokalPage extends StatelessWidget {
  const LokalPage({super.key});

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
      ],
    );
  }
}
