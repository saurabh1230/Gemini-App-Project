import 'package:flutter/material.dart';
import 'package:iclinix/app/screens/appointment/components/booking_summary_widget.dart';
import 'package:iclinix/app/widget/common_widgets.dart';
import 'package:iclinix/app/widget/custom_app_bar.dart';
import 'package:iclinix/app/widget/custom_button_widget.dart';
import 'package:iclinix/app/widget/custom_textfield.dart';
import 'package:iclinix/controller/auth_controller.dart';
import 'package:iclinix/helper/route_helper.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:get/get.dart';
class PaymentScreen extends StatelessWidget {
   PaymentScreen({super.key});
  final _referralController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Payment Method',
          menuWidget: Row(
            children: [
              NotificationButton(
                tap: () {},
              ),
            ],
          )),
      body: GetBuilder<AuthController>(builder: (appointmentControl) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Referral Code (Optional)',style: openSansRegular.copyWith(color: Theme.of(context).hintColor,
                    fontSize: Dimensions.fontSize14),),
                sizedBox5(),
                CustomTextField(
                  controller: _referralController,
                  hintText: 'Apply Referral Code',
                ),
                sizedBoxDefault(),
                BookingSummaryWidget(),
                // sizedBoxDefault(),
                // Text('PAY NOW',style: openSansRegular.copyWith(color: Theme.of(context).hintColor,
                //     fontSize: Dimensions.fontSize14),),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SingleChildScrollView(
          child: CustomButtonWidget(buttonText: 'Make Payment',
          onPressed: () {
            Get.toNamed(RouteHelper.getBookingSuccessfulRoute());
          },
          fontSize: Dimensions.fontSize14,
          isBold: false,),
        ),
      ),




    );
  }
}
