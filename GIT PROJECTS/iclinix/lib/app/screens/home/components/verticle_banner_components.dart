import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_button_widget.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';

class VerticalBannerComponents extends StatelessWidget {
  const VerticalBannerComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(Images.imgReferHomeBanner),
          sizedBoxDefault(),
          Image.asset(Images.imgBookAppointmentHomeBanner),
          sizedBoxDefault(),
          Image.asset(Images.imgDiabetesHomeBanner),


        ],
      ),
    );
  }
}
