import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/presentation/dashboard/controller/dashboard_controller.dart';
import 'package:mybidan/presentation/education_control/controller/education_control_controller.dart';
import 'package:mybidan/presentation/education_control/pages/education_control_page.dart';
import 'package:mybidan/presentation/konsultasi_control/pages/konsultasi_control_page.dart';

class DashboardPage extends StatelessWidget {
  final dashboardC = Get.find<DashboardController>();
  final educationC = Get.find<EducationControlController>();

  DashboardPage({super.key}) {
    dashboardC.currentIndex.listen((index) {
      if (index != 1) {
        educationC.clearTextControllers();
        educationC.isAdding.value = false;
        educationC.image.value = null;
      }
    });
  }

  Widget body() {
    switch (dashboardC.currentIndex.value) {
      case 0:
        return KonsultasiControlPage();
      case 1:
        return EducationControlPage();
      default:
        return KonsultasiControlPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: dashboardC.didPop.value,
        onPopInvoked: (didPop) {
          if (dashboardC.currentIndex.value != 0) {
            dashboardC.currentIndex.value = 0;
          } else {
            dashboardC.didPop.value = true;
          }
        },
        child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            height: 63,
            padding: const EdgeInsets.all(0),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                dashboardC.currentIndex.value = value;
              },
              items: [
                BottomNavigationBarItem(
                  label: '',
                  icon: ImageIcon(
                    size: 19,
                    color: dashboardC.currentIndex.value == 0
                        ? AppColors.primary
                        : Colors.grey,
                    AssetImage(
                      Assets.icons.chat.path,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: ImageIcon(
                    size: 19,
                    color: dashboardC.currentIndex.value == 1
                        ? AppColors.primary
                        : Colors.grey,
                    AssetImage(Assets.icons.mapInactive.path),
                  ),
                ),
              ],
            ),
          ),
          body: body(),
        ),
      ),
    );
  }
}
