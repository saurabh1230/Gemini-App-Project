
import 'package:radiology/controllers/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/features/widgets/custom_app_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:radiology/features/widgets/custom_textfield_widget.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';

class ForgotPasswordSetNewSheet extends StatelessWidget {
  final String email;
  final String otp;
  ForgotPasswordSetNewSheet ({super.key, required this.email, required this.otp});
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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
            padding: const EdgeInsets.all(16.0),
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
                  sizedBox12(),
                  CustomTextField(
                    hintColor: Theme.of(context).disabledColor.withOpacity(0.50),
                    borderColor:Theme.of(context).disabledColor.withOpacity(0.20) ,
                    fillColor:  Theme.of(context).hintColor.withOpacity(0.10),
                    controller: _passwordController,
                    hintText: 'Password',
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    isPassword: true,
                    prefixIcon: Icons.lock,),
                  sizedBox12(),
                  CustomTextField(
                    hintColor: Theme.of(context).disabledColor.withOpacity(0.50),
                    borderColor:Theme.of(context).disabledColor.withOpacity(0.20) ,
                    fillColor:  Theme.of(context).hintColor.withOpacity(0.10),
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password again';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },

                    isPassword: true,
                    prefixIcon: Icons.lock,
                  ),

                  sizedBox20(),
                  authControl.isforgotPassLoading ?
                      const Center(child: CircularProgressIndicator()) :
                  CustomButtonWidget(
                    buttonText: 'Change Password',
                    isBold: false,
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        authControl.forgotPassResetApi(otp, email, _passwordController.text, _confirmPasswordController.text);



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