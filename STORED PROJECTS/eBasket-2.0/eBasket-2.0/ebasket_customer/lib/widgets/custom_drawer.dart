import 'package:ebasket_customer/theme/app_theme_data.dart';
import 'package:ebasket_customer/utils/dimensions.dart';
import 'package:ebasket_customer/utils/sizeboxes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
    return SafeArea(
      child: Scaffold(
          body: SafeArea(
              child: Container(
                width: Get.size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSize20,horizontal: Dimensions.paddingSizeDefault),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(Dimensions.radius20),
                          bottomRight: Radius.circular(Dimensions.radius20),
                        ),
                      ),
                      child:
                      Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(onTap: () {
                                Get.back();
                              }, child: Icon(Icons.arrow_back,color: Theme.of(context).cardColor,)),
                              SizedBox(width: 10,),
                              Text("Welcome",style: TextStyle(
                                color: AppThemeData.black,
                                fontSize: 14,
                                fontFamily: AppThemeData.medium,
                                fontWeight: FontWeight.w500,
                              ),),
                              buildContainer(context,"Terms & Conditions", tap: () {
                              }),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }

  InkWell buildContainer(
      BuildContext context,
      String title, {
        Color? color,
        required Function() tap,
      }) {
    return InkWell(
      onTap: tap,
      child: Container(
        width: Get.size.width,
        margin: const EdgeInsets.only(top: Dimensions.paddingSize10),
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeDefault,
          horizontal: Dimensions.paddingSize10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius5),
          color: color ?? Theme.of(context).primaryColor.withOpacity(0.04),
        ),
        child: Text(
          title,
        ),
      ),
    );
  }

}
