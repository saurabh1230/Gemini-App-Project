import 'package:anuplal/app/screen/store/widget/horizontal_product_widget.dart';
import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/helper/route_helper.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_buttons.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Stores',menuWidget: Row(
        children: [
          CustomNotificationButton(tap: () {  },),
          sizedBoxW10(),
          CustomCartButton(tap: () {  },)
        ],
      ),),
      body: SingleChildScrollView(
        child: Column(children: [
          sizedBoxDefault(),
          HorizontalProductWidget(
            sectionTitle: 'SEEDS',
            imgList: ['assets/images/img_product_demo.png', 'assets/images/img_product_demo.png', 'assets/images/img_product_demo.png'],
            titleList: ['Seeds', 'Nutrients','Seeds',],
            weightList: ['100 gm', '200 gm','200 gm'],
            priceList: ['40', '80','80'],
            productTap: () {  Get.toNamed(RouteHelper.getProductDetailRoute());},
            seeAllTap: () {
              Get.toNamed(RouteHelper.getCategoryProductRoute());
            },
          ),
          sizedBoxDefault(),
          HorizontalProductWidget(
            sectionTitle: 'Herbicides',
            imgList: ['assets/images/img_product_demo.png', 'assets/images/img_product_demo.png', 'assets/images/img_product_demo.png'],
            titleList: ['Seeds', 'Nutrients','Seeds',],
            weightList: ['100 gm', '200 gm','200 gm'],
            priceList: ['40', '80','80'],
            productTap: () {  Get.toNamed(RouteHelper.getProductDetailRoute()); },
            seeAllTap: () { Get.toNamed(RouteHelper.getCategoryProductRoute()); },
          ),
          sizedBoxDefault(),
          HorizontalProductWidget(
            sectionTitle: 'Pesticides',
            imgList: ['assets/images/img_product_demo.png', 'assets/images/img_product_demo.png', 'assets/images/img_product_demo.png'],
            titleList: ['Seeds', 'Nutrients','Seeds',],
            weightList: ['100 gm', '200 gm','200 gm'],
            priceList: ['40', '80','80'],
            productTap: () { Get.toNamed(RouteHelper.getProductDetailRoute()); },
            seeAllTap: () {
              Get.toNamed(RouteHelper.getCategoryProductRoute());
            },
          ),
          sizedBoxDefault(),
          HorizontalProductWidget(
            sectionTitle: 'Farm Machinery',
            imgList: ['assets/images/img_product_demo.png', 'assets/images/img_product_demo.png', 'assets/images/img_product_demo.png'],
            titleList: ['Seeds', 'Nutrients','Seeds',],
            weightList: ['100 gm', '200 gm','200 gm'],
            priceList: ['40', '80','80'],
            productTap: () {  Get.toNamed(RouteHelper.getProductDetailRoute()); },
            seeAllTap: () {
              Get.toNamed(RouteHelper.getCategoryProductRoute());
            },
          ),
          sizedBoxDefault(),
          HorizontalProductWidget(
            sectionTitle: 'Growth Promoters',
            imgList: ['assets/images/img_product_demo.png', 'assets/images/img_product_demo.png', 'assets/images/img_product_demo.png'],
            titleList: ['Seeds', 'Nutrients','Seeds',],
            weightList: ['100 gm', '200 gm','200 gm'],
            priceList: ['40', '80','80'],
            productTap: () { Get.toNamed(RouteHelper.getProductDetailRoute()); },
            seeAllTap: () {
              Get.toNamed(RouteHelper.getCategoryProductRoute());
            },
          ),
          sizedBox100(),



        ],
        ),
      ),
    );
  }
}
