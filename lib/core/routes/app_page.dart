import 'package:get/get.dart';
import 'package:mybidan/core/routes/route_name.dart';
import 'package:mybidan/presentation/auth/pages/login_page.dart';
import 'package:mybidan/presentation/auth/pages/register_page.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: RouteName.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RouteName.register,
      page: () => RegisterPage(title: Get.arguments['title']),
    ),
  ];
}
