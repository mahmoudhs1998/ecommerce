import 'package:ecommerce/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboardin_page.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboarding_navigate.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboarding_next_btn.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboarding_skip_btn.dart';
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
          children: [
            OnBoardingPage(
              image: TImages.onBoarding1,
              title: TTexts.onBoardingTitle1.tr,
              subTitle: TTexts.onBoardingSubTitle1.tr,
            ),
            OnBoardingPage(
              image: TImages.onBoarding2,
              title: TTexts.onBoardingTitle2.tr,
              subTitle: TTexts.onBoardingSubTitle2.tr,
            ),
             OnBoardingPage(
              image: TImages.onBoarding3,
              title: TTexts.onBoardingTitle3.tr,
              subTitle: TTexts.onBoardingSubTitle3.tr,
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
