import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/features/widgets/bookmart_button.dart';
import 'package:radiology/features/widgets/custom_network_image_widget.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
import 'package:radiology/utils/themes/light_theme.dart';

class OsceComponentWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int questionCount;
  final List<String> questions; // List of questions
  final List<String> answers; // List of answers
  final Color bookmarkColor;
  final VoidCallback onBookmarkTap;
  final VoidCallback imgClick;

  const OsceComponentWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.bookmarkColor,
    required this.onBookmarkTap,
    required this.questionCount,
    required this.questions,
    required this.answers, required this.imgClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: imgClick,
                    child: Container(
                      height: 400,
                      clipBehavior: Clip.hardEdge,
                      width: Get.size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Theme.of(context).disabledColor,
                      ),
                      child: CustomNetworkImageWidget(
                        radius: 0,
                        image: imageUrl,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: Dimensions.paddingSizeDefault,
                    child: BookMarkButton(
                      tap: onBookmarkTap,
                      color: bookmarkColor,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: poppinsBold.copyWith(
                        fontSize: Dimensions.fontSize20,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    sizedBox10(),
                    Container(
                      padding: const EdgeInsets.all(Dimensions.radius10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5,color: Theme.of(context).disabledColor.withOpacity(0.60)),
                          borderRadius: BorderRadius.circular(Dimensions.radius15)
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Questions: ",
                            style: poppinsSemiBold.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          sizedBox10(),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: questionCount,
                            itemBuilder: (context, index) {
                              return Text(
                                questions[index],
                                style: poppinsRegular.copyWith(
                                  fontSize: Dimensions.fontSize14,
                                  fontWeight: FontWeight.w100,
                                  color: Theme.of(context).disabledColor,
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) =>
                                sizedBox10(),
                          ),
                        ],
                      ),
                    ),
                    sizedBox40(),
                    Container(
                      padding: const EdgeInsets.all(Dimensions.radius10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5,color: Theme.of(context).disabledColor.withOpacity(0.60)),
                          borderRadius: BorderRadius.circular(Dimensions.radius15)
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Answers: ",
                            style: poppinsSemiBold.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: greenColor,
                            ),
                          ),
                          sizedBox10(),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: questionCount,
                            itemBuilder: (context, index) {
                              return Text(
                                answers[index],
                                style: poppinsRegular.copyWith(
                                  fontSize: Dimensions.fontSize14,
                                  fontWeight: FontWeight.w100,
                                  color: Theme.of(context).disabledColor,
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) =>
                                sizedBox10(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],

    );
  }
}
