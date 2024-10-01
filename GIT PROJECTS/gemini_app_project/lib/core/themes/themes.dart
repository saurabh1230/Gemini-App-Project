import 'package:flutter/material.dart';
import 'package:gemini_app_project/core/constants/colors.dart';

class AppThemes {
  // Dark theme
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColorDarkTheme,
    colorScheme: const ColorScheme.dark(),
    fontFamily: 'Inter',
    useMaterial3: true,
    primaryColor: whiteColor1,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: menuTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(color: menuTextColor, fontSize: 16),
      bodySmall: TextStyle(color: menuTextColor, fontSize: 12),
    ),
    iconTheme: const IconThemeData(color: menuTextColor),
    cardColor: primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: TextStyle(
        color: menuTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(color: menuTextColor1),
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll<Color>(menuTextColor1),
      ),
    ),
    dividerTheme: const DividerThemeData(color: menuTextColor3),
    switchTheme: const SwitchThemeData(
      thumbColor: MaterialStatePropertyAll<Color>(menuTextColor1),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: menuTextColor1,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: whiteGrey,
    ),
    drawerTheme:
        const DrawerThemeData(backgroundColor: backgroundColorDarkTheme),
  );

  // Light theme
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColorLightTheme,
    colorScheme: const ColorScheme.light(),
    fontFamily: 'Inter',
    primarySwatch: primaryColors,
    primaryColor: primaryColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: menuTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(color: menuTextColor, fontSize: 16),
      bodySmall: TextStyle(color: menuTextColor, fontSize: 12),
    ),
    iconTheme: const IconThemeData(color: menuTextColor),
    cardColor: whiteColor1,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor1,
      titleTextStyle: TextStyle(
        color: menuTextColor1,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(color: menuTextColor),
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll<Color>(menuTextColor),
      ),
    ),
    dividerTheme: const DividerThemeData(color: menuTextColor3),
    switchTheme: const SwitchThemeData(
      trackOutlineColor: MaterialStatePropertyAll<Color>(menuTextColor),
      thumbColor: MaterialStatePropertyAll<Color>(menuTextColor),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: menuTextColor1,
    ),
    drawerTheme:
        const DrawerThemeData(backgroundColor: backgroundColorLightTheme),
  );
}
