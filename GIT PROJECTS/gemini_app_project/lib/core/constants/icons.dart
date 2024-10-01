import 'package:flutter/material.dart';
import 'package:gemini_app_project/core/constants/constants.dart';

extension AppIcons on ColorScheme {
  String get splashLogo => '${assetPath}splash_logo.svg';
  String get pulseLottie => '${lottiePath}pulse.json';
  String get galleryIcon => '${assetPath}gallery.svg';
  String get sendIcon => '${assetPath}send.svg';
  String get loadingLottie => '${lottiePath}loading.json';
}
