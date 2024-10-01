import 'package:flutter/material.dart';
import 'package:gemini_app_project/core/constants/strings.dart';
import 'package:gemini_app_project/core/utils/extension.dart';
import 'package:gemini_app_project/main.dart';
import 'package:gemini_app_project/widget/change_theme_switch.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
        // Hide/Show circle back button
        // leading: const GoBack(),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              title: _title(context, AppStrings.darkMode),
              trailing: const ChangeThemeSwitch(),
              leading: const Icon(Icons.dark_mode_outlined),
            ),
            _title(
              context,
              'Version: ${packageInfo.version}   Build: ${packageInfo.buildNumber}',
            ),
          ],
        ),
      ).defaultPaddingAll(),
    );
  }

  Widget _title(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }
}
