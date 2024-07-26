import 'package:flutter/cupertino.dart';
import 'package:outlier_radiology_app/utils/images.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Images.emptyDataImage,height: 120,)
      ],
    );
  }
}
