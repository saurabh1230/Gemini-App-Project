
import 'package:radiology/controllers/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/features/screens/forgot_password/forgot_password_set_new.dart';
import 'package:radiology/features/widgets/custom_app_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';

class ForgotPasswordVerifyCodeSheet extends StatelessWidget {
  final String email;
  ForgotPasswordVerifyCodeSheet ({super.key, required this.email});
  final _otpController = TextEditingController();
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
                  Text('Please Enter Received Otp to Verify',style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize12,
                      color: Theme.of(context).disabledColor.withOpacity(0.60)),),
                  sizedBox20(),
              PinCodeTextField(
                length: 6,
                appContext: context,
                keyboardType: TextInputType.number,
                animationType: AnimationType.slide,
                controller: _otpController,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  fieldHeight: 45,
                  fieldWidth: 45,
                  borderWidth: 1,
                  activeBorderWidth: 1,
                  inactiveBorderWidth: 1,
                  errorBorderWidth: 1,
                  selectedBorderWidth: 1,
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  selectedColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  inactiveColor: Theme.of(context).primaryColor,
                  activeColor: Theme.of(context).primaryColor,
                  activeFillColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                validator: (value) {
                  if (value == null || value.length != 6) {
                    return 'Please enter a 6-digit code';
                  }
                  return null;
                },
                onChanged: (val) {},
                beforeTextPaste: (text) => true,
              ),

                  sizedBox20(),
                  authControl.isforgotPassLoading ?
                  const Center(child: CircularProgressIndicator()) :
                  CustomButtonWidget(
                    buttonText: 'Continue',
                    isBold: false,
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        authControl.forgotPassOtpApi(_otpController.text, email);
                        // Get.bottomSheet(
                        //   ForgotPasswordSetNewSheet(email: email, otp: _otpController.text,),
                        //   backgroundColor:  Theme.of(context).cardColor,
                        //   isScrollControlled: true,
                        // );


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