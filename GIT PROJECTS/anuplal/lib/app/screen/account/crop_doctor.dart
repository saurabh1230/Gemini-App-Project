import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/app/widgets/custom_buttons.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CropDoctorScreen extends StatelessWidget {
  const CropDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Crop Doctor',isBackButtonExist: true,
        menuWidget: Row(
          children: [
            CustomNotificationButton(tap: () {  },),
            sizedBoxW10(),
            CustomCartButton(tap: () {  },)
          ],
        ),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Got crop concerns?',style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
              sizedBox4(),
              Text('Our crop doctors are here to diagnose issues, recommend treatments, and ensure your crops thrive. Just a click away!',
                style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).hintColor),),
              Image.asset(Images.icCropDoctor,height: 180,),
              sizedBox40(),
              CustomButtonWidget(
                isBold: false,
                buttonText: " Message issue",
                transparent: true,
                icon: Icons.chat,
                onPressed: () {
                },
              ),
              sizedBoxDefault(),
              CustomButtonWidget(
                isBold: false,
                buttonText: " Call the Expert",
                gradient: const LinearGradient(
                  colors: [Color(0xff739a2b), Color(0xff4c5829)],
                  stops: [0.2, 1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                useGradient: true,
                icon: Icons.call,
                onPressed: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
