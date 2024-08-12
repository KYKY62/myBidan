import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/components/custom_text_field.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/core/constants/text_style.dart';
import 'package:mybidan/core/routes/route_name.dart';
import 'package:mybidan/presentation/auth/controller/register_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final registerC = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.primary,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primary,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: AppColors.primary,
        ),
      ),
      backgroundColor: AppColors.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shadowColor: AppColors.primary,
              elevation: 5,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "DAFTAR AKUN ANDA SEKARANG!!",
                    style: CustomTextStyle.bigText,
                  ),
                  CustomTextField(
                    controller: registerC.emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    inputColor: Colors.black,
                  ),
                  CustomTextField(
                    controller: registerC.passwordController,
                    label: 'Password',
                    keyboardType: TextInputType.emailAddress,
                    inputColor: Colors.black,
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
                          registerC.register(
                            email: registerC.emailController.text,
                            password: registerC.passwordController.text,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text("Register", style: CustomTextStyle.bigText),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Sudah Punya Akun?"),
                        const SizedBox(
                          width: 5.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offNamed(RouteName.login);
                          },
                          child: Text(
                            "Login Sekarang",
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
      ),
    );
  }
}
