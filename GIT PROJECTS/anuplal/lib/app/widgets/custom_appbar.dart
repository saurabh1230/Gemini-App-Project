import 'package:anuplal/utils/styles.dart';
import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import '../../utils/sizeboxes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final Function? onBackPressed;
  final Widget? menuWidget;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.isBackButtonExist = false,
    this.menuWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // toolbarHeight: 200, // You can adjust this height as needed
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor.withOpacity(0.07),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(Dimensions.radius30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Column(
                children: [
                  sizedBox30(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(Images.logo, width: 140),
                            Row(
                              children: [
                                isBackButtonExist
                                    ? IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () => Navigator.pop(context),
                                )
                                    : const SizedBox(width: 0, height: 0),
                                Text(
                                  title!,
                                  style: poppinsMedium.copyWith(
                                    color: Theme.of(context).secondaryHeaderColor,
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (menuWidget != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                          child: menuWidget!,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      centerTitle: false,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).cardColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100); // Adjusted to match the expanded height
}
