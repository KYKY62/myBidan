import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primary,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: AppColors.primary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back)),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Syarat dan Ketentuan',
                    style: CustomTextStyle.biggerText
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '1. Pengenalan\n'
                '   - Ini adalah syarat dan ketentuan penggunaan aplikasi ini.\n\n'
                '2. Penggunaan Aplikasi\n'
                '   - Anda setuju untuk menggunakan aplikasi ini sesuai dengan hukum yang berlaku.\n\n'
                '3. Privasi\n'
                '   - Data pribadi Anda akan digunakan sesuai dengan kebijakan privasi kami.\n\n'
                '4. Pembaruan\n'
                '   - Syarat dan ketentuan ini dapat diperbarui dari waktu ke waktu tanpa pemberitahuan terlebih dahulu.\n\n'
                '5. Hukum yang Berlaku\n'
                '   - Syarat dan ketentuan ini diatur oleh hukum yang berlaku di negara tempat aplikasi ini dikembangkan.\n\n'
                '6. Penutup\n'
                '   - Dengan menggunakan aplikasi ini, Anda dianggap telah menyetujui syarat dan ketentuan yang berlaku.',
                style: CustomTextStyle.primaryText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
