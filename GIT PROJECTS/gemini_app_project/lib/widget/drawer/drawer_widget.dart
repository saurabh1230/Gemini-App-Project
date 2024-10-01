import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini_app_project/core/constants/constants.dart';
import 'package:gemini_app_project/core/constants/icons.dart';
import 'package:gemini_app_project/core/constants/strings.dart';
import 'package:gemini_app_project/core/routes/app_routes.dart';
import 'package:gemini_app_project/core/utils/extension.dart';
import 'package:gemini_app_project/widget/gradient_text.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // width: MediaQuery.of(context).size.width / 1.3,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 150,
                decoration: const BoxDecoration(
                    // color: primaryColor,
                    ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Theme.of(context).colorScheme.splashLogo,
                        height: 60,
                        width: 60,
                      ),
                      const SizedBox(width: 10),
                      GradientText(
                        appName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              _drawerItem(
                context,
                icon: const Icon(Icons.history),
                label: AppStrings.history,
              ).ripple(
                () => Navigator.pushNamed(context, AppRoutes.historyScreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _drawerItem(
  BuildContext context, {
  required String label,
  Widget? icon,
}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      children: [
        icon ?? const SizedBox(),
        const SizedBox(
          width: 20,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ),
  );
}
