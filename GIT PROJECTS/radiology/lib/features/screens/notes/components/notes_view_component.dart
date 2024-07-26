import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radiology/features/screens/auth/widgets/buttons.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
import 'package:radiology/utils/themes/light_theme.dart';
import 'package:html/parser.dart' as htmlParser;
class NotesViewComponent extends StatelessWidget {
  final String title;
  final String question;
  final Function() saveNote;
  final Color saveNoteColor;
  const NotesViewComponent({super.key, required this.title, required this.question, required this.saveNote, required this.saveNoteColor});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeDefault),
        child: Column(
          children: [
            // sizedBox10(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).cardColor),),
                InkWell(
                  onTap: saveNote,
                  child: Container(
                      height:Dimensions.paddingSize65,
                      clipBehavior: Clip.hardEdge,
                      padding: const EdgeInsets.all(Dimensions.paddingSize12),
                      decoration: BoxDecoration(
                        image: const DecorationImage(image: AssetImage(Images.icRoundBookmarkBg)),
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor.withOpacity(0.50),
                      ),

                      child:  Center(child: Icon(CupertinoIcons.bookmark_fill,color: saveNoteColor,))),
                )
              ],
            ),
            Text(removePTags(question.toString()),
            style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize12,color: Theme.of(context).cardColor),),
            Align(alignment: Alignment.centerLeft,
              child: Text('Slide Right For More ....',
                textAlign: TextAlign.left,
                style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize12,
                  color: Theme.of(context).primaryColor),),
            ),
            sizedBox100(),

          ],
        ),
      ),
    );
  }
  String removePTags(String htmlString) {
    var document = htmlParser.parse(htmlString);
    return document.body!.text;
  }
}
