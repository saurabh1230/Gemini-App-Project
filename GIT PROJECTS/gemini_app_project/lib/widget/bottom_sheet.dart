import 'package:flutter/material.dart';
import 'package:gemini_app_project/core/constants/colors.dart';
import 'package:gemini_app_project/core/utils/extension.dart';

void openBottomSheet(
  BuildContext context, {
  required void Function() onTabImageGallery,
  required void Function() onTabImageCamera,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 200,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Select/Capture Photo',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 3,
                  child: const SizedBox(
                    height: 80,
                    width: 80,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.photo_library,
                      ),
                    ),
                  ).ripple(onTabImageGallery),
                ),
                const SizedBox(
                  width: 20,
                ),
                Card(
                  elevation: 3,
                  child: const SizedBox(
                    height: 80,
                    width: 80,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.photo_camera,
                      ),
                    ),
                  ).ripple(onTabImageCamera),
                ),
              ],
            ),
          ],
        ),
      );
    },
    backgroundColor:
        Theme.of(context).brightness == Brightness.dark ? darkGrey : whiteGrey,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
  );
}
