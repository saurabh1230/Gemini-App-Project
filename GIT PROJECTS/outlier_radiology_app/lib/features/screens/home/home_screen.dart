import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:outlier_radiology_app/controllers/auth_controller.dart';
import 'package:outlier_radiology_app/features/widgets/exit_confirmation_dialog.dart';
import 'package:outlier_radiology_app/helper/route_helper.dart';
import 'package:outlier_radiology_app/utils/dimensions.dart';
import 'package:outlier_radiology_app/utils/images.dart';
import 'package:get/get.dart';
import 'package:outlier_radiology_app/utils/sizeboxes.dart';
import 'package:outlier_radiology_app/utils/styles.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await ExitConfirmationDialog.show(context);
      },
      child: SafeArea(
        child: GetBuilder<AuthController>(builder: (authControl) {
          return Scaffold(
            appBar: AppBar(elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: RichText(
                text:  TextSpan(
                  children: [
                    TextSpan(
                        text: 'Dr Outlie',
                        style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).cardColor)
                    ),
                    TextSpan(
                      text: ' Radiology',
                      style: poppinsExtraBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).primaryColor), // Different color for "resend"
                    ),

                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () {
                  authControl.logoutApi();
                  Get.find<AuthController>().clearSharedData();


                }, child: Text('Logout',
                  style: poppinsMedium.copyWith(fontSize: Dimensions.fontSize12,color: Theme.of(context).cardColor),))

              ],
              // flexibleSpace: Row(mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Center(
              //       child: RichText(
              //         text:  TextSpan(
              //           children: [
              //             TextSpan(
              //                 text: 'Dr Outlie',
              //                 style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
              //                     color: Theme.of(context).cardColor)
              //             ),
              //             TextSpan(
              //               text: ' Radiology',
              //               style: poppinsExtraBold.copyWith(fontSize: Dimensions.fontSizeDefault,
              //                   color: Theme.of(context).primaryColor), // Different color for "resend"
              //             ),
              //
              //           ],
              //         ),
              //       ),
              //     ),
              //     TextButton(onPressed: () {}, child: Text('Logout',
              //     style: poppinsMedium.copyWith(fontSize: Dimensions.fontSize12,color: Theme.of(context).cardColor),))
              //   ],
              // ),
            ),
            bottomNavigationBar: SingleChildScrollView(
              child: Image.asset(Images.homeBg,fit: BoxFit.cover,),
            ),

            body: Container(
              width: Get.size.width,
              // height: Get.size.height,
              decoration: const BoxDecoration(
                // image: DecorationImage(
                //     alignment: Alignment.bottomCenter,
                //     image: AssetImage(Images.homeBg),fit: BoxFit.cover)
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Make a choice",style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                            color: Theme.of(context).cardColor.withOpacity(0.50)),),
                        sizedBox40(),
                        InkWell(
                          onTap: (){
                            Get.toNamed(RouteHelper.getSpottersRoute());
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Lottie.asset('assets/images/Blue circle 2.json', height: 200),
                              // Image.asset(
                              //   Images.imgSpotter,
                              //   height: 160,
                              //   fit: BoxFit.cover,
                              // ),
                              Positioned(
                                child: Text(
                                  'SPOTTERS',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700, // Adjust according to your needs
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context).cardColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        sizedBox40(),
                        InkWell(
                          onTap: (){
                            Get.toNamed(RouteHelper.getNotesRoute());
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Lottie.asset('assets/images/Green circle.json', height: 200),
                              Positioned(
                                child: Text(
                                  'NOTES',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700, // Adjust according to your needs
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context).cardColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        })

      ),
    );
  }
}
