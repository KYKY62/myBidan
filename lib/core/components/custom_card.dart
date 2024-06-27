import 'package:flutter/material.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';

class CustomCard extends StatelessWidget {
  final String name;
  final String description;
  final String dateOperational;
  final String timeOperational;
  final String image;
  final double horizontalGap;
  final Color backgroundColor;
  final Color? backgroundImageColor;

  const CustomCard({
    super.key,
    required this.name,
    required this.description,
    required this.dateOperational,
    required this.timeOperational,
    required this.image,
    required this.horizontalGap,
    required this.backgroundColor,
    this.backgroundImageColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: backgroundImageColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      right: 8,
                      left: 8,
                    ),
                    child: Image.asset(
                      image,
                    ),
                  ),
                ),
                SizedBox(
                  width: horizontalGap,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: CustomTextStyle.primaryText.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      description,
                      style: CustomTextStyle.primaryText.copyWith(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffE0E9E6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      child: Row(
                        children: [
                          Container(
                            width: 27,
                            height: 27,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Image.asset(
                                Assets.icons.date.path,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            dateOperational,
                            style: CustomTextStyle.greenText.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffE0E9E6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      child: Row(
                        children: [
                          Container(
                            width: 27,
                            height: 27,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Image.asset(
                                Assets.icons.time.path,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            timeOperational,
                            style: CustomTextStyle.greenText.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
