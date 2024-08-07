import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/spotters_controller.dart';
import 'package:radiology/data/repo/spotters_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/features/screens/spotters/components/spotters_content_section.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';

class SpottersScreen extends StatelessWidget {
  SpottersScreen({super.key});

  final LoopPageController _loopPageController =
      LoopPageController(initialPage: 0);
  final SpottersRepo spottersRp = Get.put(SpottersRepo(apiClient: Get.find()));
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final spottersController = Get.find<SpottersController>();
      spottersController.getSpottersPaginatedList('1');
      spottersController.currentPageIndex.value = 0; // Reset to first page
    });

    Get.find<SpottersController>().setOffset(1);

    _loopPageController.addListener(() {
      final SpottersController spottersController =
          Get.find<SpottersController>();
      final pageIndex = _loopPageController.page.round();
      spottersController.currentPageIndex.value =
          pageIndex; // Update the page index

      _scrollController.animateTo(
        pageIndex * 50.0, // Adjust the value if the height of each item changes
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      if (pageIndex == spottersController.spottersList!.length - 1 &&
          !spottersController.isSpottersLoading) {
        if (spottersController.offset < 20) {
          // Adjust your max page limit
          spottersController.setOffset(spottersController.offset + 1);
          spottersController.showBottomLoader();
          spottersController.getSpottersPaginatedList(
            spottersController.offset.toString(),
          );
        }
      }
    });

    return GetBuilder<SpottersController>(builder: (spottersControl) {
      final spottersList = spottersControl.spottersList;
      final isListEmpty = spottersList == null || spottersList.isEmpty;
      final isLoading = spottersControl.isSpottersLoading;
      return SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: const CustomAppBar(
            title: "Spotters",
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
                          Get.find<SpottersController>().currentPageIndex.value;
                      return ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: spottersList.length,
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
              if (isListEmpty)
                const Center(child: LoaderWidget())
              else
                LoopPageView.builder(
                  controller: _loopPageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: spottersList.length,
                  itemBuilder: (context, index) {
                    return GetBuilder<BookmarkController>(
                      builder: (bookmarkControl) {
                        bool isBookmarked = bookmarkControl.bookmarkIdList
                            .contains(spottersList[index].id);
                        return SpotterContentWidget(
                          onTap: () {
                            showImageViewer(
                              context,
                              Image.network(
                                '${AppConstants.spottersImageUrl}${spottersList[index].image}',
                              ).image,
                              swipeDismissible: true,
                              doubleTapZoomable: true,
                            );
                          },
                          spotterImg: spottersList[index].image.toString(),
                          categoryTitle: spottersList[index].title.toString(),
                          categoryContent:
                              spottersList[index].content.toString(),
                          onBookMarkTap: () {
                            isBookmarked
                                ? bookmarkControl.removeFromBookMarkList(
                                    spottersList[index].id)
                                : bookmarkControl.addToSpotterList(
                                    '', spottersList[index]);
                          },
                          bookmarkIconColor: isBookmarked ||
                                  spottersList[index].bookmarkStatus == 1
                              ? Theme.of(context).cardColor
                              : Theme.of(context).cardColor.withOpacity(0.60),
                        );
                      },
                    );
                  },
                ),
              if (isLoading) const LoaderWidget(),
            ],
          ),
        ),
      );
    });
  }
}
