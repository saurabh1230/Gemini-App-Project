import 'package:flutter/material.dart';
import 'package:gemini_app_project/core/utils/hive_box.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _currentThemeMode = ThemeMode.system;

  ThemeMode get currentTheme => _currentThemeMode;

  bool get isDarkMode {
    if (_currentThemeMode == ThemeMode.system) {
      return _currentThemeMode == ThemeMode.light;
    } else {
      return _currentThemeMode == ThemeMode.dark;
    }
  }

  ThemeProvider(ThemeMode mode) {
    _currentThemeMode =
        (mode == ThemeMode.dark ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme(bool value) {
    _currentThemeMode = value
        ? ThemeMode.dark
        : ThemeMode.light;

    // Save theme to Hive
    saveThemeToHive();

    notifyListeners();
  }

  // Method to save the theme state to Hive
  void saveThemeToHive() {
    HiveBoxPref.setTheme(_currentThemeMode.index);
  }
}
