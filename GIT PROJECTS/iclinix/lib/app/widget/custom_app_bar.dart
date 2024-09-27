
import 'package:flutter/material.dart';
import 'package:iclinix/utils/images.dart';
import 'package:iclinix/utils/styles.dart';



import '../../utils/dimensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final Function? onBackPressed;
  final Widget? menuWidget;

  const CustomAppBar({Key? key, required this.title, this.onBackPressed, this.isBackButtonExist = false, this.menuWidget, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!, style: openSansBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).disabledColor)),
      centerTitle: false,
      leading: isBackButtonExist ? IconButton(
        icon:  const Icon(Icons.arrow_back),
        color: Theme.of(context).primaryColor,
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

      backgroundColor: Theme.of(context).cardColor,
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
