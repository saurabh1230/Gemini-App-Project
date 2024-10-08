import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:radiology/controllers/auth_controller.dart';
import 'package:radiology/features/screens/search/search_screen.dart';
import 'package:radiology/features/widgets/drawer.dart';
import 'package:radiology/features/widgets/exit_confirmation_dialog.dart';
import 'package:radiology/helper/route_helper.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:get/get.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/strings.dart';
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
          return Scaffold(
            drawer: const CustomDrawer(),
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: Dimensions.paddingSize10),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(Dimensions.paddingSize12),
                    child: Image.asset(
                      Images.icMenuIcon,
                      height: Dimensions.paddingSize25,
                      width: Dimensions.paddingSize25,
                    ),
                  ),
                ),
              ),
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Dr Outlier',
                      style: poppinsRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                    TextSpan(
                      text: ' Radiology',
                      style: poppinsExtraBold.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () {
                  Get.to(SearchScreen());
                }, child: Icon(CupertinoIcons.search,
                color: Theme.of(context).cardColor,))
              ],
            ),
            body: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 200, // Adjust the height according to your requirement
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.bottomCenter,
                        image: AssetImage(Images.homeBg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text("Make a choice",style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                        color: Theme.of(context).cardColor.withOpacity(0.50)),),
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
                                Lottie.asset('assets/images/Blue circle 2.json', height: 170),
                                Positioned(
                                  child: Text(
                                    textAlign: TextAlign.center,
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
                                Lottie.asset('assets/images/Green circle.json', height: 170),
                                Positioned(
                                  child: Text(
                                    textAlign: TextAlign.center,
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
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.getOsceScreen());
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Lottie.asset('assets/images/osce.json', height: 170),
                                Positioned(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    AppStrings.osce,
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
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.getMunchiesCategoryScreen());
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Lottie.asset('assets/images/Red circle.json', height: 170),
                                Positioned(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    AppStrings.munchies,
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
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.getBasicCategoryScreen());
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Lottie.asset('assets/images/green.json', height: 170),
                                Positioned(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    AppStrings.backToBasics,
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
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.getWatchCategoryScreen());
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Lottie.asset('assets/images/Grey circle.json', height: 170),
                                Positioned(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    AppStrings.watchAndLearn,
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
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

