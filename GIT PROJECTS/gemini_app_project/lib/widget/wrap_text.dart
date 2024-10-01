import 'package:flutter/material.dart';

class WrapText extends StatelessWidget {
  final String title;
  final String text;
  const WrapText({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
