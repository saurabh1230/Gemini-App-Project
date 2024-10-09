import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_card_container.dart';
import 'package:iclinix/helper/route_helper.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iclinix/utils/themes/light_theme.dart';

class ClinicContentCard extends StatelessWidget {
  const ClinicContentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: 10,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_,i) {
      return CustomCardContainer(
        tap: () {
          Get.toNamed(RouteHelper.getSelectSlotRoute());
        },
        child: Column(
          children: [
            Image.asset(
              'assets/images/img_clinic_demo.png',
              width: Get.size.width,
              height: 120,
              fit: BoxFit.cover,
            ),
            sizedBox4(),
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSize10),
              child: Column(
                children: [
                  Text(
                    'IClinix Advanced Eye And Retina Centre Lajpat Nagar',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: openSansBold.copyWith(fontSize: Dimensions.fontSize14),
                  ),
                  sizedBox4(),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '4.8',
                            style: openSansRegular.copyWith(
                                fontSize: Dimensions.fontSize14,
                                color: Theme.of(context).hintColor),
                          ),
                          RatingBar.builder(
                            itemSize:  Dimensions.fontSize14,
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: Dimensions.fontSize14,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Open: ",
                                style: openSansRegular.copyWith(
                                    fontSize: Dimensions.fontSize12,
                                    color: greenColor), // Different color for "resend"
                              ),
                              TextSpan(
                                text: "10AM-7PM",
                                style: openSansRegular.copyWith(
                                    fontSize: Dimensions.fontSize13,
                                    color: Theme.of(context)
                                        .hintColor), // Different color for "resend"
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }, separatorBuilder: (BuildContext context, int index) => sizedBoxDefault(),);
  }
}
