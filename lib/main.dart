import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mybidan/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final authC = Get.put(LoginController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final box = GetStorage();
          bool isAutoLogin = box.read('autoLogin') ?? false;
          String initialRoute;

          if (isAutoLogin) {
            // Dapatkan role dari GetStorage
            String? role = box.read('role');
            // Atur initialRoute berdasarkan role
            initialRoute = authC.getInitialRouteBasedOnRole(role);
          } else {
            initialRoute = RouteName.login;
          }

          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.fadeIn,
            initialRoute: initialRoute,
            getPages: AppPage.pages,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
            ),
          );
        }

        return FutureBuilder(
          future: authC.firstInitialized(),
          builder: (context, snapshot) => const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              )),
        );
      },
    );
  }
}
