import 'package:anuplal/utils/images.dart';
import 'package:flutter/material.dart';

class CustomNotificationButton extends StatelessWidget {
  final Function() tap;
  const CustomNotificationButton({super.key, required this.tap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: tap,
        child: Image.asset(Images.icNotification,height: 24,width: 24,));
  }
}


class CustomCartButton extends StatelessWidget {
  final Function() tap;
  const CustomCartButton({super.key, required this.tap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: tap,
        child: Image.asset(Images.icCart,height: 24,width: 24,));
  }
}
