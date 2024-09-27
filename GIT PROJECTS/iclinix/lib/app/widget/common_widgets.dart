import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';

class NotificationButton extends StatelessWidget {
  final Function() tap;
  const NotificationButton({super.key, required this.tap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: tap,
      child: Container(
          padding: const EdgeInsets.all(Dimensions.paddingSize4),
          child: Image.asset(Images.icNotification,height: Dimensions.fontSize24,)),
    );
  }
}
