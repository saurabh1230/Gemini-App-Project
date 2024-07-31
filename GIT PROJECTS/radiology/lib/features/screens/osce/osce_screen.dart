import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiology/controllers/bookmark_controller.dart';
import 'package:radiology/controllers/spotters_controller.dart';
import 'package:radiology/data/repo/spotters_repo.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:radiology/features/widgets/custom_loading_widget.dart';
import 'package:radiology/features/widgets/custom_network_image_widget.dart';
import 'package:radiology/utils/app_constants.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
import 'package:loop_page_view/loop_page_view.dart';

import '../../widgets/bookmart_button.dart';
import 'osce_content_component/osce_component_widget.dart';


class OsceScreen extends StatelessWidget {
  OsceScreen({super.key});

  final ScrollController scrollController = ScrollController();
  final SpottersRepo spottersRp = Get.put(SpottersRepo(apiClient: Get.find()));

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SpottersController>().getOscePaginatedList('1');
    });
    Get.find<SpottersController>().setOffset(1);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent &&
          Get.find<SpottersController>().osceList != null &&
          !Get.find<SpottersController>().isOsceLoading) {
        if (Get.find<SpottersController>().offset < 10) {
          print(
              "print ===========> offset before ${Get.find<SpottersController>().offset}");
          Get.find<SpottersController>()
              .setOffset(Get.find<SpottersController>().offset + 1);
          Get.find<SpottersController>().showBottomLoader();
          Get.find<SpottersController>().getOscePaginatedList(
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
        title: "OSCE",
        isBackButtonExist: true,
        backGroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          GetBuilder<SpottersController>(builder: (spottersControl) {
            final list = spottersControl.osceList;
            final isListEmpty = list == null || list.isEmpty;
            return isListEmpty
                ? const Center(child: LoaderWidget())
                : LoopPageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, i) {
                return GetBuilder<BookmarkController>(
                    builder: (bookmarkControl) {
                      bool isBookmarked = bookmarkControl.osceBookmarkIdList
                          .contains(list[i].id);
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
                      );

                      // return SingleChildScrollView(
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Stack(
                      //         children: [
                      //           InkWell(
                      //             onTap: () {},
                      //             child: Container(
                      //               height: 400,
                      //               clipBehavior: Clip.hardEdge,
                      //               width: Get.size.width,
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(0),
                      //                 color: Theme.of(context).disabledColor,
                      //               ),
                      //               child: CustomNetworkImageWidget(
                      //                 radius: 0,
                      //                 image:
                      //                 '${AppConstants.osceImageUrl}${list[i].image}',
                      //                 fit: BoxFit.fitWidth,
                      //               ),
                      //             ),
                      //           ),
                      //           Positioned(top: 0,right: Dimensions.paddingSizeDefault,
                      //               child: BookMarkButton(tap: () {
                      //                 isBookmarked ?
                      //                 bookmarkControl.removeOsceBookmark(list[i].id) :
                      //                 bookmarkControl.addOsceBookmark('',list[i]);
                      //               }, color: isBookmarked
                      //                   ? Theme.of(context).cardColor
                      //                   : Theme.of(context).cardColor.withOpacity(0.60),)
                      //           ),
                      //         ],
                      //       ),
                      //
                      //       // sizedBox10(),
                      //       Padding(
                      //         padding: const EdgeInsets.all(
                      //             Dimensions.paddingSizeDefault),
                      //         child: Column(
                      //           crossAxisAlignment:
                      //           CrossAxisAlignment.start, // Align children to start
                      //           children: [
                      //             // sizedBox10(),
                      //             Text(
                      //               '${list[i].title}',
                      //               style: poppinsBold.copyWith(
                      //                 fontSize: Dimensions.fontSize20,
                      //                 color: Theme.of(context).disabledColor,
                      //               ),
                      //             ),
                      //             sizedBox10(),
                      //             Text(
                      //               "Question : ",
                      //               style: poppinsSemiBold.copyWith(
                      //                 fontSize: Dimensions.fontSizeDefault,
                      //                 color: Theme.of(context).primaryColor,
                      //               ),
                      //             ),
                      //             sizedBox10(),
                      //             ListView.separated(
                      //               physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                      //               shrinkWrap: true, // Let ListView take minimum space
                      //               itemCount: list[i].question?.length ?? 0,
                      //               itemBuilder: (context, j) {
                      //                 return Column(
                      //                   crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       list[i].question![j].question
                      //                           .toString(),
                      //                       style: poppinsRegular.copyWith(
                      //                         fontSize:
                      //                         Dimensions.fontSize14,
                      //                         fontWeight: FontWeight.w100,
                      //                         color: Theme.of(context)
                      //                             .disabledColor,
                      //                       ),
                      //                     )
                      //                   ],
                      //                 );
                      //               }, separatorBuilder: (BuildContext context, int index) => sizedBox10(),
                      //             ),
                      //             sizedBoxDefault(),
                      //             Text(
                      //               "Answers : ",
                      //               style: poppinsSemiBold.copyWith(
                      //                 fontSize: Dimensions.fontSizeDefault,
                      //                 color: Theme.of(context).primaryColor,
                      //               ),
                      //             ),
                      //             sizedBox10(),
                      //             ListView.separated(
                      //               physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                      //               shrinkWrap: true, // Let ListView take minimum space
                      //               itemCount: list[i].question?.length ?? 0,
                      //               itemBuilder: (context, j) {
                      //                 return Column(
                      //                   crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       list[i].question![j].answer
                      //                           .toString(),
                      //                       style: poppinsRegular.copyWith(
                      //                         fontSize:
                      //                         Dimensions.fontSize14,
                      //                         fontWeight: FontWeight.w100,
                      //                         color: Theme.of(context)
                      //                             .disabledColor,
                      //                       ),
                      //                     )
                      //                   ],
                      //                 );
                      //               }, separatorBuilder: (BuildContext context, int index) => sizedBox10(),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // );
                    });
              },
            );
          }),
        ],
      ),
    );
  }
}



