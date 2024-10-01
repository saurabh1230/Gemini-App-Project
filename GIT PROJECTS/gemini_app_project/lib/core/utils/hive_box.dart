import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:gemini_app_project/core/constants/constants.dart';

// Local data storage
class HiveBoxPref {
  static int getTheme() {
    return Hive.box(themeBox)
        .get(themeSettingKey, defaultValue: ThemeMode.light.index);
  }

  static setTheme(int value) {
    Hive.box(themeBox).put(themeSettingKey, value);
  }

  static setBool(String key, bool value) {
    Hive.box(primeBox).put(key, value);
  }

  static bool? getBool(String key) {
    return Hive.box(primeBox).get(key);
  }
}
