import 'package:flutter/material.dart';
import 'package:gemini_app_project/core/routes/not_found.dart';
import 'package:gemini_app_project/screens/chat/chat_screen.dart';
import 'package:gemini_app_project/screens/chat_history/chat_history.dart';
import 'package:gemini_app_project/screens/home/home_screen.dart';
import 'package:gemini_app_project/screens/on_boarding/on_boarding_screen.dart';
import 'package:gemini_app_project/screens/setting/setting_screen.dart';
import 'package:gemini_app_project/screens/splash_screen/splash_screen.dart';

// App routes
class AppRoutes {
  static const String splashScreen = '/splash';
  static const String onBoardingScreen = '/onboard';
  static const String homeScreen = '/home';
  static const String chatScreen = '/chat';
  static const String settingScreen = '/setting';
  static const String historyScreen = '/history';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case chatScreen:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case settingScreen:
        return MaterialPageRoute(builder: (_) => const SettingScreen());
      case historyScreen:
        return MaterialPageRoute(builder: (_) => const ChatHistory());
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}
