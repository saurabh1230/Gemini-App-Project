import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:radiology/controllers/auth_controller.dart';
import 'package:radiology/helper/route_helper.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    _route();
    super.initState();



  }
  void _route() {
    final AuthController authController = Get.find<AuthController>();
    Timer(const Duration(seconds: 1), () async {
      if (Get.find<AuthController>().isLoggedIn()) {
        Get.offNamed(RouteHelper.getHomeRoute());
      } else {
        Get.offNamed(RouteHelper.getSignInRoute());
      }
      // Get.offAllNamed(RouteHelper.getSignInRoute());
      // if (Get.find<AuthController>().isLoggedIn()) {
      //     String username = authController.getUserNumber();
      //     String password = authController.getUserPassword();
      //       authController.login(username, password).then((status) async {
      //         if(status != null) {
      //           if (status.isSuccess) {
      //             authController.saveUserNumberAndPassword(
      //                 username,
      //                 password
      //             );
      //
      //           /*  if (authController.isActiveRememberMe) {
      //               authController.saveUserNumberAndPassword(username, password);
      //             } else {
      //               authController.clearUserNumberAndPassword();
      //             }*/
      //             Get.offAllNamed(RouteHelper.getMainRoute());
      //           }else {
      //             Get.offAllNamed(RouteHelper.getSignInRoute());
      //             // showCustomSnackBar("Login Failed",isError: true);
      //
      //           }
      //         }
      //       });

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Container(
          decoration:   BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Center(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Images.logo,width: 80,),
                sizedBoxDefault(),
                RichText(
                  text:  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Dr Outlier',
                        style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize24,
                        color: Theme.of(context).primaryColor)
                        ),
                      TextSpan(
                        text: ' Radiology',
                        style: poppinsExtraBold.copyWith(fontSize: Dimensions.fontSize24,
                            color: Theme.of(context).primaryColor), // Different color for "resend"
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

    );


  }
}
