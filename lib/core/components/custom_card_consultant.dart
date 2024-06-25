import 'package:flutter/material.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';

class CustomCardConsultant extends StatelessWidget {
  final String nameBidan;
  final String specialistBidan;
  final String dateOperational;
  final String timeOperational;

  const CustomCardConsultant({
    super.key,
    required this.nameBidan,
    required this.specialistBidan,
    required this.dateOperational,
    required this.timeOperational,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xfff5faf6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.neon,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      right: 8,
                      left: 8,
                    ),
                    child: Image.asset(
                      Assets.images.bidan.path,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameBidan,
                      style: CustomTextStyle.primaryText.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      specialistBidan,
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
              height: 12.0,
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
