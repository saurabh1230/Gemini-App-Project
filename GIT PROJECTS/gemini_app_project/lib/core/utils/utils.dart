import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gemini_app_project/core/constants/strings.dart';

dialogue(
  BuildContext context, {
  required String title,
  onPressedRight,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.no),
        ),
        TextButton(
          onPressed: onPressedRight,
          child: const Text(AppStrings.yes),
        ),
      ],
    ),
  );
}

// Snackbar
snackbar(BuildContext context, String text, {Color? backgroundColor}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text, style: const TextStyle(color: Colors.white)),
      backgroundColor: backgroundColor,
      action: SnackBarAction(
        label: AppStrings.dismiss,
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    ),
  );
}

//Generate Random Id
String randomId({int count = 25}) {
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  math.Random rnd = math.Random();
  return String.fromCharCodes(
    Iterable.generate(
      count,
      (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
    ),
  );
}
