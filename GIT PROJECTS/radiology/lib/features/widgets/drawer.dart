import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/controllers/auth_controller.dart';
import 'package:radiology/features/widgets/confirmation_dialog.dart';
import 'package:radiology/features/widgets/custom_app_button.dart';
import 'package:radiology/helper/route_helper.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: GetBuilder<AuthController>(builder: (authControl) {
          return  Column(
            children: [
              sizedBox10(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedBox10(),
                        RichText(
                          text:  TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Welcome to \nDr Outlier',
                                  style: poppinsLightBold.copyWith(fontSize: Dimensions.fontSize20,
                                      color: Theme.of(context).cardColor)
                              ),
                              TextSpan(
                                text: ' Radiology',
                                style: poppinsBold.copyWith(fontSize: Dimensions.fontSize20,
                                    color: Theme.of(context).primaryColor), // Different color for "resend"
                              ),

                            ],
                          ),
                        ),
                        Divider(color:Theme.of(context).cardColor ,),
                        buildContainer(context,"Saved Spotters",tap : () {
                          Get.toNamed(RouteHelper.getBookmarkRoute());
                        }),
                        Divider(color: Theme.of(context).cardColor,),
                        buildContainer(context,"Saved Notes",tap : () {
                          Get.toNamed(RouteHelper.getSavedNoteScreen());

                        }),
                        Divider(color: Theme.of(context).cardColor,),
                        buildContainer(context,"Saved OSCE",tap : () {
                          Get.toNamed(RouteHelper.getSavedOsceScreen());

                        }),
                        Divider(color: Theme.of(context).cardColor,),
                        buildContainer(context,"Saved Munchies",tap : () {
                          Get.toNamed(RouteHelper.getSavedMunchiesScreen());
                        }),
                        Divider(color: Theme.of(context).cardColor,),
                        buildContainer(context,"Saved Back To Basics",tap : () {
                          Get.toNamed(RouteHelper.getSavedBasicScreen());
                        }),
                        Divider(color: Theme.of(context).cardColor,),
                        buildContainer(context,"Saved Watch And Learn",tap : () {
                          Get.toNamed(RouteHelper.getSavedWatchScreen());
                        }),
                        Divider(color: Theme.of(context).cardColor,),
                        buildContainer(context,"Logout",tap : () {
                          Get.dialog(ConfirmationDialog(
                            icon: Images.icLogout,
                            iconColor: Colors.redAccent,
                            title: "Confirm Logout",
                            description: 'Are You Sure To Logout',
                            onYesPressed: () async {
                              authControl.logoutApi();
                              Get.find<AuthController>().clearSharedData();
                              Get.delete();
                              await GoogleSignInClass().logOut();
                            },
                          ));
                        }),

                        sizedBox30()
                      ],
                    ),
                  ),
                ),
              ),


            ],
          );
        })


      ),
    );
  }

  InkWell buildContainer(BuildContext context,String title,  {required  Function() tap}) {
    return InkWell(
      onTap:  tap,
      child: Container(width: Get.size.width,
          margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSize10),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: poppinsLightBold.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeDefault )),
              Icon(Icons.arrow_forward_ios_rounded,size: Dimensions.fontSizeDefault,color: Theme.of(context).cardColor,)
            ],
          )),
    );
  }
}
