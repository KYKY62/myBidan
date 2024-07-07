import 'package:flutter/material.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';

class CustomNavTop extends StatelessWidget {
  final dynamic onTap;
  final String title;
  final dynamic controllerNav;
  final int value;
  const CustomNavTop(
      {super.key,
      required this.onTap,
      required this.title,
      required this.controllerNav,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: CustomTextStyle.greenText.copyWith(
          fontSize: 14,
          color: controllerNav == value ? AppColors.primary : Colors.grey,
        ),
      ),
    );
  }
}
