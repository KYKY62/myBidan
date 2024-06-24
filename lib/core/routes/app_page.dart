import 'package:get/get.dart';
import 'package:mybidan/core/bindings/login_bindings.dart';
import 'package:mybidan/core/bindings/main_bindings.dart';
import 'package:mybidan/core/bindings/register_bindings.dart';
import 'package:mybidan/core/routes/route_name.dart';
import 'package:mybidan/presentation/auth/pages/login_page.dart';
import 'package:mybidan/presentation/auth/pages/register_page.dart';
import 'package:mybidan/presentation/home/pages/main_page.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: RouteName.login,
      page: () => LoginPage(),
      binding: LoginBindings(),
      transition: Transition.fadeIn,
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
  ];
}
