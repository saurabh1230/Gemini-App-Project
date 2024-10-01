import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini_app_project/core/constants/colors.dart';
import 'package:gemini_app_project/core/constants/constants.dart';
import 'package:gemini_app_project/core/constants/icons.dart';
import 'package:gemini_app_project/core/routes/app_routes.dart';
import 'package:gemini_app_project/core/utils/hive_box.dart';
import 'package:gemini_app_project/widget/gradient_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    nextPage();
  }

  nextPage() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () async {
      if (isShowOnboardingScreen &&
          (HiveBoxPref.getBool(isFIrstTimeUserKey) ?? true)) {
        Navigator.pushReplacementNamed(context, AppRoutes.onBoardingScreen);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        height: double.maxFinite,
        width: MediaQuery.of(context).size.width,
        color: splashBackColor2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Theme.of(context).colorScheme.splashLogo,
              width: 200,
              height: 200,
            ),
            const SizedBox(
              height: 30,
            ),
            const GradientText(
              appName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
