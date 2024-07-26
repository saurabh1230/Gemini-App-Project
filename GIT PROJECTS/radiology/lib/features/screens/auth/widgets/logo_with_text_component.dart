import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';

class LogoWithTextComponent extends StatelessWidget {
  const LogoWithTextComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Images.logo,width: 80,),
        sizedBoxDefault(),
        RichText(
          text:  TextSpan(
            children: [
              TextSpan(
                  text: 'Dr Outlier',
                  style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize12,
                      color: Theme.of(context).primaryColor)
              ),
              TextSpan(
                text: ' Radiology',
                style: poppinsBold.copyWith(fontSize: Dimensions.fontSize12,
                    color: Theme.of(context).primaryColor), // Different color for "resend"
              ),
            ],
          ),
        ),
      ],
    );
  }
}
