import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybidan/core.dart';
import 'package:mybidan/presentation/find_klinik_control/controller/find_klinik_control_controller.dart';
import 'package:mybidan/presentation/find_klinik_control/pages/find_klinik_control_page.dart';
import 'package:mybidan/presentation/shop_control/controller/shop_control_controller.dart';
import 'package:mybidan/presentation/shop_control/pages/shop_control_page.dart';

class DashboardPage extends StatelessWidget {
  final dashboardC = Get.find<DashboardController>();
  final educationC = Get.find<EducationControlController>();
  final shopC = Get.find<ShopControlController>();
  final authC = Get.find<LoginController>();
  final findKlinik = Get.find<FindKlinikControlController>();

  DashboardPage({super.key}) {
    dashboardC.currentIndex.listen((index) {
      if (index != 1) {
        educationC.clearTextControllers();
        educationC.isAdding.value = false;
        educationC.image.value = null;
      }
      if (index != 2) {
        shopC.clearTextControllers();
        shopC.isAddingShop.value = false;
        shopC.image.value = null;
      }
      if (index != 3) {
        findKlinik.clearTextControllers();
        findKlinik.isAddingKlinik.value = false;
        findKlinik.image.value = null;
      }
    });
  }

  Widget body() {
    switch (dashboardC.currentIndex.value) {
      case 0:
        return KonsultasiControlPage();
      case 1:
        return EducationControlPage();
      case 2:
        return ShopControlPage();
      case 3:
        return FindKlinikControlPage();
      case 4:
        return const SizedBox();
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
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.primary,
            toolbarHeight: 0,
            // Menghilangkan garis hijau aneh
            systemOverlayStyle: SystemUiOverlayStyle.light
                .copyWith(systemNavigationBarColor: Colors.transparent),
          ),
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
                    AssetImage(Assets.icons.education.path),
                  ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: ImageIcon(
                    size: 19,
                    color: dashboardC.currentIndex.value == 2
                        ? AppColors.primary
                        : Colors.grey,
                    AssetImage(Assets.icons.cart.path),
                  ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: ImageIcon(
                    size: 19,
                    color: dashboardC.currentIndex.value == 3
                        ? AppColors.primary
                        : Colors.grey,
                    AssetImage(Assets.icons.mapInactive.path),
                  ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: GestureDetector(
                    onTap: () => authC.logOut(),
                    child: Icon(
                      Icons.exit_to_app,
                      color: dashboardC.currentIndex.value == 3
                          ? AppColors.primary
                          : Colors.grey,
                    ),
                  ),
                  // icon: ImageIcon(
                  //   size: 19,
                  //   color: dashboardC.currentIndex.value == 3
                  //       ? AppColors.primary
                  //       : Colors.grey,
                  //   AssetImage(Assets.icons.mapInactive.path),
                  // ),
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
