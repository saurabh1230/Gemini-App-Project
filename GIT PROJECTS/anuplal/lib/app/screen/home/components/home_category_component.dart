import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeCategoryComponent extends StatelessWidget {
  HomeCategoryComponent({super.key});
  final List<String> img = ['assets/images/img_seeds.png','assets/images/img_seeds.png','assets/images/img_seeds.png','assets/images/img_seeds.png','assets/images/img_seeds.png','assets/images/img_seeds.png'];
  final List<String> title = ['Seeds','Nutrients','Herbicides','Pesticides','Fungicides','Miscellaneous',];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Text('Product Categories',style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                color: Theme.of(context).primaryColor),),
          ),
          sizedBox10(),
          SizedBox(height: 300,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.8,
              ),
              itemCount: img.length,
              itemBuilder: (context, i) {
                return Column(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(img[i],height: 70,),
                    sizedBox4(),
                    Text(textAlign: TextAlign.center,
                        title[i],
                        style: poppinsMedium.copyWith(fontSize:Dimensions.fontSize14,
                            color: Theme.of(context).hintColor))
                  ],);
              },),),
          CustomButtonWidget(buttonText: 'View All Services',
            onPressed: () {},
            isBold: false,
            transparent: true,)

        ],
      ),
    );
  }
}
