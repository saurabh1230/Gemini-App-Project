
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:radiology/features/widgets/custom_network_image_widget.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';

class SpotterContentWidget extends StatelessWidget {
  final String spotterImg;
  final String categoryTitle;
  final String categoryContent;
  final Function() onTap;
  final Function() onBookMarkTap;
  final Color bookmarkIconColor;

  const SpotterContentWidget({
    required this.onTap,
    required this.spotterImg,
    required this.categoryTitle,
    required this.categoryContent,
    Key? key, required this.onBookMarkTap, required this.bookmarkIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor.withOpacity(0.90),
      // bottomNavigationBar: SingleChildScrollView(
      //   child: Align(
      //     child: Padding(
      //       padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      //       child: Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Image.asset(
      //                 Images.icdoubleArrowUp,
      //                 height: 18,
      //               ),
      //               Text(
      //                 '  Swipe for next',
      //                 style: poppinsRegular.copyWith(
      //                   fontSize: Dimensions.fontSize14,
      //                   color: Theme.of(context).primaryColor,
      //                 ),
      //               )
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  InkWell( onTap: onTap,
                    child: Container(
                      height: 400,
                      clipBehavior: Clip.hardEdge,
                      width: Get.size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: CustomNetworkImageWidget(
                        radius: 0,
                        image: '${AppConstants.spottersImageUrl}$spotterImg',
                      ),
                    ),
                  ),
                  Positioned(top: 0,right: Dimensions.paddingSizeDefault,
                      child: InkWell(
                        onTap: onBookMarkTap,
                        child: Container(
                            height:Dimensions.paddingSize100,
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsets.all(Dimensions.paddingSize12),
                            decoration: BoxDecoration(
                              image: const DecorationImage(image: AssetImage(Images.icRoundBookmarkBg)),
                              shape: BoxShape.circle,
                              color: Theme.of(context).cardColor.withOpacity(0.50),
                            ),

                            child:  Center(child: Icon(CupertinoIcons.bookmark_fill,color: bookmarkIconColor,))),
                      )
                  ),

                  Padding(
                    padding: const EdgeInsets.only( top: 400),
                    child: Container(
                      width: Get.size.width,
                      height: Get.size.height,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        // borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        boxShadow: [BoxShadow(
                          color: Theme.of(context).disabledColor.withOpacity(0.50),
                          blurRadius: 8, spreadRadius: 8,
                        )],
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$categoryTitle : ",
                                style: poppinsBold.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: Theme.of(context).disabledColor,
                                ),
                              ),
                              Text(
                                removePTags(categoryContent),
                                style: poppinsRegular.copyWith(
                                  fontSize: Dimensions.fontSize12,
                                  fontWeight: FontWeight.w100,
                                  color: Theme.of(context).disabledColor,
                                ),
                              ),
                              // sizedBox20(),
                              Text('Slide Right For More ....',style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize12,
                              color: Theme.of(context).primaryColor),),
                              const SizedBox(height: 500,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 380,left: 16,
                      child: Image.asset(Images.icOutlierTag,width: 120,))
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  String removePTags(String htmlString) {
    var document = htmlParser.parse(htmlString);
    return document.body!.text;
  }
}
