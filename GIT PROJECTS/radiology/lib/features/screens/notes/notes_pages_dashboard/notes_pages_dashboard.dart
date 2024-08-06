import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/notes_controller.dart';
import 'package:radiology/data/repo/note_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/features/screens/notes/components/notes_view_component.dart';
import 'package:radiology/features/widgets/custom_app_button.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:radiology/features/widgets/empty_data_widget.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesDashboard extends StatelessWidget {
  final String? categoryId;
  final String? categoryName;

  NotesDashboard({super.key, required this.categoryId, this.categoryName});
  final NotesController notesController = Get.put(NotesController(noteRepo: Get.find()));
  final NoteRepo notesRp = Get.put(NoteRepo(apiClient: Get.find()));
  final LoopPageController _loopPageController = LoopPageController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final lastPageIndex = await _getLastPageIndex();
      Get.find<NotesController>().getNotesPaginatedList("1", categoryId!);
      Get.find<NotesController>().currentPageIndex.value = lastPageIndex; // Set initial page index
      _loopPageController.jumpToPage(lastPageIndex); // Restore last page index
    });

    Get.find<NotesController>().setOffset(1);

    // Add listener after the `ListView` is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loopPageController.addListener(() async {
        final NotesController controller = Get.find<NotesController>();
        final pageIndex = _loopPageController.page.round();
        controller.currentPageIndex.value = pageIndex; // Update the page index

        // Save the last viewed page index
        await _saveLastPageIndex(pageIndex);

        // Send the note value to the API
        if (controller.categoryNoteList != null && pageIndex < controller.categoryNoteList!.length) {
          final noteValue = Get.find<NotesController>().currentPageIndex.value + 1;
          controller.readNoteStatusApi('${noteValue}', categoryId.toString());
        }

        // Scroll the ListView to the current page index
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            pageIndex * 50.0, // Adjust the value if the height of each item changes
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }

        if (pageIndex == controller.categoryNoteList!.length - 1 &&
            !controller.isCategoryNoteLoading) {
          if (controller.offset < 20) {
            controller.setOffset(controller.offset + 1);
            controller.showBottomLoader();
            controller.getNotesPaginatedList(
              controller.offset.toString(),
              categoryId!,
            );
          }
        }
      });
    });

    return GetBuilder<NotesController>(builder: (noteControl) {
      final noteList = noteControl.categoryNoteList;
      final isListEmpty = noteList == null || noteList.isEmpty;
      final pageIndex = noteControl.currentPageIndex.value;

      return SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: CustomAppBar(
            title: categoryName ?? 'Notes',
            isBackButtonExist: true,
            backGroundColor: Colors.black,
          ),
          bottomNavigationBar: isListEmpty
              ? const SizedBox()
              : Container(
            color: Theme.of(context).canvasColor,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                final pageIndex = Get.find<NotesController>().currentPageIndex.value;
                return ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: noteList.length,
                  itemBuilder: (context, index) {
                    final isCurrentPage = index == pageIndex;
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSize10),
                        child: GestureDetector(
                          onTap: () =>
                              _loopPageController.jumpToPage(index),
                          child: Container(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeDefault),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.paddingSizeDefault),
                              color: isCurrentPage
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).canvasColor,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}', // Page count (1-based index)
                                style: TextStyle(
                                  fontSize:
                                  12.0, // Adjust font size as needed
                                  color: isCurrentPage
                                      ? Theme.of(context).cardColor
                                      : Theme.of(context).cardColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
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

  Future<void> _saveLastPageIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastPageIndex_$categoryId', index);
  }

  Future<int> _getLastPageIndex() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('lastPageIndex_$categoryId') ?? 0;
  }
}

