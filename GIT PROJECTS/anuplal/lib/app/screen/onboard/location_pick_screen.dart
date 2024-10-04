import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/helper/route_helper.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LocationPickScreen extends StatelessWidget {
  const LocationPickScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSize20),
                    child: Image.asset(Images.imgPickLocation),
                  ),
                  sizedBox40(),
                  CustomButtonWidget(
                    isBold: false,
                    buttonText: " Use Current Location",
                    gradient: const LinearGradient(
                      colors: [Color(0xff739a2b), Color(0xff4c5829)],
                      stops: [0.2, 1],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    useGradient: true,
                    icon: Icons.my_location,
                    onPressed: () {
                      Get.toNamed(RouteHelper.getDashboardRoute());
                    },
                  ),
                  sizedBoxDefault(),
                  CustomButtonWidget(
                    isBold: false,
                    buttonText: " Search Location Manually",
                    transparent: true,
                    icon: CupertinoIcons.search,
                    onPressed: () {
                      Get.toNamed(RouteHelper.getDashboardRoute());
                    },
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(onPressed: () {
                      Get.toNamed(RouteHelper.getDashboardRoute());
                    },
                        child: Text('Skip >',style: poppinsMedium.copyWith(fontSize: Dimensions.fontSize14,
                            color: Theme.of(context).disabledColor.withOpacity(0.70)),)),
                  )
                ],
              ),
            ),
          ),
          Positioned(top:0,
          child  : Container(
              width: Get.size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor.withOpacity(0.08),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(Dimensions.radius30)
                  )
              ),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSize40),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('SET YOUR LOCATION',style: poppinsSemiBold.copyWith(fontSize: Dimensions.fontSize20,
                      color: Theme.of(context).primaryColor),),
                  Text('You can change it later',style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                      color: Theme.of(context).hintColor),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
