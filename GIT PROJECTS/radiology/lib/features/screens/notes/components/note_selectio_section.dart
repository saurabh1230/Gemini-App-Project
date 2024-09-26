import 'dart:ui';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radiology/controllers/notes_controller.dart';
import 'package:radiology/data/model/response/note_list_model.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/styles.dart';
import 'package:get/get.dart';

class NotesSelectionSelection extends StatelessWidget {
  final Function() tap;
  final String? title;
  final String? colorString;
  final String? topics;

  const NotesSelectionSelection({
    super.key,
    required this.tap,
    this.title, // Allow nullable but handle it
    this.colorString,
    this.topics,
  });

  Color _parseColor(String? colorString) {
    // Handle potential null values for colorString
    if (colorString == null || colorString.isEmpty) {
      return Colors.grey; // Default fallback color if colorString is null or empty
    }

    final cleanedColorString = colorString.replaceFirst('#', '');
    final colorInt = int.parse(cleanedColorString, radix: 16);
    return Color(colorInt | 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    final color = _parseColor(colorString);

    return Column(
      children: [
        InkWell(
          onTap: tap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.paddingSize12,
              horizontal: Dimensions.paddingSize12,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(Dimensions.radius5),
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    title ?? 'No Title', // Provide default text if title is null
                    style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSize14,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  Text(
                    topics ?? 'No Topics', // Provide default text if topics is null
                    style: poppinsRegular.copyWith(
                      fontSize: 8,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}



