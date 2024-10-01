import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:isar/isar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gemini_app_project/core/constants/constants.dart';
import 'package:gemini_app_project/core/routes/app_routes.dart';
import 'package:gemini_app_project/core/themes/themes.dart';
import 'package:gemini_app_project/core/utils/hive_box.dart';
import 'package:gemini_app_project/db/chat/gemini_chat.dart';
import 'package:gemini_app_project/db/isar_constant.dart';
import 'package:gemini_app_project/provider/chat_provider.dart';
import 'package:gemini_app_project/provider/theme_provider.dart';
import 'package:provider/provider.dart';

late final PackageInfo packageInfo;

Future<Isar> openDB() async {
  var dir = await getApplicationDocumentsDirectory();
  // to get application directory information

  if (Isar.instanceNames.isEmpty) {
    return await Isar.open(
      //open isar
      [GeminiChatSchema],
      directory: dir.path,
    );
  }

  return Future.value(Isar.getInstance());
  // return instance of Isar
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Local storage
  await Hive.initFlutter();
  await Hive.openBox(themeBox);
  await Hive.openBox(primeBox);

  packageInfo = await PackageInfo.fromPlatform();

  isar = openDB();

  ThemeMode savedTheme = ThemeMode.values[HiveBoxPref.getTheme()];

  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(savedTheme),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      /* start -> uncomment below 2 lines to enable landscape mode */

      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight

      /*end */
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatProvider>(
          create: (context) => ChatProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: value.currentTheme == ThemeMode.dark
                  ? Brightness.light
                  : Brightness.dark,
              statusBarBrightness: Brightness.dark,
            ),
          );

          return MaterialApp(
            title: appName,
            debugShowCheckedModeBanner: false,
            themeMode: value.currentTheme,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            initialRoute: isShowSplashScreen
                ? AppRoutes.splashScreen
                : AppRoutes.homeScreen,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
