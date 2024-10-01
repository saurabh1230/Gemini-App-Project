import 'package:flutter/material.dart';
import 'package:gemini_app_project/core/constants/colors.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final void Function()? onPressed;
  const GradientButton({
    super.key,
    required this.text,
    this.iconData,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            gradientMain1,
            gradientMain2,
          ],
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Wrap(
          children: [
            Text(
              text,
              style: const TextStyle(
                color: gradient3,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (iconData != null) ...[
              const SizedBox(width: 10),
              Icon(
                iconData,
                color: gradient3,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
