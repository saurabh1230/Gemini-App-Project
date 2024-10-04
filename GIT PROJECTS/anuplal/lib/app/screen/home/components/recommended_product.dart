import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/helper/route_helper.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendedProduct extends StatelessWidget {
  RecommendedProduct({super.key});
  final List<String> img = ['assets/images/img_product_demo.png','assets/images/img_product_demo.png','assets/images/img_product_demo.png','assets/images/img_product_demo.png','assets/images/img_product_demo.png','assets/images/img_product_demo.png'];
  final List<String> title = ['Seeds','Nutrients','Herbicides','Pesticides','Fungicides','Miscellaneous',];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Text('Recommended Products',style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                color: Theme.of(context).primaryColor),),
          ),
          sizedBox10(),
          Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                mainAxisExtent: 240
                // childAspectRatio: 0.7,
              ),
              itemCount: img.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getProductDetailRoute());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                      border: Border.all(
                        width: 1,color: Theme.of(context).primaryColor.withOpacity(0.10)
                      ),
                    ),
                    padding: const EdgeInsets.all(Dimensions.paddingSize10),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(img[i],width: 100,height: 100,),
                        ),
                        sizedBox10(),
                        Text('Product Name',maxLines: 2, overflow: TextOverflow.ellipsis,
                          style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                        color: Theme.of(context).disabledColor.withOpacity(0.80)),),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text('100 gm', overflow: TextOverflow.ellipsis,
                                style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize12,
                                    color: Theme.of(context).hintColor),),
                            ),
                            Flexible(
                              child: Text('₹ 40', overflow: TextOverflow.ellipsis,
                                style: poppinsBold.copyWith(fontSize: Dimensions.fontSize18,
                                    color: Theme.of(context).primaryColor),),
                            ),
                          ],
                        ),
                        CustomButtonWidget(
                          height: 30,
                          isBold: false,
                          fontSize: Dimensions.fontSize14,
                          buttonText: "Add to Cart",
                          transparent: true,
                          onPressed: () {
                          },
                        ),

                      ],
                    ),
                  ),
                );
              },),),

        ],
      ),
    );
  }
}
