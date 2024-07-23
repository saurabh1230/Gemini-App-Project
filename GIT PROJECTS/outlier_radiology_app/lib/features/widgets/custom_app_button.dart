import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlier_radiology_app/utils/dimensions.dart';
import 'package:outlier_radiology_app/utils/sizeboxes.dart';
import 'package:outlier_radiology_app/utils/styles.dart';

class CustomButtonWidget extends StatelessWidget {
  final Function? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final bool isLoading;
  final bool isBold;
  final String? suffixIconPath; // New parameter for the suffix icon path

  const CustomButtonWidget({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.transparent = false,
    this.margin,
    this.width,
    this.height,
    this.fontSize,
    this.radius = 10,
    this.icon,
    this.color,
    this.textColor,
    this.isLoading = false,
    this.isBold = true,
    this.suffixIconPath, // Initialize the new parameter
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
          ? Colors.transparent
          : color ?? Theme.of(context).primaryColor,
      minimumSize: Size(width != null ? width! : Dimensions.webMaxWidth,
          height != null ? height! : 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
          color: Theme.of(context).primaryColor, // Specify the color of the border
          width: 1, // Specify the width of the border
        ),
      ),
    );

    return Center(
      child: SizedBox(
        width: width ?? Dimensions.webMaxWidth,
        child: Padding(
          padding: margin == null ? const EdgeInsets.all(0) : margin!,
          child: TextButton(
            onPressed: isLoading ? null : onPressed as void Function()?,
            style: flatButtonStyle,
            child: isLoading
                ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSize10),
                  Text('Loading', style: poppinsMedium.copyWith(color: Colors.white)),
                ],
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Icon(
                      icon,
                      color: transparent
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor,
                      size: Dimensions.fontSizeDefault,
                    ),
                  ),
                sizedBoxW5(),
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: isBold
                      ? poppinsBold.copyWith(
                    color: textColor ??
                        (transparent
                            ? Theme.of(context).primaryColor
                            : Colors.white),
                    fontSize: fontSize ?? Dimensions.fontSize18,
                  )
                      : poppinsSemiBold.copyWith(
                    color: textColor ??
                        (transparent
                            ? Theme.of(context).primaryColor
                            : Colors.white),
                    fontSize: fontSize ?? Dimensions.fontSizeDefault,
                  ),
                ),
                if (suffixIconPath != null) ...[
                  sizedBoxW5(),
                  Image.asset(
                    suffixIconPath!,
                    height: Dimensions.paddingSize10,
                    width: Dimensions.paddingSize10,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
