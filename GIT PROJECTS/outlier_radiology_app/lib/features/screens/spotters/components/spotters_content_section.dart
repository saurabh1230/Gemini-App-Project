import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outlier_radiology_app/utils/dimensions.dart';
import 'package:outlier_radiology_app/utils/images.dart';
import 'package:outlier_radiology_app/utils/sizeboxes.dart';
import 'package:get/get.dart';
import 'package:outlier_radiology_app/utils/styles.dart';
import 'package:html/parser.dart' as htmlParser;
class SpotterContentWidget extends StatelessWidget {
  final String spotterImg;
  final String categoryTitle;
  final String categoryContent;
  SpotterContentWidget(this.spotterImg, this.categoryTitle, this.categoryContent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SingleChildScrollView(child: Align(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.icdoubleArrowUp,height: 18,),
              Text('  Swipe for next',style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                  color: Theme.of(context).primaryColor),)

            ],),
        ),
      ),),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            clipBehavior: Clip.hardEdge,
            width: Get.size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius5)
            ),
            child: Image.asset(spotterImg,fit: BoxFit.cover,),
          ),
          sizedBoxDefault(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${categoryTitle} : ",style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).cardColor)),
                Text(removePTags(categoryContent.toString()),
                    style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize12,
                        fontWeight: FontWeight.w100,
                        color: Theme.of(context).cardColor)),
              ],
            ),
          ),
          sizedBox10(),

      
      
        ],
      ),
    );}
  String removePTags(String htmlString) {
    var document = htmlParser.parse(htmlString);
    return document.body!.text;
  }
}