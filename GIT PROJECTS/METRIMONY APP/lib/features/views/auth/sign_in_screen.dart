

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bureau_couple/features/widgets/buttons.dart';
import 'package:bureau_couple/features/widgets/custom_button_widget.dart';
import 'package:bureau_couple/features/widgets/custom_snackbar.dart';
import 'package:bureau_couple/features/widgets/custom_textfield_widget.dart';
import 'package:bureau_couple/utils/assets.dart';
import 'package:bureau_couple/utils/dimensions.dart';
import 'package:bureau_couple/utils/sizeboxes.dart';
import 'package:bureau_couple/utils/styles.dart';

import '../../../controllers/auth_controller.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return  SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(icSignInBG),
                    Container(
                      child: Stack(
                        children: [
                          Image.asset(icSignInLinearBG),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0,
                                left: 20,
                                right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                backButton(context: context, image: icArrowLeft, onTap: () {
                                  Get.back();
                                }),
                                SizedBox(height:80 ,),
                                Image.asset(icLogo,
                                  width: 72,
                                  height: 59,),
                                sizedBox10(),
                                Text(
                                  "Sign In",
                                  style: satoshiBold.copyWith(fontSize: Dimensions.fontSize32),
                                  textAlign: TextAlign.center,),
                                Text(
                                  "Log in to continue your journey of\nyour love and connetion",
                                  style: satoshiMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                                  textAlign: TextAlign.center,),
                                sizedBox20(),
                                AutofillGroup(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Email / Username",
                                        style: satoshiMedium.copyWith(fontSize: Dimensions.fontSize15),),
                                      sizedBox6(),

                                      CustomTextField(
                                        controller: emailController,
                                        hintText: 'Username',),
                                      sizedBox20(),
                                      Text("Password",
                                        style: satoshiMedium.copyWith(fontSize: Dimensions.fontSize15),),
                                      sizedBox6(),
                                      CustomTextField(
                                        controller: passwordController,
                                        isPassword: true,
                                        hintText: 'Password',),

                                      const SizedBox(height: 21,),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            // showModalBottomSheet(
                                            //   context: context,
                                            //   isScrollControlled: true,
                                            //   builder: (BuildContext context) {
                                            //     return ForgotPassEmailSheet();
                                            //   },
                                            // );
                                            // Navigator.push(context, MaterialPageRoute(builder: (builder) => ForgotPasswordScreen()));
                                          },
                                          child: Text("Forgot Password",
                                            textAlign: TextAlign.right,
                                            style: satoshiRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                                        ),
                                      ),

                                      sizedBoxDefault(),
                                      !authController.isLoading ?
                                      CustomButtonWidget(buttonText: "Sign In",
                                        onPressed: () => _login(authController),) :
                                          const Center(child: CircularProgressIndicator()),


                                      sizedBox30(),
                                      Align(
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () {
                                            // Navigator.push(context, MaterialPageRoute(
                                            //     builder: (builder) =>
                                            //     const SignInOptionScreen()));
                                          },
                                          child: Text("Sign Up Now",
                                            textAlign: TextAlign.center,
                                            style:satoshiBold.copyWith(fontSize: Dimensions.fontSize18) ,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )

              ],
            ),
          );
        }),

    );
  }
  void _login(AuthController authController) async {
    String username = emailController.text.trim();
    String password = passwordController.text.trim();
    if (username.isEmpty) {
      showCustomSnackBar('Enter your username for login');
    } else if (password.isEmpty ) {
      showCustomSnackBar('Enter your password for login');
    } else {
      authController.loginApi(username,password);
    }
  }

}
