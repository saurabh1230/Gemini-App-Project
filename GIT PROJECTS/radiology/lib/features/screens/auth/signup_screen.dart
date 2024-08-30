import 'package:flutter/material.dart';
import 'package:radiology/controllers/auth_controller.dart';
import 'package:radiology/features/screens/auth/widgets/buttons.dart';
import 'package:radiology/features/screens/auth/widgets/logo_with_text_component.dart';
import 'package:radiology/features/widgets/custom_app_button.dart';
import 'package:radiology/features/widgets/custom_textfield_widget.dart';
import 'package:radiology/helper/route_helper.dart';
import 'package:radiology/utils/dimensions.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/sizeboxes.dart';
import 'package:radiology/utils/styles.dart';
import 'package:get/get.dart';
import 'package:radiology/utils/themes/light_theme.dart';

import '../../widgets/custom_snackbar_widget.dart';
class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});
   final _nameController = TextEditingController();
   final _emailController = TextEditingController();
   final _passwordController = TextEditingController();
   final _confirmPasswordController = TextEditingController();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      body: GetBuilder<AuthController>(builder: (authControl) {
        return  Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Form(
            key: _formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoWithTextComponent(),
                sizedBox4(),
                RichText(
                  text:  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Simplifying',
                          style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                              color: Theme.of(context).cardColor)
                      ),
                      TextSpan(
                        text: ' Radiology',
                        style: poppinsBold.copyWith(fontSize: Dimensions.fontSize14,
                            color: Theme.of(context).cardColor), // Different color for "resend"
                      ),
                      TextSpan(
                          text: ' for All',
                          style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                              color: Theme.of(context).cardColor)
                      ),
                    ],
                  ),
                ),
                sizedBox30(),
                CustomTextField(
                  capitalization: TextCapitalization.words,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    } else if (RegExp(r'[^\p{L}\s]', unicode: true).hasMatch(value)) {
                      return 'Full name must not contain special characters';
                    }
                    return null;
                  },
                  controller: _nameController,
                  hintText: 'Full Name',
                  prefixIcon: Icons.person,
                ),

                sizedBox12(),
                 CustomTextField(
                     validation: (value) {
                       if (value == null || value.isEmpty) {
                         return 'Please enter your email';
                       } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                                     return 'Please enter a valid email address';
                                   }
                                   return null;
                                 },
                   controller: _emailController,
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
                     } else if (value.length < 6) {
                       return 'Password must be at least 6 characters';
                     }
                     return null;
                   },
                  isPassword: true,
                  prefixIcon: Icons.lock,),
                sizedBox12(),
                CustomTextField(
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

                sizedBox40(),
                authControl.isLoading ?
                    const Center(child: CircularProgressIndicator()) :
                CustomButtonWidget(buttonText: 'Sign Up',isBold: false,
                  onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    _signUp(authControl);
                  }
                  },),
                sizedBoxDefault(),
                TextButton(
                  onPressed: () {
                    Get.toNamed(RouteHelper.getSignInRoute());
                  },
                  child: RichText(
                    text:  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Already a member ?',
                            style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize13,
                                color: Theme.of(context).cardColor)
                        ),
                        TextSpan(
                          text: ' Sign In',
                          style: poppinsMedium.copyWith(fontSize: Dimensions.fontSize14,
                              color: Theme.of(context).primaryColor), // Different color for "resend"
                        ),

                      ],
                    ),
                  ),
                ),
                sizedBox20(),
                Text('Or',style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                    color: Theme.of(context).cardColor.withOpacity(0.40))),
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

                // Row(mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GoogleSignInButton(tap: () {  },)
                //   ],
                // )


              ],
            ),
          ),
        );

      }),
    );
  }
   void _signUp(AuthController authController) async {
     String name = _nameController.text.trim();
     String email = _emailController.text.trim();
     String password = _passwordController.text.trim();
     String confirmPassword = _confirmPasswordController.text.trim();
     authController.registerApi(name, email, password, confirmPassword);
   }

}
