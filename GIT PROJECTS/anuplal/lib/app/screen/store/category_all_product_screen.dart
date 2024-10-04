import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/app/widgets/custom_buttons.dart';
import 'package:anuplal/app/widgets/custom_product_widget.dart';
import 'package:anuplal/helper/route_helper.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CategoryAllProductScreen extends StatelessWidget {
   CategoryAllProductScreen({super.key});

  final List<String> img = ['assets/images/img_product_demo.png','assets/images/img_product_demo.png','assets/images/img_product_demo.png','assets/images/img_product_demo.png','assets/images/img_product_demo.png','assets/images/img_product_demo.png'];
  final List<String> title = ['Seeds','Nutrients','Herbicides','Pesticides','Fungicides','Miscellaneous',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Seeds',menuWidget: Row(
        children: [
          CustomNotificationButton(tap: () {  },),
          sizedBoxW10(),
          CustomCartButton(tap: () {  },)
        ],
      ),),
      body: SingleChildScrollView(
        child:  GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              mainAxisExtent: 240
            // childAspectRatio: 0.7,
          ),
          itemCount: img.length,
          itemBuilder: (context, i) {
            return CustomProductWidget(
                productTap: () {
                  Get.toNamed(RouteHelper.getProductDetailRoute());
                },
                image: img[i],
                title: title[i],
                weight: '100 gm',
                price: '₹ 40',
                addCartTap: () {});
          },),
      ),

    );
  }
}
