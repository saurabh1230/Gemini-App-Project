
import 'dart:ui';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoaderWidget extends StatelessWidget {
  final bool isBlurBackground;
  final Color? loaderColor;

  const LoaderWidget({super.key, this.loaderColor, this.isBlurBackground = false});

  @override
  Widget build(BuildContext context) {
    return  AbsorbPointer(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0, tileMode: TileMode.mirror),
          child:  Center(child: const CircularProgressIndicator())
          // SizedBox(
          //   height: Get.height * 0.1,
          //   child: Lottie.asset('assets/images/Blue circle.json', height: 200),
          //   child: AppShaderWidget(
          //     color: isDarkMode.value ? white : null,
          //     child: const RiveAnimation.asset(
          //       Assets.riveLoadingAnimation,
          //       fit: BoxFit.fitHeight,
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}