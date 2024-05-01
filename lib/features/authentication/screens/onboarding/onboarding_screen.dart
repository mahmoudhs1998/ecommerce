import 'package:ecommerce/features/authentication/controllers/onboarding_controller.dart';
import 'package:ecommerce/features/authentication/widgets/onboarding_widgets/onboardin_page.dart';
import 'package:ecommerce/features/authentication/widgets/onboarding_widgets/onboarding_navigate.dart';
import 'package:ecommerce/features/authentication/widgets/onboarding_widgets/onboarding_next_btn.dart';
import 'package:ecommerce/features/authentication/widgets/onboarding_widgets/onboarding_skip_btn.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(children: [
        // horizontal scrollable pages
        PageView(
          controller: controller.pageController,
          onPageChanged: controller.updatePageIndicator,
          children: const [
            OnBoardingPage(
              image: TImages.onBoarding1,
              title: TTexts.onBoardingTitle1,
              subTitle: TTexts.onBoardingSubTitle1,
            ),
            OnBoardingPage(
              image: TImages.onBoarding2,
              title: TTexts.onBoardingTitle2,
              subTitle: TTexts.onBoardingSubTitle2,
            ),
            OnBoardingPage(
              image: TImages.onBoarding3,
              title: TTexts.onBoardingTitle3,
              subTitle: TTexts.onBoardingSubTitle3,
            ),
          ],
        ),

        //skip button
        const OnBoardingSkip(),

        //dot navigation smoothPageIndicator
        const OnBoardingNavigation(),
        //circular button
        const OnBoardingNextButton(),
      ]),
    );
  }
}
