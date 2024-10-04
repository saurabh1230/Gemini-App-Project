import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/app/widgets/custom_buttons.dart';
import 'package:anuplal/controller/product_controller.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:get/get.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Product Detail',
        isBackButtonExist: true,
        menuWidget: Row(
        children: [
        CustomNotificationButton(tap: () {  },),
        sizedBoxW10(),
        CustomCartButton(tap: () {  },)
      ],
    ),),
      body: SingleChildScrollView(
        child: GetBuilder<ProductController>(builder: (productControl) {
          return Column(
            children: [
              sizedBoxDefault(),
              Text(
                'Product Title',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: poppinsSemiBold.copyWith(
                  fontSize: Dimensions.fontSize20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Image.asset('assets/images/demo_img_big.png',),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Row(
                  children: [
                    Wrap(
                      spacing: 8.0, // Space between chips
                      runSpacing: 8.0, // Space between lines of chips
                      children: List.generate(
                        productControl.weightType.length,
                            (index) {
                          final val = productControl.weightType[index];
                          final isSelected = productControl.weightString.contains(val);
                          return GestureDetector(
                            onTap: () {
                              productControl.selectWeightString(val);
                            },
                            child: Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                              decoration: BoxDecoration(
                                color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.10) : Colors.transparent,
                                borderRadius: BorderRadius.circular(Dimensions.radius5),
                                border: Border.all(
                                  width: 0.5,
                                  color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  val,
                                  style: poppinsRegular.copyWith(
                                    color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).disabledColor.withOpacity(0.40),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(
                  children: [
                    Align(alignment: Alignment.centerLeft,
                      child: Text(
                        'Description',
                        style: poppinsMedium.copyWith(
                          fontSize: Dimensions.fontSize14,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet accumsan arcu. Pellentesqu Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet accumsan arcu. Pellentesqu',
                      style: poppinsRegular.copyWith(
                        fontSize: Dimensions.fontSize14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    sizedBox20(),
                    CustomButtonWidget(
                      isBold: false,
                      buttonText: " Contact Store",
                      transparent: true,
                      icon: Icons.call,
                      onPressed: () {
                        // Get.toNamed(RouteHelper.getDashboardRoute());
                      },
                    ),
                    sizedBoxDefault(),
                    CustomButtonWidget(
                      isBold: false,
                      buttonText: " Add to Cart",
                      gradient: const LinearGradient(
                        colors: [Color(0xff739a2b), Color(0xff4c5829)],
                        stops: [0.2, 1],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      useGradient: true,
                      onPressed: () {

                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        })




      ) ,
    );
  }
}
