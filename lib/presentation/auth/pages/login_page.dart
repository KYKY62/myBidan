import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/components/custom_text_field.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/presentation/auth/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  final loginC = Get.put(LoginController());
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String register = 'register bisa';

    return Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "SELAMAT DATANG DI MYBIDAN",
                      style: CustomTextStyle.bigText,
                    ),
                    CustomTextField(
                      controller: loginC.emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CustomTextField(
                      controller: loginC.passwordController,
                      label: 'Password',
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: Get.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(
                              '/register',
                              arguments: {
                                'title': register,
                              },
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child:
                                Text("Login", style: CustomTextStyle.bigText),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Belum Punya Akun?"),
                          const SizedBox(
                            width: 5.0,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Daftar Sekarang",
                              style: CustomTextStyle.greenText.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
