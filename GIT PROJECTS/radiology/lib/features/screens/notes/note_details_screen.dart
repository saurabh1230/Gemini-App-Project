import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/notes_controller.dart';
import 'package:radiology/data/repo/note_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/features/screens/notes/components/notes_view_component.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:radiology/features/widgets/empty_data_widget.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/styles.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';


class NotesDashboard extends StatelessWidget {
  final String? categoryId;
  final String? categoryName;

  NotesDashboard({super.key, required this.categoryId, this.categoryName});
  final NotesController notesController = Get.put(NotesController(noteRepo: Get.find()));
  final NoteRepo notesRp = Get.put(NoteRepo(apiClient: Get.find()));
  final LoopPageController _loopPageController = LoopPageController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });

    return GetBuilder<NotesController>(builder: (noteControl) {
      final noteList = noteControl.categoryNoteList;
      final isListEmpty = noteList == null || noteList.isEmpty;
      final pageIndex = noteControl.currentPageIndex.value;

      return SafeArea(
        child: Scaffold(
          floatingActionButton: IconButton(
            splashColor: Theme.of(context).cardColor,
            icon: Icon(
              CupertinoIcons.arrowshape_turn_up_right_fill,
              color: Theme.of(context).disabledColor,
            ),
            onPressed: () {
              Share.share(AppConstants.shareContent);
            },
          ),
          backgroundColor: Theme.of(context).cardColor,
          appBar: CustomAppBar(
            title: categoryName ?? 'Notes',
            isBackButtonExist: true,
            backGroundColor: Colors.black,
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSize12,
                      horizontal: Dimensions.paddingSize8,
                    ),
                    color: Theme.of(context).canvasColor,
                    child: Row(
                      children: [
                        Text(
                          'Page ${pageIndex + 1}/${noteList?.length ?? 0}',
                          style: poppinsRegular.copyWith(
                            fontSize: Dimensions.fontSize10,
                            color: Theme.of(context).cardColor,
                          ),
                        ),

                      ],
                    ),
                  ),
                  isListEmpty && !noteControl.isCategoryNoteLoading
                      ? Padding(
                    padding: const EdgeInsets.only(
                        top: Dimensions.paddingSize100),
                    child: Center(
                        child: EmptyDataWidget(
                          text: 'No Notes Yet',
                          image: Images.emptyDataBlackImage,
                          fontColor: Theme.of(context).disabledColor,
                        )),
                  )
                      : Expanded(
                    child: LoopPageView.builder(
                      controller: _loopPageController,
                      itemCount: noteList?.length ?? 0,
                      onPageChanged: (index) =>
                          noteControl.updateIndex(index),
                      itemBuilder: (context, i) {
                        return GetBuilder<BookmarkController>(
                            builder: (bookmarkControl) {
                              bool isBookmarked = bookmarkControl
                                  .bookmarkNoteIdList
                                  .contains(noteList![i].id);
                              return NotesViewComponent(
                                title: noteList[i].title.toString(),
                                question: noteList[i].content.toString(),
                                saveNote: () {
                                  isBookmarked
                                      ? bookmarkControl
                                      .removeNoteBookMarkList(int.parse(
                                      noteList[i].id.toString()))
                                      : bookmarkControl.addNoteBookMarkList(
                                      '', noteList[i]);
                                },
                                saveNoteColor: isBookmarked
                                    ? Theme.of(context).cardColor
                                    : Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.60),
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
              if (noteControl.isCategoryNoteLoading)
                const Center(child: LoaderWidget()),
            ],
          ),
        ),
      );
    });
  }


}

