import 'dart:ui';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaderWidget extends StatelessWidget {
  final bool isBlurBackground;
  final Color? loaderColor;

  const LoaderWidget(
      {super.key, this.loaderColor, this.isBlurBackground = false});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
        child: SizedBox(
      height: Get.height,
      width: Get.width,
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 1.0, sigmaY: 1.0, tileMode: TileMode.mirror),
        child:
            Center(
              child: Lottie.asset('assets/images/Animation - 1721799150210.json', height: 80),
            ),
            ),
      ),
    );
  }
}
