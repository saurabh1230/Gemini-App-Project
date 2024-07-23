import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:outlier_radiology_app/features/screens/auth/widgets/buttons.dart';
import 'package:outlier_radiology_app/utils/dimensions.dart';
import 'package:outlier_radiology_app/utils/sizeboxes.dart';
import 'package:outlier_radiology_app/utils/styles.dart';
import 'package:outlier_radiology_app/utils/themes/light_theme.dart';
import 'package:html/parser.dart' as htmlParser;
class NotesViewComponent extends StatelessWidget {
  final String title;
  final String question;
  const NotesViewComponent({super.key, required this.title, required this.question});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          sizedBox10(),
          Text(title,
          style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).cardColor),),
          // sizedBox10(),
          // Row(crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     CustomRoundButton(
          //       bgColor: redColor.withOpacity(0.20),
          //       padding: 2,
          //         tap: () {  },
          //         child: const Icon(Icons.close,color: redColor,)),
          //     sizedBoxW5(),
          //     Expanded(
          //       child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
          //       maxLines: 2,
          //       overflow: TextOverflow.ellipsis,
          //       style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,color: redColor),),
          //     )
          //   ],
          // ),
          // sizedBox10(),
          // Row(crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     CustomRoundButton(
          //         bgColor: greenColor.withOpacity(0.20),
          //         padding: 2,
          //         tap: () {  },
          //         child: const Icon(Icons.close,color: greenColor,)),
          //     sizedBoxW5(),
          //     Expanded(
          //       child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
          //         maxLines: 2,
          //         overflow: TextOverflow.ellipsis,
          //         style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,color: greenColor),),
          //     ),
          //   ],
          // ),
          sizedBox10(),
          // HtmlWidget(details,textStyle: nunitoSansLight,)
          // HtmlWidget(question,
          //   textStyle: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).cardColor),)
          Text(removePTags(question.toString()),
          style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).cardColor),)
        ],
      ),
    );
  }
  String removePTags(String htmlString) {
    var document = htmlParser.parse(htmlString);
    return document.body!.text;
  }
}
