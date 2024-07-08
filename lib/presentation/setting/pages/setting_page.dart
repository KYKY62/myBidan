import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/components/card_setting.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:flutter/services.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: AppColors.primary,
    ));

    return Scaffold(
        body: ListView(
      children: [
        SizedBox(
          height: Get.height,
          child: Stack(
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    Container(
                      width: Get.width,
                      height: 350,
                      decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                color: Colors.transparent,
                              ),
                              Center(
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage(Assets.images.product.path),
                                ),
                              ),
                              const Icon(
                                Icons.edit,
                                size: 24.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Lusiana Silalahi",
                            style: CustomTextStyle.primaryText.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "alnamarisilalahi@gmail.com",
                            style: CustomTextStyle.smallerText,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 190,
                      left: 26,
                      right: 26,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        width: Get.width,
                        height: 60,
                        child: CardSetting(
                          onTap: () {},
                          icon: Assets.icons.infoAccount.path,
                          title: 'Informasi akun',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 270,
                left: 26,
                right: 26,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  width: Get.width,
                  height: 260,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 22.0,
                      ),
                      CardSetting(
                        onTap: () {},
                        icon: Assets.icons.infoAccount.path,
                        title: 'Informasi akun',
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      CardSetting(
                        onTap: () {},
                        icon: Assets.icons.terms.path,
                        title: 'Syarat dan ketentuan',
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      CardSetting(
                        onTap: () {},
                        icon: Assets.icons.private.path,
                        title: 'Privasi dan kebijakan',
                      ),
                      const Expanded(
                        child: SizedBox(
                          height: 22.0,
                        ),
                      ),
                      CardSetting(
                        onTap: () => Get.offAllNamed('/'),
                        icon: Assets.icons.logout.path,
                        title: 'Log out account',
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
