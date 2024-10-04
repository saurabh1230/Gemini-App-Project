import 'dart:io';

import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/app/widgets/custom_buttons.dart';
import 'package:anuplal/app/widgets/custom_network_image.dart';
import 'package:anuplal/app/widgets/underline_textfield.dart';
import 'package:anuplal/controller/profile_controller.dart';
import 'package:anuplal/utils/app_constants.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});

  final _usernameController = TextEditingController();
   final _emailController = TextEditingController();
   final _phoneController = TextEditingController();
   final _deliveryController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Account',isBackButtonExist: true,
        menuWidget: Row(
          children: [
            CustomNotificationButton(tap: () {  },),
            sizedBoxW10(),
            CustomCartButton(tap: () {  },)
          ],
        ),),
      body: SingleChildScrollView(
        child: GetBuilder<ProfileController>(builder: (profileControl) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              children: [
                sizedBox20(),
                Center(
                  child: Container(
                    height: 150, width: 150,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(shape: BoxShape.circle,
                      border: Border.all(width: 0.5,
                        color: Theme.of(context).primaryColor.withOpacity(0.40),),
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                    // alignment: Alignment.center,
                    child:profileControl.pickedImage != null ? Image.file(
                      File(profileControl.pickedImage!.path,),height: 90, width: 90,  fit: BoxFit.cover,
                    ): Stack(
                      children: [
                        Container(
                            height: 150, width: 150,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                            ),
                            child:
                            const CustomNetworkImageWidget(
                              imagePadding: Dimensions.paddingSize40,
                              height: 150, width: 150,
                              image: '',
                              placeholder: Images.icGallery,
                              fit: BoxFit.cover,)
                        ),
                        // Image.asset(Images.profilePlaceholder,)
                      ],
                    ),
                  ),
                ),
                sizedBoxDefault(),
                 TextFieldWidget(hintText: 'Username', controller: _usernameController,),
                TextFieldWidget(hintText: 'Email Address', controller: _emailController,),
                TextFieldWidget(hintText: 'Phone Number', controller: _phoneController,),
                TextFieldWidget(hintText: 'Delivery location', controller: _deliveryController,
                suffix: Icon(Icons.location_on_sharp,color: Theme.of(context).primaryColor,),),

              ],
            ),
          );
        })
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SingleChildScrollView(
          child: CustomButtonWidget(buttonText: 'Save',
          onPressed: () {
            Get.back();
          },),
        ),
      ),
    );
  }
}
