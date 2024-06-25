import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/presentation/home/controller/main_controller.dart';
import 'package:mybidan/presentation/home/pages/chat_page.dart';
import 'package:mybidan/presentation/home/pages/home_page.dart';

class MainPage extends StatelessWidget {
  final mainC = Get.find<MainController>();
  MainPage({super.key});

  Widget body() {
    switch (mainC.currentIndex.value) {
      case 0:
        return HomePage();
      case 1:
        return const ChatPage();
      case 2:
        return const ChatPage();
      case 3:
        return const ChatPage();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: AppColors.primary,
        onPressed: () {},
        child: Image.asset(
          Assets.icons.carFloating.path,
          color: Colors.white,
          fit: BoxFit.cover,
          width: 23,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(0),
        child: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) => mainC.currentIndex.value = value,
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: ImageIcon(
                  color: mainC.currentIndex.value == 0
                      ? AppColors.primary
                      : Colors.grey,
                  AssetImage(
                    Assets.icons.home.path,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: ImageIcon(
                  color: mainC.currentIndex.value == 1
                      ? AppColors.primary
                      : Colors.grey,
                  AssetImage(Assets.icons.chat.path),
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: ImageIcon(
                  color: mainC.currentIndex.value == 2
                      ? AppColors.primary
                      : Colors.grey,
                  AssetImage(Assets.icons.mapInactive.path),
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: ImageIcon(
                  color: mainC.currentIndex.value == 3
                      ? AppColors.primary
                      : Colors.grey,
                  AssetImage(Assets.icons.user.path),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => body()),
    );
  }
}
