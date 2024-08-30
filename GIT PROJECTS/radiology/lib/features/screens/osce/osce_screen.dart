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

class OsceScreen extends StatelessWidget {
  OsceScreen({super.key});

  final PageController _pageController = PageController(initialPage: 0);
  final SpottersRepo spottersRp = Get.put(SpottersRepo(apiClient: Get.find()));
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final spottersController = Get.find<SpottersController>();
      spottersController.getOscePaginatedList('1');
      spottersController.currentPageIndex.value = 0; // Reset to first page
    });

    Get.find<SpottersController>().setOffset(1);

    _pageController.addListener(() {
      final SpottersController spottersController = Get.find<SpottersController>();
      final pageIndex = _pageController.page?.round() ?? 0;
      spottersController.currentPageIndex.value = pageIndex;

      _scrollController.animateTo(
        pageIndex * 50.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      if (pageIndex == spottersController.osceList!.length - 1 &&
          !spottersController.isOsceLoading) {
        if (spottersController.offset < 10) { // Adjust your max page limit
          spottersController.setOffset(spottersController.offset + 1);
          spottersController.showBottomLoader();
          spottersController.getOscePaginatedList(
            spottersController.offset.toString(),
          );
        }
      }
    });

    return GetBuilder<SpottersController>(builder: (spottersControl) {
      final list = spottersControl.osceList;
      final isListEmpty = list == null || list.isEmpty;
      final isLoading = spottersControl.isOsceLoading; // Get loading state
      return SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar:  CustomAppBar(
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
          bottomNavigationBar: isListEmpty
              ? const SizedBox()
              : Container(
            color: Theme.of(context).canvasColor,
            height: 70, // Adjust height as needed
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                final pageIndex = Get.find<SpottersController>().currentPageIndex.value;
                return ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final isCurrentPage = index == pageIndex;
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize10),
                        child: GestureDetector(
                          onTap: () => _pageController.jumpToPage(index),
                          child: Container(
                            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                              color: isCurrentPage
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).canvasColor,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}', // Page count (1-based index)
                                style: TextStyle(
                                  fontSize: 12.0, // Adjust font size as needed
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
              if (isListEmpty)
                const Center(child: LoaderWidget()),
              GestureDetector(
                onHorizontalDragUpdate: (details) {
                  final SpottersController spottersController = Get.find<SpottersController>();
                  final pageIndex = spottersController.currentPageIndex.value;

                  if (details.primaryDelta! < 0) {
                    // Swiping left
                    if (pageIndex == 0) {
                      // Prevent swipe if at the first page
                      _pageController.jumpToPage(0);
                    }
                  }
                },
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: list!.length,
                  itemBuilder: (context, i) {
                    return GetBuilder<BookmarkController>(
                        builder: (bookmarkControl) {
                          bool isBookmarked = bookmarkControl.osceBookmarkIdList.contains(list[i].id);
                          return OsceComponentWidget(
                            imageUrl: '${AppConstants.osceImageUrl}${list[i].image}',
                            title: '${list[i].title}',
                            bookmarkColor: isBookmarked
                                ? Theme.of(context).cardColor
                                : Theme.of(context).cardColor.withOpacity(0.60),
                            onBookmarkTap: () {
                              isBookmarked
                                  ? bookmarkControl.removeOsceBookmark(list[i].id)
                                  : bookmarkControl.addOsceBookmark('', list[i]);
                            },
                            questionCount: list[i].question?.length ?? 0,
                            questions: list[i].question!.map((q) => q.question.toString()).toList(),
                            answers: list[i].question!.map((q) => q.answer.toString()).toList(),
                            imgClick: () {
                              showImageViewer(
                                context,
                                Image.network(
                                  '${AppConstants.osceImageUrl}${list[i].image}',
                                ).image,
                                swipeDismissible: true,
                                doubleTapZoomable: true,
                              );
                            },
                          );
                        });
                  },
                ),
              ),
              if (isLoading) const LoaderWidget(),
            ],
          ),
        ),
      );
    });
  }
}
