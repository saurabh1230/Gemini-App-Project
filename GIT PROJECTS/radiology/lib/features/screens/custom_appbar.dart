
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/utils/images.dart';
import 'package:radiology/utils/styles.dart';


import '../../utils/dimensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final Function? onBackPressed;
  final Widget? menuWidget;
  final Color? backGroundColor;

  const CustomAppBar({Key? key, required this.title, this.onBackPressed, this.isBackButtonExist = false, this.menuWidget, this.backGroundColor, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(

      title: Text(title!, style: poppinsMedium.copyWith(fontSize: Dimensions.fontSize18, color: Theme.of(context).cardColor)),
      centerTitle: true,
      leading: isBackButtonExist ? IconButton(
        icon:  const Icon(Icons.arrow_back_ios_rounded),
        color: Theme.of(context).cardColor,
        onPressed: () =>  Navigator.pop(context),
      ) :  Builder(
        builder: (context) => InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Container(
            padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Image.asset(Images.icMenu,height: 24,width: 24,),
          ),
        ),),

      backgroundColor:backGroundColor?? Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      actions: menuWidget != null ? [Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: menuWidget!,
      )] : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
