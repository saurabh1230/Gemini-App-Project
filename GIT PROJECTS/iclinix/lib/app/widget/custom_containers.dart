import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/utils/dimensions.dart';

class CustomDecoratedContainer extends StatelessWidget {
  final Widget child;
  const CustomDecoratedContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius10),
          color: Theme.of(context).primaryColor.withOpacity(0.07)
      ),
      child: child,
    );
  }
}
