import 'package:flutter/material.dart';
import 'package:mybidan/core/constants/colors.dart';

class StackProfileBidan extends StatelessWidget {
  final String image;

  const StackProfileBidan({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            const Column(
              children: [
                SizedBox(
                  width: 88,
                  height: 108,
                ),
              ],
            ),
            Positioned(
              top: 12,
              child: Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: AppColors.neon,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              child: Image.asset(
                image,
                height: 98,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
