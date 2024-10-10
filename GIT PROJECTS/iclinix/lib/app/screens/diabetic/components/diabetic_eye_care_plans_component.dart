import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_button_widget.dart';
import 'package:iclinix/app/widget/custom_containers.dart';
import 'package:iclinix/app/widget/empty_data_widget.dart';
import 'package:iclinix/controller/appointment_controller.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:get/get.dart';

import '../plans_details_screen.dart';

class DiabeticEyeCarePlansComponent extends StatelessWidget {
  const DiabeticEyeCarePlansComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(builder: (appointmentControl) {
      final dataList = appointmentControl.planList;
      final isListEmpty = dataList == null || dataList.isEmpty;
      final isLoading = appointmentControl.isPlansLoading;
      return isListEmpty && !isLoading
          ? Padding(
              padding: const EdgeInsets.only(top: Dimensions.paddingSize100),
              child: Center(
                  child: EmptyDataWidget(
                text: 'No Plans Available',
                image: Images.icEmptyDataHolder,
                fontColor: Theme.of(context).disabledColor,
              )),
            )
          : isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diabetic Eye Care Plans',
                      style: openSansBold.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                    ),
                    sizedBox10(),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dataList!.length,
                      shrinkWrap: true,
                      itemBuilder: (_, j) {
                        return CustomDecoratedContainer(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomDecoratedContainer(
                              color: Theme.of(context).primaryColor,
                              verticalPadding: Dimensions.paddingSize5,
                              child: Text(
                                dataList[j].planName,
                                style: openSansSemiBold.copyWith(
                                    fontSize: Dimensions.fontSize14,
                                    color: Theme.of(context).cardColor),
                              ),
                            ),
                            sizedBox10(),
                            Text(
                              "Whats's Included In Your Plan",
                              style: openSansSemiBold.copyWith(
                                  fontSize: Dimensions.fontSize14,
                                  color: Theme.of(context).disabledColor),
                            ),
                            ListView.builder(
                                itemCount: dataList[j].features.length,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemBuilder: (_, i) {
                                  return Text(
                                    dataList[j].features[i].featureName,
                                    style: openSansRegular.copyWith(
                                        fontSize: Dimensions.fontSize14,
                                        color: Theme.of(context).primaryColor),
                                  );
                                }),
                            sizedBoxDefault(),
                            CustomButtonWidget(
                              height: Dimensions.fontSize40,
                              buttonText: 'Know More',
                              isBold: false,
                              transparent: true,
                              onPressed: () {
                                Get.to(PlansDetailsScreen(planModel: dataList[j]));
                              },
                            ),
                          ],
                        ));
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          sizedBoxDefault(),
                    )
                  ],
                );
    });
  }
}
