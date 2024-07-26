// import 'package:flutter/material.dart';
// import 'package:radiology/controllers/notes_controller.dart';
// import 'package:radiology/features/screens/custom_appbar.dart';
// import 'package:radiology/features/screens/notes/components/note_selectio_section.dart';
// import 'package:radiology/features/widgets/custom_loading_widget.dart';
// import 'package:radiology/helper/route_helper.dart';
// import 'package:radiology/utils/dimensions.dart';
// import 'package:radiology/utils/sizeboxes.dart';
// import 'package:radiology/utils/styles.dart';
// import 'package:get/get.dart';
//
// class SpottersListScreen extends StatelessWidget {
//   const SpottersCategoryScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Get.find<NotesController>().getNoteList();
//     });
//
//     return Scaffold(
//         appBar: const CustomAppBar(
//             isBackButtonExist: true,
//             title: "NOTES"),
//         body: SingleChildScrollView(
//             child: GetBuilder<NotesController>(builder: (noteControl) {
//               return noteControl.isNoteLoading ?
//               const LoaderWidget():
//               Column(
//                 children: [
//                   Text('Select topic to know',style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
//                       color: Theme.of(context).cardColor.withOpacity(0.50)),),
//                   sizedBoxDefault(),
//                   ListView.separated(
//                     padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
//                     itemCount: noteControl.noteList!.length,
//                     shrinkWrap: true,
//                     itemBuilder: (_,i) {
//                       return NotesSelectionSelection(tap: () {
//                         Get.toNamed(RouteHelper.getNotesDashboardRoute(noteControl.noteList![i].id.toString(),noteControl.noteList![i].name.toString()));
//                       }, title: noteControl.noteList![i].name.toString(),
//                         colorString: noteControl.noteList![i].color.toString(),);
//                     }, separatorBuilder: (BuildContext context, int index) => sizedBoxDefault(),)
//
//
//
//                 ],
//               );
//             })
//
//         )
//     );
//   }
// }
