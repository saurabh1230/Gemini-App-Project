import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';

class EmptyDataWidget extends StatelessWidget {
  final String image;
  final Color? fontColor;
  final String text;
  const EmptyDataWidget({super.key,required this.image, this.fontColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image,height: 120,),
        sizedBox10(),
        Text(text,style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,color:fontColor?? Theme.of(context).cardColor),)
      ],
    );
  }
}
