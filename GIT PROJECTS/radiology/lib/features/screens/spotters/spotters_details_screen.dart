import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/spotters_controller.dart';
import 'package:radiology/data/repo/spotters_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/styles.dart';
import '../../../utils/images.dart';
import 'components/spotters_content_section.dart';

class SpottersDetailsScreen extends StatelessWidget {
  final String? spottersId;
  final String? title;
  SpottersDetailsScreen({super.key, this.spottersId, this.title});

  final SpottersRepo spottersRp = Get.put(SpottersRepo(apiClient: Get.find()));

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SpottersController>().getSpottersDetailsApi(spottersId);

    });

    return GetBuilder<SpottersController>(builder: (spottersControl) {
      final data = spottersControl.spottersDetails;
      final isListEmpty = data == null ;
      final isLoading = spottersControl.isSpottersDetailsLoading;
      return SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar:  CustomAppBar(
            title: title ?? 'Spotter',
            isBackButtonExist: true,
            backGroundColor: Colors.black,
            // menuWidget: Row(
            //   children: [
            //     TextButton(onPressed: () {}, child: Text('Report',style: poppinsSemiBold.copyWith(
            //       fontSize: Dimensions.fontSize14,
            //         color: Theme.of(context).cardColor),)),
            //
            //     // TextButton(onPressed: () {}, child: Image.asset(
            //     //   Images.icShare,color: Theme.of(context).cardColor,height: Dimensions.fontSize24,
            //     // ))
            //   ],
            // ),
          ),
          body: Stack(
            children: [
              if (isListEmpty)
                const Center(child: LoaderWidget())
              else
                GetBuilder<BookmarkController>(
                  builder: (bookmarkControl) {
                    bool isBookmarked = bookmarkControl.bookmarkIdList
                        .contains(data.id);
                    return SpotterContentWidget(
                      onTap: () {
                        showImageViewer(
                          context,
                          Image.network(
                            '${AppConstants.spottersImageUrl}${data.image}',
                          ).image,
                          swipeDismissible: true,
                          doubleTapZoomable: true,
                        );
                      },
                      spotterImg: data.image.toString(),
                      categoryTitle: data.title.toString(),
                      categoryContent: data.content.toString(),
                      onBookMarkTap: () {
                        isBookmarked
                            ? bookmarkControl
                                .removeFromBookMarkList(data.id)
                            : bookmarkControl.addToSpotterList(
                                '', data);
                      },
                      bookmarkIconColor: isBookmarked
                          ? Theme.of(context).cardColor
                          : Theme.of(context).cardColor.withOpacity(0.60),
                      isNotBookmark: true,
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
