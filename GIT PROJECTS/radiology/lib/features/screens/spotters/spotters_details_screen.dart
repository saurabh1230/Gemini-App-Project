import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/controllers/spotters_controller.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/features/screens/spotters/components/spotters_content_section.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

import '../../widgets/custom_network_image_widget.dart';
class SpottersDetailsScreen extends StatelessWidget {
  final String? spottersId;
  final String? title;

  SpottersDetailsScreen({super.key, required this.spottersId, this.title});
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SpottersController>().getSpottersDetailsApi(spottersId);
    });
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: CustomAppBar(
        title: title,
        isBackButtonExist: true,
        backGroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<SpottersController>(builder: (spottersControl) {
          final spottersDetails = spottersControl.spottersDetails;
          final isDetailsLoading = spottersControl.isSpottersDetailsLoading;
          return SizedBox(
            // height: Get.size.height,
            child: Stack(
              children: [
                if (spottersDetails != null && !isDetailsLoading)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                              showImageViewer(
                                  context, Image.network('${AppConstants.spottersImageUrl}${spottersDetails.image}').image,
                                  swipeDismissible: true,
                                  doubleTapZoomable: true);
                        },
                        child: Container(
                          height: 200,
                          clipBehavior: Clip.hardEdge,
                          width: Get.size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius5),
                          ),
                          child: CustomNetworkImageWidget(
                            image: '${AppConstants.spottersImageUrl}${spottersDetails.image}',
                          ),
                        ),
                      ),
                      sizedBoxDefault(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${spottersDetails.title.toString()} : ",
                              style: poppinsBold.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                            Text(
                              removePTags(spottersDetails.content.toString()),
                              style: poppinsRegular.copyWith(
                                fontSize: Dimensions.fontSize12,
                                fontWeight: FontWeight.w100,

                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                            Divider(color: Theme.of(context).disabledColor.withOpacity(0.50),)
                          ],
                        ),
                      ),
                      sizedBox10(),
                    ],
                  ),
                  // SpotterContentWidget(
                  //   onTap: () {
                  //     showImageViewer(
                  //               context, Image.network('${AppConstants.spottersImageUrl}${spottersDetails.image}').image,
                  //               swipeDismissible: true,
                  //               doubleTapZoomable: true);
                  //
                  //   },
                  //   spotterImg: spottersDetails.image.toString(),
                  //   categoryTitle: spottersDetails.title.toString(),
                  //   categoryContent: spottersDetails.content.toString(),
                  //   isDetails: true,
                  // ),
                if (isDetailsLoading || spottersDetails == null)
                  const Center(child: LoaderWidget()),
              ],
            ),
          );
        }),
      ),
    );
  }
  String removePTags(String htmlString) {
    var document = htmlParser.parse(htmlString);
    return document.body!.text;
  }
}
