import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';

class ItemChat extends StatelessWidget {
  final String chat;
  final bool isSender;
  const ItemChat({
    super.key,
    required this.isSender,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: Get.width / 1.5, // Maksimal lebar container
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSender == true ? AppColors.neonBold : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8),
            topRight: const Radius.circular(8),
            bottomLeft: isSender == true
                ? const Radius.circular(0)
                : const Radius.circular(8),
            bottomRight: isSender == true
                ? const Radius.circular(8)
                : const Radius.circular(0),
          ),
        ),
        child: Column(
          crossAxisAlignment: isSender == true
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                chat,
                style: CustomTextStyle.smallerText.copyWith(
                  fontSize: 12,
                  color: isSender == true ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              "12:10",
              style: CustomTextStyle.smallerText.copyWith(
                fontSize: 12,
                color: const Color(0xff8A8A8E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
