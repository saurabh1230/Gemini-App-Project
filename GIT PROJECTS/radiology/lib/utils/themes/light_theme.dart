import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  useMaterial3: false,
  fontFamily: 'Sen',
  primaryColor: const Color(0xFF1EC7FD),
  secondaryHeaderColor: const Color(0xFF000743),
  disabledColor: const Color(0xFF000000),
  brightness: Brightness.light,
  hintColor:  const Color(0xff282D41).withOpacity(0.40),
  cardColor: Colors.white,
  canvasColor: const Color(0xff282D41),
  backgroundColor: const Color(0xff1B1E27),
  scaffoldBackgroundColor: const Color(0xff1b1e27),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      fillColor: MaterialStateProperty.all(Colors.transparent),
      side: MaterialStateBorderSide.resolveWith(
            (states) => const BorderSide(
          color: Colors.white, // Custom border color
          width: 1,
        ),
      )),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(0xFF126E97))), colorScheme: const ColorScheme.light(primary: Color(0xFF126E97), secondary: Color(0xFF126E97)).copyWith(error: const Color(0xFF126E97)),
);

const Color redColor = Color(0xffB43642);
const Color greenColor = Color(0xff17AD2F);
const Color greyColor = Color(0xff83A2AF);
const Color skyColor = Color(0xff46C8D0);
const Color darkBlueColor = Color(0xff517DA5);
const Color darkPinkColor = Color(0xffBC6868);
