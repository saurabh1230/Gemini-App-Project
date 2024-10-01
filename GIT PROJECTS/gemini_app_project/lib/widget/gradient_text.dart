import 'package:flutter/material.dart';
import 'package:gemini_app_project/core/constants/colors.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    this.style,
  });
  final String text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          gradient1,
          gradient2,
          gradient3,
        ],
        stops: [
          0.0,
          0.6,
          1,
        ],
      ).createShader(
        Rect.fromLTWH(10, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
