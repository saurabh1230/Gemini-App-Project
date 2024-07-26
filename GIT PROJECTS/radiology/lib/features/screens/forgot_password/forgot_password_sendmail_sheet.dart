
import 'package:radiology/controllers/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/features/widgets/custom_app_button.dart';
import 'package:radiology/features/widgets/custom_textfield_widget.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';

import 'forgot_password_verify_code.dart';

class ForgotPasswordSendMailSheet extends StatelessWidget {
  ForgotPasswordSendMailSheet ({super.key});
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Get.find<ProfileController>().getBasicInfoApi();
    //
    // });
    return GetBuilder<AuthController>(builder: (authControl) {
      return   Container(
          color: Theme.of(context).cardColor,
          width: Get.size.width,
          child:
           SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(child: Text('Forgot Password',style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                    sizedBoxDefault(),
                    Text('Enter Your Email or phone to verify',style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize12,
                    color: Theme.of(context).disabledColor.withOpacity(0.60)),),
                    sizedBox20(),
                    CustomTextField(
                      hintColor: Theme.of(context).disabledColor.withOpacity(0.50),
                      borderColor:Theme.of(context).disabledColor.withOpacity(0.20) ,
                      fillColor:  Theme.of(context).hintColor.withOpacity(0.10),
                      controller: _emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      hintText: 'E-mail',
                      prefixIcon: Icons.email,
                    ),
                    sizedBox20(),
                    authControl.isforgotPassLoading ?
                        const Center(child: CircularProgressIndicator()) :
                    CustomButtonWidget(
                      buttonText: 'Continue',
                      isBold: false,
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          authControl.forgotPassEmailApi(_emailController.text);

                          // Get.bottomSheet(
                          //   ForgotPasswordVerifyCodeSheet(email: _emailController.text,),
                          //   backgroundColor:  Theme.of(context).cardColor,
                          //   isScrollControlled: true,
                          // );
                          // Get.back();

                        }
                        // Get.toNamed(RouteHelper.getHomeRoute());
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      });

  }
}