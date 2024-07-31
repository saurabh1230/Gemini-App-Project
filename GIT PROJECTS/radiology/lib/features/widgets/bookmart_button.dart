import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';

class BookMarkButton extends StatelessWidget {
  final Function()  tap;
  final Color color;
  const BookMarkButton({super.key, required this.tap, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
          height:Dimensions.paddingSize100,
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.all(Dimensions.paddingSize12),
          decoration: BoxDecoration(
            image: const DecorationImage(image: AssetImage(Images.icRoundBookmarkBg)),
            shape: BoxShape.circle,
            color: Theme.of(context).cardColor.withOpacity(0.50),
          ),

          child:  Center(child: Icon(CupertinoIcons.bookmark_fill,color: color,))),
    );
  }
}
