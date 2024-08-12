import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybidan/core/assets/assets.gen.dart';
import 'package:mybidan/core/constants/colors.dart';
import 'package:mybidan/presentation/blog/pages/blog_page.dart';
import 'package:mybidan/presentation/blog/pages/detail_blog.dart';
import 'package:mybidan/presentation/chat/controller/chat_controller.dart';
import 'package:mybidan/presentation/chat/pages/chat_page.dart';
import 'package:mybidan/presentation/chat/pages/private_chat_page.dart';
import 'package:mybidan/presentation/finding_bidan/controller/find_bidan_controller.dart';
import 'package:mybidan/presentation/finding_bidan/pages/find_bidan_page.dart';
import 'package:mybidan/presentation/home/controller/main_controller.dart';
import 'package:mybidan/presentation/home/pages/home_page.dart';
import 'package:mybidan/presentation/setting/pages/setting_page.dart';
import 'package:mybidan/presentation/shop/pages/shop_page.dart';

class MainPage extends StatelessWidget {
  final mainC = Get.find<MainController>();
  final findBidanC = Get.find<FindBidanController>();
  final chatC = Get.find<ChatController>();
  MainPage({super.key});

  Widget body() {
    switch (mainC.currentIndex.value) {
      case 0:
        return HomePage();
      case 1:
        return ChatPage();
      case 2:
        return FindBidanPage();
      case 3:
        return SettingPage();
      case 4:
        return ShopPage();
      case 5:
        return PrivateChatPage(
          backToOntap: () => mainC.currentIndex.value = 1,
          hideFloating: () => mainC.currentIndex.value = 5,
          nameBidan: chatC.nameBidan.value,
        );
      case 6:
        return BlogPage();
      case 7:
        return DetailBlogPage();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => PopScope(
          canPop: mainC.didPop.value,
          onPopInvoked: (didPop) {
            if (mainC.currentIndex.value != 0) {
              mainC.currentIndex.value = 0;
            } else {
              mainC.didPop.value = true;
            }
          },
          child: Scaffold(
            floatingActionButton: mainC.currentIndex.value == 5
                ? const SizedBox()
                : FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      mainC.currentIndex.value = 4;
                    },
                    child: Image.asset(
                      Assets.icons.carFloating.path,
                      color: Colors.white,
                      fit: BoxFit.cover,
                      width: 27,
                    ),
                  ),

            // resizeToAvoidBottomInset: false,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              height: 63,
              padding: const EdgeInsets.all(0),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  mainC.currentIndex.value = value;
                  findBidanC.selectedObject.value = false;
                  findBidanC.detailObject.value = null;
                },
                items: [
                  BottomNavigationBarItem(
                    label: '',
                    icon: ImageIcon(
                      size: 19,
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
                      size: 19,
                      color: mainC.currentIndex.value == 1
                          ? AppColors.primary
                          : Colors.grey,
                      AssetImage(Assets.icons.chat.path),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: '',
                    icon: ImageIcon(
                      size: 19,
                      color: mainC.currentIndex.value == 2
                          ? AppColors.primary
                          : Colors.grey,
                      AssetImage(Assets.icons.mapInactive.path),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: '',
                    icon: ImageIcon(
                      size: 19,
                      color: mainC.currentIndex.value == 3
                          ? AppColors.primary
                          : Colors.grey,
                      AssetImage(Assets.icons.user.path),
                    ),
                  ),
                ],
              ),
            ),
            body: body(),
          ),
        ));
  }
}
