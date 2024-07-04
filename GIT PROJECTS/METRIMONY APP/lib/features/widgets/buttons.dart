import 'package:flutter/material.dart';

Widget backButton({
  required BuildContext context,
  required String image,
  required Function() onTap,
}) {
  return  Align(
    alignment: Alignment.centerLeft,
    child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: SizedBox(
        height: 40,
        width: 40,
        child: Image.asset(image,
        ),
      ),
    ),
  );
}

