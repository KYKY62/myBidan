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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Registerasi Akun",
                    style: CustomTextStyle.bigText.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  shadowColor: AppColors.primary,
                  elevation: 5,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => registerC.selectedImage(),
                        child: Obx(
                          () => CircleAvatar(
                            radius: 50,
                            backgroundImage: registerC.image.value != null
                                ? MemoryImage(
                                    registerC.image.value!,
                                  )
                                : null,
                            backgroundColor: registerC.image.value == null
                                ? Colors.grey
                                : null,
                            child: Icon(
                              Icons.add,
                              color: registerC.image.value == null
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
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
                      CustomTextField(
                        controller: registerC.namaController,
                        label: 'Nama',
                        keyboardType: TextInputType.text,
                        inputColor: Colors.black,
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
                            onPressed: () => registerC.register(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => Text(
                                  registerC.isLoading.value
                                      ? "Loading..."
                                      : "Register",
                                  style: CustomTextStyle.bigText,
                                ),
                              ),
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
                              onTap: () => Get.offNamed(RouteName.login),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
