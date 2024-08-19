import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';

class PremiumAction extends StatelessWidget {
  const PremiumAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Akun ada belum premium untuk menggunakan fitur ini.",
          textAlign: TextAlign.center,
          style: CustomTextStyle.primaryText,
        ),
        const SizedBox(
          height: 15.0,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          onPressed: () {},
          child: const Text("Premiumkan Sekarang"),
        ),
      ],
    );
  }
}
