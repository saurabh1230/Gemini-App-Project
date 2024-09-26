
import 'package:get/get.dart';
import 'package:iclinix/app/screens/auth/login_screen.dart';
import 'package:iclinix/app/screens/onboard/splash.dart';


class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String login = '/login';




  /// Routes ==================>
  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getLoginRoute() => login;




  /// Pages ==================>
  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginScreen()),




  ];
}