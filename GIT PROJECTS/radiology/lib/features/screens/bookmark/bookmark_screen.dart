import 'package:flutter/material.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/spotters_controller.dart';
import 'package:radiology/data/repo/spotters_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:radiology/features/screens/spotters/components/spotters_content_section.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:radiology/features/widgets/empty_data_widget.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/styles.dart';
import 'package:loop_page_view/loop_page_view.dart';

class BookmarkScreen extends StatelessWidget {
  BookmarkScreen({super.key});
  final SpottersRepo noteRepo = Get.put(SpottersRepo(apiClient: Get.find()));
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<BookmarkController>().getSavedSpottersPaginatedList('1');
    });
    Get.find<SpottersController>().setOffset(1);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          Get.find<BookmarkController>().savedSpottersList != null &&
          !Get.find<BookmarkController>().isSavedSpottersLoading) {
        if (Get.find<BookmarkController>().offset < 10) {
          print(
              "print ===========> offset before ${Get.find<BookmarkController>().offset}");
          Get.find<BookmarkController>()
              .setOffset(Get.find<BookmarkController>().offset + 1);
          Get.find<BookmarkController>().showSavedBottomLoader();
          Get.find<BookmarkController>().getSavedSpottersPaginatedList(
            Get.find<BookmarkController>().offset.toString(),
          );
        }
      }
    });

    return GetBuilder<BookmarkController>(builder: (spottersControl) {
      final spottersList = spottersControl.savedSpottersList;
      final isListEmpty = spottersList == null || spottersList.isEmpty;
      return  Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          // bottomNavigationBar: SingleChildScrollView(
          //   child: Padding(
          //     padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          //     child: Column(
          //       children: [
          //         isListEmpty && !spottersControl.isSavedSpottersLoading
          //             ? const SizedBox() :
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               'Slide Right for next ',
          //               style: poppinsRegular.copyWith(
          //                 fontSize: Dimensions.fontSize14,
          //                 color: Theme.of(context).primaryColor,
          //               ),
          //             ),
          //             Image.asset(
          //               Images.icdoubleArrowRight,
          //               height: 18,
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          appBar: const CustomAppBar(
            title: "Saved Spotters",
            isBackButtonExist: true,
            backGroundColor: Colors.black,
          ),
          body: Stack(
            children: [
              isListEmpty && !spottersControl.isSavedSpottersLoading
                  ?   Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSize100),
                child: Center(child: EmptyDataWidget(image: Images.emptyDataBlackImage,
                  fontColor:  Theme.of(context).disabledColor, text: 'No Saved Spotter Yet',)),
              )
                  :
              // isListEmpty
              //   ? const Center(child: LoaderWidget()) :
              PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: spottersList!.length,
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
                                  '${AppConstants.spottersImageUrl}${spottersList[index].image}')
                                  .image,
                              swipeDismissible: true,
                              doubleTapZoomable: true,
                            );
                          },
                          spotterImg: spottersList[index].image.toString(),
                          categoryTitle: spottersList[index].title.toString(),
                          categoryContent:
                          spottersList[index].content.toString(),
                          onBookMarkTap: () {
                            bookmarkControl.removeFromBookMarkList(spottersList[index].id);
                            // Get.find<BookmarkController>().getSavedSpottersPaginatedList('1');

                          },
                          bookmarkIconColor: /*isBookmarked
                              ? */Theme.of(context).cardColor
                             /* : Theme.of(context).cardColor.withOpacity(0.60),*/
                        );
                      });
                },
              ),
              if (spottersControl.isSavedSpottersLoading)
                const Center(child: LoaderWidget()),
            ],
          ),

      );
    });




  }
}
