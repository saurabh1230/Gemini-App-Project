import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:gemini_app_project/core/constants/constants.dart';
import 'package:gemini_app_project/core/constants/icons.dart';
import 'package:gemini_app_project/core/constants/strings.dart';
import 'package:gemini_app_project/core/routes/app_routes.dart';
import 'package:gemini_app_project/core/utils/extension.dart';
import 'package:gemini_app_project/core/utils/utils.dart';
import 'package:gemini_app_project/provider/chat_provider.dart';
import 'package:gemini_app_project/provider/theme_provider.dart';
import 'package:gemini_app_project/widget/drawer/drawer_widget.dart';
import 'package:gemini_app_project/widget/gradient_button.dart';
import 'package:gemini_app_project/widget/gradient_text.dart';
import 'package:gemini_app_project/widget/round_filled_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        dialogue(
          context,
          title: AppStrings.exitMsg,
          onPressedRight: () => SystemNavigator.pop(),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Builder(
            builder: (context) {
              return SizedBox(
                height: 45,
                width: 45,
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              );
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                height: 45,
                width: 45,
                child: RoundFilledButton(
                  icon: Icons.settings_outlined,
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.settingScreen),
                ),
              ),
            ),
          ],
        ),
        drawer: const DrawerWidget(),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Consumer<ThemeProvider>(
                      builder: (context, value, _) {
                        final theme = value.currentTheme;
                        return Transform.scale(
                          scale: 1.8,
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: Lottie.asset(
                              Theme.of(context).colorScheme.pulseLottie,
                              delegates: LottieDelegates(
                                values: [
                                  ValueDelegate.color(
                                    const ['**', 'Pre-comp 1', '**'],
                                    value: theme == ThemeMode.dark
                                        ? Colors.grey.shade800
                                        : Colors.grey.shade300,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: SvgPicture.asset(
                        Theme.of(context).colorScheme.splashLogo,
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(
                  AppStrings.welcomeTo,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const GradientText(
                  appName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppStrings.welcomeDescription,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(
                  flex: 2,
                ),
                SizedBox(
                  height: 55,
                  width: size.width,
                  child: GradientButton(
                    text: AppStrings.startChat,
                    onPressed: () {
                      final provider = context.read<ChatProvider>();
                      provider.disposeChat();
                      provider.sessionId = randomId(count: 14);
                      // print(provider.sessionId);
                      Navigator.pushNamed(context, AppRoutes.chatScreen);
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ).defaultPaddingAll(),
      ),
    );
  }
}
