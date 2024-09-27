
import 'package:get/get.dart';
import 'package:iclinix/app/screens/appointment/select_slot_screen.dart';
import 'package:iclinix/app/screens/auth/login_screen.dart';
import 'package:iclinix/app/screens/auth/otp_verification_screen.dart';
import 'package:iclinix/app/screens/dashboard/dashboard_screen.dart';
import 'package:iclinix/app/screens/onboard/splash.dart';


class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String otpVerification = '/otp-verification';
  static const String dashboard = '/dashboard';
  static const String selectSlot = '/select-slot';




  /// Routes ==================>
  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getLoginRoute() => login;
  static String getOtpVerificationRoute(String? phoneNo,) => '$otpVerification?phoneNo=$phoneNo';
  static String getDashboardRoute() => dashboard;
  static String getSelectSlotRoute() => selectSlot;




  /// Pages ==================>
  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: login, page: () =>  LoginScreen()),
    GetPage(name: otpVerification, page: () =>  OtpVerificationScreen(phoneNo :Get.parameters['phoneNo'])),
    GetPage(name: dashboard, page: () =>  const DashboardScreen(pageIndex: 0)),
    GetPage(name: selectSlot, page: () =>  SelectSlotScreen()),



  ];
}