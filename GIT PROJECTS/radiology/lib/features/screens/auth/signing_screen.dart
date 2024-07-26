import 'package:flutter/material.dart';
import 'package:radiology/controllers/auth_controller.dart';
import 'package:radiology/features/screens/auth/widgets/buttons.dart';
import 'package:radiology/features/screens/auth/widgets/logo_with_text_component.dart';
import 'package:radiology/features/screens/forgot_password/forgot_password_sendmail_sheet.dart';
import 'package:radiology/features/widgets/custom_app_button.dart';
import 'package:radiology/features/widgets/custom_textfield_widget.dart';
import 'package:radiology/helper/route_helper.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
   SignInScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<AuthController>(builder: (authControl) {
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LogoWithTextComponent(),
                    sizedBox4(),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Simplifying',
                            style: poppinsRegular.copyWith(
                              fontSize: Dimensions.fontSize14,
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                          TextSpan(
                            text: ' Radiology',
                            style: poppinsBold.copyWith(
                              fontSize: Dimensions.fontSize14,
                              color: Theme.of(context).cardColor,
                            ), // Different color for "resend"
                          ),
                          TextSpan(
                            text: ' for All',
                            style: poppinsRegular.copyWith(
                              fontSize: Dimensions.fontSize14,
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    sizedBox20(),
                     CustomTextField(
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
                    sizedBox12(),
                      CustomTextField(
                        controller: _passwordController,
                      hintText: 'Password',
                       validation: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please enter your password';
                         }
                         return null;
                       },
                      isPassword: true,
                      prefixIcon: Icons.lock,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            onTap: () => authControl.toggleRememberMe(),
                            leading: Checkbox(
                              value: authControl.isActiveRememberMe,
                              onChanged: (bool? isChecked) =>
                                  authControl.toggleRememberMe(),
                            ),
                            title: Text(
                              'Remember me',
                              style: poppinsRegular.copyWith(
                                fontSize: Dimensions.fontSize12,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            horizontalTitleGap: 0,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.bottomSheet(
                              ForgotPasswordSendMailSheet(),
                              backgroundColor:  Theme.of(context).cardColor,
                              isScrollControlled: true,
                            );
                          },
                          child: Text(
                            'Forgot password?',
                            style: poppinsRegular.copyWith(
                              fontSize: 12,
                              color: Colors.red, // Changed to Colors.red for simplicity
                            ),
                          ),
                        ),
                      ],
                    ),
                    sizedBox40(),
                    authControl.isLoginLoading ?
                        const Center(child: CircularProgressIndicator()) :
                    CustomButtonWidget(
                      buttonText: 'Sign In',
                      isBold: false,
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          authControl.loginApi(_emailController.text, _passwordController.text);
                        }
                        // Get.toNamed(RouteHelper.getHomeRoute());
                      },
                    ),
                    sizedBoxDefault(),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(RouteHelper.getSignUpRoute());
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'New to Dr Outlier Radiology ?',
                              style: poppinsRegular.copyWith(
                                fontSize: Dimensions.fontSize13,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                            TextSpan(
                              text: ' Sign Up',
                              style: poppinsMedium.copyWith(
                                fontSize: Dimensions.fontSize14,
                                color: Theme.of(context).primaryColor,
                              ), // Different color for "resend"
                            ),
                          ],
                        ),
                      ),
                    ),
                    sizedBox20(),
                    Text(
                      'Or',
                      style: poppinsRegular.copyWith(
                        fontSize: Dimensions.fontSize14,
                        color: Theme.of(context).cardColor.withOpacity(0.40),
                      ),
                    ),
                    sizedBox20(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        authControl.googleLoading ?
                        const CircularProgressIndicator() :
                        GoogleSignInButton(
                          tap: () async {
                            final auth = await GoogleSignInClass().login();
                            print(auth.accessToken);
                            authControl.signInWithGoogle(auth.accessToken!);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

}
