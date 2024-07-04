


// import 'package:bureau_couple/src/constants/colors.dart';
// import 'package:bureau_couple/src/models/LoginResponse.dart';
// import 'package:bureau_couple/src/views/home/home_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bureau_couple/features/views/auth/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:bureau_couple/helper/route_helper.dart';

// import '../../apis/login/login_api.dart';
// import '../../constants/shared_prefs.dart';
// import '../onboarding/onboarding_screen.dart';
// import '../onboarding/welcome_screen.dart';
// import '../signIn/sign_in_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setScreen();
    // setPage();
  }

  setScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.toNamed(RouteHelper.getWelcomeRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Image.asset("assets/icons/ic_heart1.png",
                    height: 150,)),
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  height: 150,
                  "assets/icons/ic_heart2.png",
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "assets/icons/ic_heart3.png",
                  height: 150,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  height: 150,
                  "assets/icons/ic_heart2.png",
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  height: 150,
                  "assets/icons/ic_bottom_right.png",
                ),
              ),
            ],
          ),
          Center(
            child: Image.asset(
              'assets/icons/ic_splash_logo.png',
              color: Colors.white,
              height: 111,
              width: 237,
            ),
          ),
        ],
      ),
      // body: Column(
      //   children: [
      //     Container(
      //       height: 1.sh,
      //       decoration: const BoxDecoration(
      //         image: DecorationImage(
      //             image: AssetImage(icSplashBg,
      //             ),
      //         fit: BoxFit.cover)
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
