import 'package:flutter/material.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/spotters_controller.dart';
import 'package:radiology/data/repo/spotters_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:radiology/features/screens/notes/components/notes_view_component.dart';
import 'package:radiology/features/screens/spotters/components/spotters_content_section.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:radiology/features/widgets/empty_data_widget.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/styles.dart';
import 'package:loop_page_view/loop_page_view.dart';

class SavedNoteScreen extends StatelessWidget {
  SavedNoteScreen({super.key});
  final SpottersRepo noteRepo = Get.put(SpottersRepo(apiClient: Get.find()));
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<BookmarkController>().getSavedNotesPaginatedList('1');
    });
    Get.find<SpottersController>().setOffset(1);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent &&
          Get.find<BookmarkController>().savedNotesList != null &&
          !Get.find<BookmarkController>().isSavedNotesLoading) {
        if (Get.find<BookmarkController>().offset < 10) {
          print(
              "print ===========> offset before ${Get.find<BookmarkController>().offset}");
          Get.find<BookmarkController>()
              .setOffset(Get.find<BookmarkController>().offset + 1);
          Get.find<BookmarkController>().showSavedBottomLoader();
          Get.find<BookmarkController>().getSavedNotesPaginatedList(
            Get.find<BookmarkController>().offset.toString(),
          );
        }
      }
    });

    return GetBuilder<BookmarkController>(builder: (spottersControl) {
      final spottersList = spottersControl.savedNotesList;
      final isListEmpty = spottersList == null || spottersList.isEmpty;
      return
        Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            bottomNavigationBar: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(
                  children: [
                    isListEmpty && !spottersControl.isSavedNotesLoading ?
                        const SizedBox() :
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Slide Right for next ',
                          style: poppinsRegular.copyWith(
                            fontSize: Dimensions.fontSize14,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Image.asset(
                          Images.icdoubleArrowRight,
                          height: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            appBar: const CustomAppBar(
              title: "Saved Notes",
              isBackButtonExist: true,
              backGroundColor: Colors.black,
            ),
            body:  Stack(
              children: [
                isListEmpty && !spottersControl.isSavedNotesLoading ? Padding(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSize100),
                  child: Center(child: EmptyDataWidget(image: Images.emptyDataImage,
                    fontColor:  Theme.of(context).cardColor, text: 'No Saved Notes Yet',)),
                ) :
                // isListEmpty
                //   ? const Center(child: LoaderWidget()) :
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: spottersList!.length,
                  itemBuilder: (context, i) {
                    return GetBuilder<BookmarkController>(
                        builder: (bookmarkControl) {
                          bool isBookmarked = bookmarkControl.bookmarkNoteIdList
                              .contains(spottersList[i].id);
                          return NotesViewComponent(
                            title: spottersList[i].title.toString(),
                            question: spottersList[i].content.toString(),
                            saveNote: () {
                              // isBookmarked ?
                              bookmarkControl.removeNoteBookMarkList(int.parse(spottersList[i].id.toString()));


                              // bookmarkControl.addNoteBookMarkList('',spottersList[i]);
                            },
                            saveNoteColor: /*isBookmarked ?
                            */Theme.of(context).cardColor
                                /*: Theme.of(context).cardColor.withOpacity(0.60)*/,
                          );
                        });
                  },
                ),
                if (spottersControl.isSavedNotesLoading)
                  const Center(child: LoaderWidget()),
              ],
            ),

        ); });


  }
}
