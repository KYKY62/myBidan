import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/presentation/dashboard/controller/dashboard_controller.dart';
import 'package:mybidan/presentation/education_control/pages/education_control_page.dart';
import 'package:mybidan/presentation/konsultasi_control/pages/konsultasi_control_page.dart';

class DashboardPage extends StatelessWidget {
  final dashboardC = Get.find<DashboardController>();
  DashboardPage({super.key});

  Widget body() {
    switch (dashboardC.currentIndex.value) {
      case 0:
        return const KonsultasiControlPage();
      case 1:
        return const EducationControlPage();
      default:
        return const KonsultasiControlPage();
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
          }
          dashboardC.didPop.value = true;
        },
        child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.all(0),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                dashboardC.currentIndex.value = value;
              },
              items: [
                BottomNavigationBarItem(
                  label: '',
                  icon: ImageIcon(
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
