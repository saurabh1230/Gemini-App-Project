import 'package:flutter/material.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/spotters_controller.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:radiology/features/screens/spotters/components/spotters_content_section.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/styles.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:radiology/utils/themes/light_theme.dart';


class SpottersScreen extends StatelessWidget {
  SpottersScreen({super.key});

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SpottersController>().getSpottersPaginatedList('1');
    });
    Get.find<SpottersController>().setOffset(1);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent &&
          Get.find<SpottersController>().spottersList != null &&
          !Get.find<SpottersController>().isSpottersLoading) {
        if (Get.find<SpottersController>().offset < 10) {
          print(
              "print ===========> offset before ${Get.find<SpottersController>().offset}");
          Get.find<SpottersController>()
              .setOffset(Get.find<SpottersController>().offset + 1);
          Get.find<SpottersController>().showBottomLoader();
          Get.find<SpottersController>().getSpottersPaginatedList(
            Get.find<SpottersController>().offset.toString(),
          );
        }
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      bottomNavigationBar: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            children: [
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
        title: "Spotters",
        isBackButtonExist: true,
        backGroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          GetBuilder<SpottersController>(builder: (spottersControl) {
            final spottersList = spottersControl.spottersList;
            final isListEmpty = spottersList == null || spottersList.isEmpty;



            return isListEmpty
                ? const Center(child: LoaderWidget())
                : LoopPageView.builder(
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
                                '${AppConstants.spottersImageUrl}${spottersList[index].image}')
                                .image,
                            swipeDismissible: true,
                            doubleTapZoomable: true,
                          );
                        },
                        spotterImg: spottersList[index].image.toString(),
                        categoryTitle: spottersList[index].title.toString(),
                        categoryContent: spottersList[index].content.toString(),
                        onBookMarkTap: () {
                          isBookmarked ?
                          bookmarkControl.removeFromBookMarkList(spottersList[index].id) :
                          bookmarkControl.addToSpotterList('',spottersList[index]);
                        },
                        bookmarkIconColor:
                        isBookmarked || spottersList[index].bookmarkStatus == 1
                            ? Theme.of(context).cardColor
                            : Theme.of(context).cardColor.withOpacity(0.60),
                      );
                    });
              },
            );
          }),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:radiology/controllers/spotters_controller.dart';
// import 'package:radiology/features/screens/custom_appbar.dart';
// import 'package:radiology/features/screens/spotters/components/spotters_content_section.dart';
// import 'package:radiology/features/widgets/custom_loading_widget.dart';
//
// class SpottersScreen extends StatelessWidget {
//   SpottersScreen({super.key});
//   final PageController pageController = PageController();
//   final ScrollController scrollController = ScrollController();
//
//   @override
//   Widget build(BuildContext context) {
//     final SpottersController spottersController = Get.find<SpottersController>();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       spottersController.getSpottersPaginatedList('1');
//     });
//
//     spottersController.setOffset(1);
//
//     pageController.addListener(() {
//       if (pageController.page == (spottersController.spottersList?.length ?? 0) - 1 &&
//           !spottersController.isSpottersLoading) {
//         if (spottersController.offset < 10) {  // Adjust the condition based on your pagination needs
//           spottersController.setOffset(spottersController.offset + 1);
//           spottersController.showBottomLoader();
//           spottersController.getSpottersPaginatedList(
//             spottersController.offset.toString(),
//           );
//         }
//       }
//     });
//
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: "Spotters",
//         isBackButtonExist: true,
//         backGroundColor: Colors.black,
//       ),
//       body: GetBuilder<SpottersController>(builder: (spottersControl) {
//         final spottersList = spottersControl.spottersList;
//         final isListEmpty = spottersList == null || spottersList.isEmpty;
//
//         return Stack(
//           children: [
//             if (!isListEmpty)
//               PageView.builder(
//                 scrollDirection: Axis.vertical,
//                 controller: pageController,
//                 itemCount: spottersList!.length,
//                 itemBuilder: (context, index) {
//                   return SpotterContentWidget(
//                     spottersList[index].image.toString(),
//                     spottersList[index].title.toString(),
//                     spottersList[index].content.toString(),
//                   );
//                 },
//               ),
//             if (spottersControl.isSpottersLoading || isListEmpty)
//               const Center(child: LoaderWidget()),
//           ],
//         );
//       }),
//     );
//   }
// }
