import 'package:anuplal/helper/route_helper.dart';
import 'package:get/get.dart';
import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/app/widgets/custom_buttons.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Account',
        menuWidget: Row(
          children: [
            CustomNotificationButton(tap: () {}),
            sizedBoxW10(),
            CustomCartButton(tap: () {}),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBoxDefault(),
              buildColumn(
                tap: () {
                  Get.toNamed(RouteHelper.getProfileRoute());
                },
                title: 'Profile',
              ),
              buildColumn(tap: () {}, title: 'My Orders'),
              buildColumn(tap: () {}, title: 'Cart'),
              buildColumn(tap: () {}, title: 'Notifications'),
              buildColumn(tap: () {
                Get.toNamed(RouteHelper.getCropDoctorRoute());

              }, title: 'Crop Doctor'),
              buildColumn(tap: () {}, title: 'Location'),
              buildColumn(tap: () {}, title: 'Contact Us'),
              buildColumn(tap: () {}, title: 'Privacy Policy'),
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildColumn({
    required Function() tap,
    required String title,
  }) {
    return InkWell(
      onTap: tap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: poppinsRegular.copyWith(
              fontSize: Dimensions.fontSize20,
            ),
          ),
          sizedBox4(),
          Divider(),
        ],
      ),
    );
  }
}
