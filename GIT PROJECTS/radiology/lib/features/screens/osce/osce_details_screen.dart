import 'package:flutter/material.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/spotters_controller.dart';
import 'package:radiology/data/repo/spotters_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';
import '../../../utils/styles.dart';
import 'osce_content_component/osce_component_widget.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

class OsceDetailsScreen extends StatelessWidget {
  final String? categoryId;
  final String? categoryName;
  OsceDetailsScreen({super.key, this.categoryId, this.categoryName});

  final PageController _pageController = PageController(initialPage: 0);
  final SpottersRepo spottersRp = Get.put(SpottersRepo(apiClient: Get.find()));
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('check');
      Get.find<SpottersController>().getOsceDetailsApi(categoryId);
    });

    return GetBuilder<SpottersController>(builder: (spottersControl) {
      final list = spottersControl.osceDetails;
      final isListEmpty = list == null;
      final isLoading = spottersControl.isOsceDetailsLoading; // Get loading state
      return SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: const CustomAppBar(
            title: "OSCE",
            isBackButtonExist: true,
            backGroundColor: Colors.black,
            // menuWidget: Row(
            //   children: [
            //     TextButton(onPressed: () {}, child: Text('Report',style: poppinsSemiBold.copyWith(
            //         fontSize: Dimensions.fontSize14,
            //         color: Theme.of(context).cardColor),)),
            //   ],
            // ),
          ),
          body: Stack(
            children: [
              if (isListEmpty) const Center(child: LoaderWidget()),
              GetBuilder<BookmarkController>(builder: (bookmarkControl) {
                bool isBookmarked =
                    bookmarkControl.osceBookmarkIdList.contains(list!.id);
                return OsceComponentWidget(
                  imageUrl: '${AppConstants.osceImageUrl}${list.image}',
                  title: '${list.title}',
                  bookmarkColor: isBookmarked
                      ? Theme.of(context).cardColor
                      : Theme.of(context).cardColor.withOpacity(0.60),
                  onBookmarkTap: () {
                    isBookmarked
                        ? bookmarkControl.removeOsceBookmark(list.id)
                        : bookmarkControl.addOsceBookmark('', list);
                  },
                  questionCount: list.question?.length ?? 0,
                  questions: list
                      .question!
                      .map((q) => q.question.toString())
                      .toList(),
                  answers: list
                      .question!
                      .map((q) => q.answer.toString())
                      .toList(),
                  imgClick: () {
                    showImageViewer(
                      context,
                      Image.network(
                        '${AppConstants.osceImageUrl}${list.image}',
                      ).image,
                      swipeDismissible: true,
                      doubleTapZoomable: true,
                    );
                  },
                  isNotBookmark: true,
                );
              }),
              if (isLoading) const LoaderWidget(),
            ],
          ),
        ),
      );
    });
  }
}
