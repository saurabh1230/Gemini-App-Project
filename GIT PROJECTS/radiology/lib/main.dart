import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/data/repo/spotters_repo.dart';
import 'package:radiology/helper/route_helper.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/themes/light_theme.dart';
import 'controllers/munchies_controller.dart';
import 'data/api/api_client.dart';
import 'data/repo/munchies_repo.dart';
import 'helper/gi_dart.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  // Initialize dependencies
  await di.init();

  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: light,
      initialRoute: RouteHelper.getInitialRoute(),
      getPages: RouteHelper.routes,
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      builder: (BuildContext context, widget) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: widget!);
      },
    );
  }
}
