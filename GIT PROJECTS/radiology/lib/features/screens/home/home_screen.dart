import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:radiology/controllers/auth_controller.dart';
import 'package:radiology/features/widgets/confirmation_dialog.dart';
import 'package:radiology/features/widgets/drawer.dart';
import 'package:radiology/features/widgets/exit_confirmation_dialog.dart';
import 'package:radiology/helper/route_helper.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:get/get.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override


  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getUserDetailsApi();
    });
    return WillPopScope(
      onWillPop: () async {
        return await ExitConfirmationDialog.show(context);
      },
      child: SafeArea(
        child: GetBuilder<AuthController>(builder: (authControl) {
          return
            Scaffold(
              drawer: const CustomDrawer(),
            key: _scaffoldKey,
            appBar: AppBar(elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: Dimensions.paddingSize10),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () { _scaffoldKey.currentState?.openDrawer();},
                  child: Container(padding: const EdgeInsets.all(Dimensions.paddingSize12),
                    child: Image.asset(
                           Images.icMenuIcon,
                           height: Dimensions.paddingSize25,
                           width: Dimensions.paddingSize25,
                    ),
                  ),
                ),
              ),
              title: RichText(
                text:  TextSpan(
                  children: [
                    TextSpan(
                        text: 'Dr Outlier',
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
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Make a choice",style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                        color: Theme.of(context).cardColor.withOpacity(0.50)),),
                    sizedBox40(),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
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
                        ),
                        sizedBox40(),
                        Expanded(
                          child: GestureDetector(
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
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getOsceScreen());
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Lottie.asset('assets/images/osce.json', height: 200),
                          Positioned(
                            child: Text(
                              'OSCE',
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
                    const Spacer(),
                    Container(width: Get.size.width,
                        child: Image.asset(Images.homeBg,fit: BoxFit.cover,),)



                  ],
                ),
              ),
            ),
          );
        })

      ),
    );
  }
}
