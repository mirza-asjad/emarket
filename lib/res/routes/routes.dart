import 'package:get/get.dart';
import 'package:emarket/res/routes/routes_name.dart';
import 'package:emarket/views/home_screen.dart';
import 'package:emarket/views/login_screen.dart';
import 'package:emarket/views/splash_screen.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(name: RouteName.splashScreen, page: () => const SplashScreen()),
        GetPage(name: RouteName.loginScreen, page: () => const LoginScreen()),
        GetPage(name: RouteName.homeScreen, page: () => const HomeScreen()),
      ];
}
