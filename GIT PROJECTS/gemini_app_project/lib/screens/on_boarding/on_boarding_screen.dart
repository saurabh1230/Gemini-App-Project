import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini_app_project/core/constants/constants.dart';
import 'package:gemini_app_project/core/constants/icons.dart';
import 'package:gemini_app_project/core/constants/strings.dart';
import 'package:gemini_app_project/core/routes/app_routes.dart';
import 'package:gemini_app_project/core/utils/extension.dart';
import 'package:gemini_app_project/core/utils/hive_box.dart';
import 'package:gemini_app_project/model/onboarding_model.dart';
import 'package:gemini_app_project/widget/gradient_button.dart';
import 'package:gemini_app_project/widget/gradient_text.dart';
import 'package:gemini_app_project/widget/page_indicator.dart';
import 'package:gemini_app_project/widget/round_filled_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  late int totalOnboard;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  // Added onBoarding List
  List<OnBoarding> onBoardingList(BuildContext context) => [
        OnBoarding(
          image: Theme.of(context).colorScheme.splashLogo,
          title: AppStrings.onBoardingTitle1,
          description: AppStrings.onBoardingDescription1,
        ),
        OnBoarding(
          image: Theme.of(context).colorScheme.splashLogo,
          title: AppStrings.onBoardingTitle2,
          description: AppStrings.onBoardingDescription2,
        ),
        OnBoarding(
          image: Theme.of(context).colorScheme.splashLogo,
          title: AppStrings.onBoardingTitle3,
          description: AppStrings.onBoardingDescription3,
        ),
      ];

  // Go main page
  goMainPage() {
    HiveBoxPref.setBool(isFIrstTimeUserKey, false); // false
    Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    totalOnboard = onBoardingList(context).length;
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              if (_activeIndex > 0)
                SizedBox(
                  width: 45,
                  height: 45,
                  child: RoundFilledButton(
                    icon: Icons.arrow_back_rounded,
                    onPressed: () => pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ),
              if (_activeIndex != totalOnboard - 1) ...[
                const Spacer(),
                SizedBox(
                  height: 45,
                  child: RoundFilledButton(
                    text: AppStrings.skip,
                    onPressed: () => goMainPage(),
                  ),
                ),
              ],
            ],
          ).defaultPaddingAll(),
          const Spacer(),
          SizedBox(
            height: size.height * 0.4,
            child: PageView.builder(
              itemCount: totalOnboard,
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  _activeIndex = value;
                });
              },
              itemBuilder: (context, index) {
                return _buildOnBoard(context, index);
              },
            ),
          ),
          const Spacer(),
          PageIndicator(
            index: _activeIndex,
            length: totalOnboard,
          ),
          const Spacer(flex: 2),
          SizedBox(
            height: 55,
            child: GradientButton(
              text: (_activeIndex != totalOnboard - 1)
                  ? AppStrings.next
                  : AppStrings.getStarted,
              iconData: Icons.arrow_forward,
              onPressed: () {
                if (_activeIndex < totalOnboard - 1) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else if (_activeIndex == totalOnboard - 1) {
                  goMainPage();
                }
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ).defaultPaddingAll(),
    );
  }

  Widget _buildOnBoard(BuildContext context, int index) {
    final size = MediaQuery.sizeOf(context);
    const TextStyle titleStyle =
        TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: SvgPicture.asset(onBoardingList(context)[index].image),
        ),
        const Spacer(flex: 2),
        GradientText(
          onBoardingList(context)[index].title,
          style: titleStyle,
        ),
        const Spacer(),
        SizedBox(
          width: size.width / 1.2,
          child: Text(
            onBoardingList(context)[index].description,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
