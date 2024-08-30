import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:radiology/features/widgets/custom_network_image_widget.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:share_plus/share_plus.dart';
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
    required this.onBookMarkTap,
    required this.bookmarkIconColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: onTap,
                          child: Container(
                            height: 400,
                            clipBehavior: Clip.hardEdge,
                            width: Get.size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: Theme.of(context).disabledColor,
                            ),
                            child: CustomNetworkImageWidget(
                              radius: 0,
                              image: '${AppConstants.spottersImageUrl}$spotterImg',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: Dimensions.paddingSizeDefault,
                          right: Dimensions.paddingSizeDefault,
                          child: IconButton(
                            splashColor: Theme.of(context).cardColor,
                            icon: Icon(
                              CupertinoIcons.arrowshape_turn_up_right_fill,
                              color: Theme.of(context).cardColor,
                            ),
                            onPressed: () {
                              Share.share('Check out this content!'); // Replace with your content
                            },
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: Dimensions.paddingSizeDefault,
                      child: InkWell(
                        onTap: onBookMarkTap,
                        child: Container(
                          height: Dimensions.paddingSize100,
                          clipBehavior: Clip.hardEdge,
                          padding: const EdgeInsets.all(Dimensions.paddingSize12),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(Images.icRoundBookmarkBg),
                            ),
                            shape: BoxShape.circle,
                            color: Theme.of(context).cardColor.withOpacity(0.50),
                          ),
                          child: Center(
                            child: Icon(
                              CupertinoIcons.bookmark_fill,
                              color: bookmarkIconColor,
                            ),
                          ),
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: 400),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$categoryTitle: ",
                              style: poppinsBold.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                            HtmlWidget(
                              categoryContent,
                              textStyle: poppinsRegular.copyWith(
                                fontSize: Dimensions.fontSize12,
                                fontWeight: FontWeight.w100,
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 380,
                      left: 16,
                      child: Image.asset(
                        Images.icOutlierTag,
                        width: 120,
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String removePTags(String htmlString) {
    var document = htmlParser.parse(htmlString);
    return document.body?.text ?? '';
  }
}
