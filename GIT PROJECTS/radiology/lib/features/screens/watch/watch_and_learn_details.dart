import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/watch_controller.dart';
import 'package:radiology/data/repo/watch_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/features/screens/notes/components/notes_view_component.dart';
import 'package:radiology/features/screens/watch/watch_learn_component.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:radiology/features/widgets/empty_data_widget.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/styles.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class WatchAndLearnDetailsScreen extends StatelessWidget {
  final String? categoryId;
  final String? categoryName;

  WatchAndLearnDetailsScreen({super.key, required this.categoryId, this.categoryName});
  final WatchRepo watchRp = Get.put(WatchRepo(apiClient: Get.find()));
  final WatchController watchController = Get.put(WatchController(watchRepo: Get.find()));

  final LoopPageController _loopPageController = LoopPageController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      watchController.getWatchAndLearnDetailsApi(categoryId);

    });

    return GetBuilder<WatchController>(builder: (watchControl) {
      final data = watchControl.watchAndLearnDetails;
      final isListEmpty = data == null ;
      final isLoading = watchControl.isWatchAndLearnDetailsLoading;

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
            title: categoryName ?? 'Watch And Learn',
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

                      ],
                    ),
                  ),
                  isListEmpty && !isLoading
                      ? Padding(
                    padding: const EdgeInsets.only(top: Dimensions.paddingSize100),
                    child: Center(
                      child: EmptyDataWidget(
                        text: 'No Notes Yet',
                        image: Images.emptyDataBlackImage,
                        fontColor: Theme.of(context).disabledColor,
                      ),
                    ),
                  )
                      : Expanded(
                    child: GetBuilder<BookmarkController>(builder: (bookmarkControl) {
                      bool isBookmarked = bookmarkControl.bookmarkWatchIdList.contains(data!.id);
                      return WatchLearnComponent(
                        title: data.title.toString(),
                        videoUrl: data.videoUrl.toString(),
                        saveNote: () {
                          isBookmarked
                              ? bookmarkControl.removeWatchBookMarkList(int.parse(data.id.toString()))
                              : bookmarkControl.addWatchBookMarkList('', data);
                        },
                        saveNoteColor: isBookmarked
                            ? Theme.of(context).cardColor
                            : Theme.of(context).cardColor.withOpacity(0.60),
                        isNotBookmark: true,
                      );
                    }),
                  ),
                ],
              ),
              if (isLoading) const Center(child: LoaderWidget()),
            ],
          ),
        ),
      );
    });
  }


}
