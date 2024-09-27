import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_button_widget.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';

class NeedForHelpComponent extends StatelessWidget {
   NeedForHelpComponent({super.key});
  final List<String> img = [Images.imgVitreo,Images.imgCataract,Images.imgGlaucoma,Images.imgLow,Images.imgNeuro,Images.imgCornea];
   final List<String> title = ['Vitreo\n Retina','Cataract\n Services','Glaucoma','Low Vision\n Aids','Neuro\nophthalmology','Cornea &\n Refractive',];

   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Need Help For?',style: openSansBold.copyWith(fontSize: Dimensions.fontSizeDefault,)),
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
                        style: openSansMedium.copyWith(fontSize:Dimensions.fontSize14,
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
