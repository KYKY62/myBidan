import 'package:flutter/material.dart';
import 'package:mybidan/core/constants/text_style.dart';

class CardSetting extends StatelessWidget {
  final dynamic onTap;
  final String icon;
  final String title;
  const CardSetting({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(icon, width: 16, fit: BoxFit.cover),
                const SizedBox(
                  width: 16,
                ),
                Text(title, style: CustomTextStyle.primaryText),
              ],
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
