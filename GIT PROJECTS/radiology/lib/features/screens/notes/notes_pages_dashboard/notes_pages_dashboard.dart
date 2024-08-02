import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/notes_controller.dart';
import 'package:radiology/features/screens/auth/widgets/buttons.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:radiology/features/screens/notes/components/notes_view_component.dart';
import 'package:radiology/features/widgets/custom_app_button.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:radiology/features/widgets/empty_data_widget.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
import 'package:loop_page_view/loop_page_view.dart';

class NotesDashboard extends StatelessWidget {
  final String? categoryId;
  final String? categoryName;

  NotesDashboard({super.key, required this.categoryId, this.categoryName});

  final LoopPageController _loopPageController = LoopPageController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<NotesController>().getNotesPaginatedList("1", categoryId!);
      Get.find<NotesController>().currentPageIndex.value = 0; // Set initial page index
    });
    Get.find<NotesController>().setOffset(1);

    _loopPageController.addListener(() {
      final NotesController controller = Get.find<NotesController>();
      final pageIndex = _loopPageController.page.round();
      controller.currentPageIndex.value = pageIndex; // Update the page index

      // Scroll the ListView to the current page index
      _scrollController.animateTo(
        pageIndex * 50.0, // Adjust the value if the height of each item changes
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      if (pageIndex == controller.categoryNoteList!.length - 1 &&
          !controller.isCategoryNoteLoading) {
        if (controller.offset < 20) {
          // Adjust your max page limit
          controller.setOffset(controller.offset + 1);
          controller.showBottomLoader();
          controller.getNotesPaginatedList(
            controller.offset.toString(),
            categoryId!,
          );
        }
      }
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
            height: 70, // Adjust height as needed
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                final pageIndex =
                    Get.find<NotesController>().currentPageIndex.value;
                return Row(
                  children: [
                    Flexible(
                      child: ListView.builder(
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
                      ),
                    ),
                    sizedBoxW15(),
                    CustomButtonWidget(
                      width: 100,
                      height: Dimensions.paddingSize40,
                      buttonText: 'Next',
                      isBold: false,
                      onPressed: () {
                        // Get the current page index
                        final currentPageIndex = _loopPageController.page.round();
                        _loopPageController.animateToPage(
                          currentPageIndex + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },

                      suffixIconPath: Images.icDoubleArrowRight,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
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
                    // color: Theme.of(context).hintColor.withOpacity(0.60),
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












// bottomNavigationBar: isListEmpty ||
//         noteControl.currentIndex == (noteList.length ?? 0) - 1
//     ? const SizedBox.shrink()
//     : SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(Dimensions.paddingSize10),
//           color: Theme.of(context).canvasColor,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   noteList.length,
//                   (index) {
//                     return Container(
//                       margin: const EdgeInsets.all(2),
//                       width:
//                           noteControl.currentIndex == index ? 15 : 6,
//                       height: 6,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(
//                           noteControl.currentIndex == index
//                               ? Dimensions.paddingSize5
//                               : Dimensions.paddingSizeDefault,
//                         ),
//                         color: noteControl.currentIndex == index
//                             ? Colors.blue
//                             : Colors.grey,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Row(
//                 children: [
//                   CustomRoundButton(
//                     tap: noteControl.previousPage,
//                     child: Image.asset(
//                       Images.icDoubleArrowBack,
//                       height: Dimensions.fontSize10,
//                     ),
//                   ),
//                   sizedBoxW10(),
//                   CustomButtonWidget(
//                     width: 100,
//                     height: Dimensions.paddingSize40,
//                     buttonText: 'Next',
//                     isBold: false,
//                     onPressed: noteControl.nextPage,
//                     suffixIconPath: Images.icDoubleArrowRight,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),