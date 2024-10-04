import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class PostComponent extends StatelessWidget {
  const PostComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sameer',maxLines: 1,overflow: TextOverflow.ellipsis,
            style: poppinsSemiBold.copyWith(fontSize: Dimensions.fontSize14,
          color: Theme.of(context).primaryColor),),
          Text('20/08/2024',maxLines: 1,overflow: TextOverflow.ellipsis,
            style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize12,
                color: Theme.of(context).hintColor),),
          sizedBoxDefault(),
          Container(
            height: 200,width: Get.size.width,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
            ),child: Image.asset('assets/images/img_post_demo.png',fit: BoxFit.cover,),
          ),
          sizedBoxDefault(),
          Text('Lorem ipsum dolor sit amet',maxLines: 2,overflow: TextOverflow.ellipsis,
            style: poppinsSemiBold.copyWith(fontSize: Dimensions.fontSize14,
                color: Theme.of(context).disabledColor),),
          Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet accumsan arcu. Pellentesqu',maxLines: 3,overflow: TextOverflow.ellipsis,
            style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                color: Theme.of(context).hintColor),),
          Divider(),
          TextButton(
            onPressed: () {  },
            child: Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(Images.icComment,height: 24,width: 24,),
                sizedBoxW5(),
                Text('Comment',style: poppinsMedium.copyWith(fontSize: Dimensions.fontSize14,
                color: Theme.of(context).primaryColor),)
              ],
            ),
          )



        ],
      ),
    );
  }
}
