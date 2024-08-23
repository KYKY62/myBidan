import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
                    'Privasi dan Kebijakan',
                    style: CustomTextStyle.biggerText
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '1. Pengumpulan Informasi\n'
                '   - Kami mengumpulkan informasi yang Anda berikan secara langsung saat menggunakan aplikasi.\n\n'
                '2. Penggunaan Informasi\n'
                '   - Informasi yang kami kumpulkan digunakan untuk meningkatkan pengalaman Anda dalam menggunakan aplikasi.\n\n'
                '3. Pembagian Informasi\n'
                '   - Kami tidak akan membagikan informasi pribadi Anda kepada pihak ketiga tanpa persetujuan Anda.\n\n'
                '4. Keamanan Informasi\n'
                '   - Kami mengambil langkah-langkah yang diperlukan untuk melindungi informasi pribadi Anda dari akses yang tidak sah.\n\n'
                '5. Hak Anda\n'
                '   - Anda memiliki hak untuk mengakses, memperbarui, atau menghapus informasi pribadi Anda kapan saja.\n\n'
                '6. Pembaruan Kebijakan\n'
                '   - Kebijakan privasi ini dapat diperbarui dari waktu ke waktu tanpa pemberitahuan terlebih dahulu.\n\n'
                '7. Kontak Kami\n'
                '   - Jika Anda memiliki pertanyaan tentang kebijakan privasi ini, silakan hubungi kami melalui informasi kontak yang tersedia di aplikasi.',
                style: CustomTextStyle.primaryText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
