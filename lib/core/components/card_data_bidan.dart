import 'package:flutter/material.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/components/stack_profile_bidan.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';

class CardDataBidan extends StatelessWidget {
  final dynamic onTap;
  final String image;
  final String nameBidan;
  final String specialist;
  final String timeOperational;
  const CardDataBidan({
    super.key,
    required this.onTap,
    required this.image,
    required this.nameBidan,
    required this.specialist,
    required this.timeOperational,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 4,
                      color: AppColors.primary,
                    ),
                  ),
                  child: const Icon(Icons.add),
                ),
              ),
              StackProfileBidan(
                image: image,
              ),
              Text(
                nameBidan,
                style: CustomTextStyle.primaryText.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                specialist,
                style: CustomTextStyle.smText.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffE0E9E6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  child: Row(
                    children: [
                      Container(
                        width: 27,
                        height: 27,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Image.asset(
                            Assets.icons.time.path,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
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
