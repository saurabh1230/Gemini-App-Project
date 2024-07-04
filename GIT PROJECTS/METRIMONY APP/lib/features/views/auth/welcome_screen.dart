
import 'package:flutter/material.dart';
import 'package:bureau_couple/features/widgets/custom_button_widget.dart';
import 'package:bureau_couple/helper/route_helper.dart';
import 'package:bureau_couple/utils/assets.dart';
import 'package:bureau_couple/utils/dimensions.dart';
import 'package:bureau_couple/utils/sizeboxes.dart';
import 'package:bureau_couple/utils/styles.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 0.5,
                  decoration:  BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      gradient:LinearGradient(
                        colors: [Color(0xffffffff), Color(0xfff7325d)],
                        stops: [0.02, 0.5],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      )

                  ),
                ),
                Container(
                  height: 0.5,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Welcome",
                    style: satoshiBold.copyWith(fontSize: Dimensions.fontSize30,color: Theme.of(context).primaryColor),),
                  sizedBox8(),
                  Text("Embark on your journey to Everlasting\nLove Where Connection Blossoms",
                    textAlign: TextAlign.center,
                    style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                  const SizedBox(height: 59,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26.0),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Image.asset(
                                icWelcome1,
                              ),
                            ),
                            const SizedBox(width: 4,),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Image.asset(
                                  icWelcome2,
                                ),
                              ),
                            )
                          ],
                        ),
                        Positioned(
                            left: 40,
                            right: 40,
                            top: 40,
                            bottom:40,
                            child: Container(
                              padding: const EdgeInsets.all(40),
                              child: Image.asset(icHeartWelcome,
                                height: 72,
                                width: 72,),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 39,),
                  Text("Continue with Social Media",
                    style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                  sizedBox16(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Image.asset(icFacebook,
                          height: 48,
                          width: 48,),
                      ),
                      sizedBoxW15(),
                      Flexible(
                        child: Image.asset(icGoogle,
                          height: 48,
                          width: 48,),
                      ),
                      sizedBoxW15(),
                      Flexible(
                        child: Image.asset(icApple,
                          height: 48,
                          width: 48,),
                      ),
                    ],
                  ),
                  sizedBox28(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: CustomButtonWidget(
                      onPressed: () {},
                        buttonText: "Create Account"),
                    // child: button(
                    //     onTap: () {
                    //       // Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                    //       // const SignInOptionScreen()));
                    //     },
                    //     context: context,
                    //     title: 'Create Account'),
                  ),
                  const SizedBox(height: 29,),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Get.toNamed(RouteHelper.getSignInRoute());
                      // Navigator.push(context, MaterialPageRoute(builder: (builder)=>
                      // const SignInScreen()));
                      },
                    child: Text("Sign in",
                      style: satoshiBold.copyWith(fontSize: Dimensions.fontSize18),),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
