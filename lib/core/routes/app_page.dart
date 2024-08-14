import 'package:get/get.dart';
import 'package:mybidan/core/bindings/bidan_bindings.dart';
import 'package:mybidan/core/bindings/dashboard_bindings.dart';
import 'package:mybidan/core/bindings/detail_product_bindings.dart';
import 'package:mybidan/core/bindings/login_bindings.dart';
import 'package:mybidan/core/bindings/main_bindings.dart';
import 'package:mybidan/core/bindings/register_bindings.dart';
import 'package:mybidan/core/routes/route_name.dart';
import 'package:mybidan/presentation/auth/pages/login_page.dart';
import 'package:mybidan/presentation/auth/pages/register_page.dart';
import 'package:mybidan/presentation/bidan/pages/bidan_page.dart';
import 'package:mybidan/presentation/dashboard/pages/dashboard_page.dart';
import 'package:mybidan/presentation/home/pages/main_page.dart';
import 'package:mybidan/presentation/konsultasi_control/pages/add_bidan_page.dart';
import 'package:mybidan/presentation/shop/pages/detail_product_page.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: RouteName.login,
      page: () => LoginPage(),
      binding: LoginBindings(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteName.register,
      page: () => RegisterPage(),
      binding: RegisterBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteName.main,
      page: () => MainPage(),
      binding: MainBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteName.detailProduct,
      page: () => DetailProductPage(
        image: Get.arguments['image'],
        title: Get.arguments['title'],
        type: Get.arguments['type'],
        normalPrice: Get.arguments['normalPrice'],
        discountPrice: Get.arguments['discountPrice'],
        textDesc: Get.arguments['textDesc'],
        textBahan: Get.arguments['textBahan'],
      ),
      binding: DetailProductBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteName.dasboard,
      page: () => DashboardPage(),
      binding: DashboardBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteName.addBidan,
      page: () => AddBidanPage(),
    ),
    GetPage(
      name: RouteName.roomBidan,
      binding: BidanBindings(),
      page: () => BidanPage(),
    )
  ];
}
