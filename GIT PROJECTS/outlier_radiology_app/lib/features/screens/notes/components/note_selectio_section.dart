import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outlier_radiology_app/controllers/notes_controller.dart';
import 'package:outlier_radiology_app/helper/route_helper.dart';
import 'package:outlier_radiology_app/utils/dimensions.dart';
import 'package:outlier_radiology_app/utils/sizeboxes.dart';
import 'package:outlier_radiology_app/utils/styles.dart';
import 'package:get/get.dart';

class NotesSelectionSelection extends StatelessWidget {
  final Function() tap;
  final String title;
  final String colorString;

  const NotesSelectionSelection({
    super.key,
    required this.tap,
    required this.title,
    required this.colorString,
  });

  // Function to convert hex color string to Color
  Color _parseColor(String colorString) {
    // Remove the leading '#' if present
    final cleanedColorString = colorString.replaceFirst('#', '');
    // Parse the string to an integer and convert to Color
    final colorInt = int.parse(cleanedColorString, radix: 16);
    // Handle ARGB format
    return Color(colorInt | 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(builder: (noteControl) {
      // Parse the color string
      final color = _parseColor(colorString);

      return InkWell(
        onTap: tap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSize12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(Dimensions.radius5),
          ),
          child: Center(
            child: Text(
              title,
              style: poppinsRegular.copyWith(
                fontSize: Dimensions.fontSize13,
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
        ),
      );
    });
  }
}

