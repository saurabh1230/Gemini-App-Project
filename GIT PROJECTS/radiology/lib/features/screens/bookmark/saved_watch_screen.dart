import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/spotters_controller.dart';
import 'package:radiology/data/repo/spotters_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:radiology/features/screens/notes/components/notes_view_component.dart';
import 'package:radiology/features/screens/spotters/components/spotters_content_section.dart';
import 'package:radiology/features/screens/watch/watch_learn_component.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:radiology/features/widgets/empty_data_widget.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/styles.dart';
import 'package:share_plus/share_plus.dart';

class SavedWatchScreen extends StatelessWidget {
  SavedWatchScreen({super.key});
  final SpottersRepo noteRepo = Get.put(SpottersRepo(apiClient: Get.find()));
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<BookmarkController>().getSavedWatchPaginatedList('1');
    });
    Get.find<SpottersController>().setOffset(1);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent &&
          Get.find<BookmarkController>().savedWatchList != null &&
          !Get.find<BookmarkController>().isSavedWatchLoading) {
        if (Get.find<BookmarkController>().offset < 10) {
          print(
              "print ===========> offset before ${Get.find<BookmarkController>().offset}");
          Get.find<BookmarkController>()
              .setOffset(Get.find<BookmarkController>().offset + 1);
          Get.find<BookmarkController>().showSavedBottomLoader();
          Get.find<BookmarkController>().getSavedWatchPaginatedList(
            Get.find<BookmarkController>().offset.toString(),
          );
        }
      }
    });

    return GetBuilder<BookmarkController>(builder: (spottersControl) {
      final list = spottersControl.savedWatchList;
      final isListEmpty = list == null || list.isEmpty;
      return
        Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          floatingActionButton: IconButton(
            splashColor: Theme.of(context).cardColor,
            icon: Icon(
              CupertinoIcons.arrowshape_turn_up_right_fill,
              color: Theme.of(context).disabledColor,
            ),
            onPressed: () {
              Share.share(AppConstants.shareContent); // Replace with your content
            },
          ),
          appBar:  const CustomAppBar(
            title: "Saved Watch And Learn",
            isBackButtonExist: true,
            backGroundColor: Colors.black,
          ),
          body:  Stack(
            children: [
              isListEmpty && !spottersControl.isSavedNotesLoading ? Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Center(child: EmptyDataWidget(image: Images.emptyDataBlackImage,
                  fontColor:  Theme.of(context).disabledColor, text: 'Nothing Available',)),
              ) :
              // isListEmpty
              //   ? const Center(child: LoaderWidget()) :
              PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list!.length,
                itemBuilder: (context, i) {
                  return GetBuilder<BookmarkController>(
                      builder: (bookmarkControl) {
                        bool isBookmarked = bookmarkControl.bookmarkWatchIdList
                            .contains(list[i].id);
                        return WatchLearnComponent(
                          title: list[i].title.toString(),
                          videoUrl: list[i].videoUrl.toString(),
                          saveNote: () {
                             bookmarkControl.removeWatchBookMarkList(int.parse(
                                list[i].id.toString()));
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
              if (spottersControl.isSavedWatchLoading)
                const Center(child: LoaderWidget()),
            ],
          ),

        ); });


  }
}
