import 'package:flutter/material.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';

class GoogleSignInButton extends StatelessWidget {
  final Function() tap;
  const GoogleSignInButton({super.key, required this.tap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(width: 0.5,color: Theme.of(context).cardColor)
        ),
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSize8,horizontal: Dimensions.paddingSize10),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.googleLogo,height: 28,width: 28,),
            sizedBoxW5(),
            Text('Continue with Google',style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize12,
                color: Theme.of(context).cardColor),)
          ],),
      ),
    );
  }
}


class CustomRoundButton extends StatelessWidget {
  final Widget child;
  final double? padding;
  final Color? bgColor;
  final Function() tap;
  const CustomRoundButton({super.key, required this.child,  this.padding = Dimensions.paddingSizeDefault, this.bgColor, required this.tap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        padding:  EdgeInsets.all(padding!),
        decoration: BoxDecoration(
            color: bgColor ?? Theme.of(context).primaryColor.withOpacity(0.40),
            shape: BoxShape.circle
        ),
        child: child,
      ),
    );
  }
}
