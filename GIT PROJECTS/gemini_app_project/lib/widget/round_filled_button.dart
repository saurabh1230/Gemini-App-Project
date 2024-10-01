import 'package:flutter/material.dart';
import 'package:gemini_app_project/core/constants/colors.dart';

class RoundFilledButton extends StatelessWidget {
  const RoundFilledButton({super.key, this.text, this.icon, this.onPressed});

  final String? text;
  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor:
            const MaterialStatePropertyAll<Color>(Colors.transparent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              color: menuTextColor3,
            ),
          ),
        ),
        overlayColor:
            MaterialStatePropertyAll<Color>(accentColor.withOpacity(0.2)),
        padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.zero,
        ),
      ),
      onPressed: onPressed,
      child: icon != null
          ? Icon(icon, color: menuTextColor)
          : Text(
              text ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
    );
  }
}
