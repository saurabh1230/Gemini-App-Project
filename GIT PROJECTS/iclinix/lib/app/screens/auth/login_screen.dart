import 'package:flutter/material.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';
import 'package:get/get.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              Images.loginScreenBG,
              fit: BoxFit.cover,
            ),
          ),
          // Bottom content
          Container(
            child: Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Ensures content is compact
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Text(
                      'Login/Register',
                      style: openSansExtraBold.copyWith(
                        fontSize: Dimensions.fontSize32,
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                  sizedBox20(),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text('Enter your Phone Number',style: openSansBold.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).disabledColor.withOpacity(0.50) ),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
