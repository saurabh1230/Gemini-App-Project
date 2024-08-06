import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radiology/controllers/notes_controller.dart';
import 'package:radiology/data/model/response/note_list_model.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/styles.dart';
import 'package:get/get.dart';

class NotesSelectionSelection extends StatelessWidget {
  final Function() tap;
  final NoteListModel? noteListModel;


  const NotesSelectionSelection({
    super.key,
    required this.tap,
    this.noteListModel,
  });

  Color _parseColor(String colorString) {
    final cleanedColorString = colorString.replaceFirst('#', '');
    final colorInt = int.parse(cleanedColorString, radix: 16);
    return Color(colorInt | 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(builder: (noteControl) {
      final color = _parseColor(noteListModel!.color.toString());
      print(noteListModel!.readnotes);
      return Column(
        children: [
          InkWell(
            onTap: tap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSize12,horizontal:Dimensions.paddingSize12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(Dimensions.radius5),
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      noteListModel!.name.toString(),
                      // title,
                      style: poppinsRegular.copyWith(
                        fontSize: Dimensions.fontSize14,
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                    Text(
                      'Completed ${noteListModel!.readnotes} / ${noteListModel!.notesCount}',
                      style: poppinsRegular.copyWith(
                        fontSize: 8,
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // if (isExpanded && noteListModel!.child != null && noteListModel!.child!.isNotEmpty)
          //   Column(
          //     children: [
          //       sizedBoxDefault(),
          //       ListView.separated(
          //         padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize10),
          //         itemCount: noteListModel!.child!.length,
          //         shrinkWrap: true,
          //         physics: const NeverScrollableScrollPhysics(),
          //         itemBuilder: (context, i) {
          //           final child = noteListModel!.child![i];
          //           return InkWell(
          //             onTap: () {
          //               Get.toNamed(RouteHelper.getNotesDashboardRoute(
          //                 noteListModel!.child![i].id.toString(),
          //                 noteListModel!.child![i].name.toString(),
          //               ));
          //             },
          //             child: Container(
          //               padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSize12,horizontal:Dimensions.paddingSize12),
          //               decoration: BoxDecoration(
          //                 color: Theme.of(context).cardColor,
          //                 borderRadius: BorderRadius.circular(Dimensions.radius5),
          //               ),
          //               child: Center(
          //                 child: Text(
          //                   child.name.toString(),
          //                   style: poppinsRegular.copyWith(
          //                     fontSize: Dimensions.fontSize13,
          //                     color: Theme.of(context).disabledColor,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           );
          //         }, separatorBuilder: (BuildContext context, int index) => sizedBoxDefault(),
          //       ),
          //     ],
          //   ),
        ],
      );
    });
  }
}


