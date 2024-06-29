import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/signup/verify_email_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  final String? email;

  const VerifyEmailScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () =>AuthenticationRepository.instance.logout(),
                // Get.offAll(() => const LoginScreen()),
            icon: const Icon(Icons.clear),
          )
        ],
      ),
      body: SingleChildScrollView(
        // Padding to Give Default Equal Space on all sides in all screens.
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(children: [
            /// Image
            Image(
              image: const AssetImage(TImages.verifyEmail3),
              width: THelperFunctions.screenWidth(context) * 0.6,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Title & SubTitle
            Text(
              TTexts.confirmEmail,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              email ?? '',
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              TTexts.confirmEmailSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.checkEmailVerificationStatus(),
                child: const Text(TTexts.continues),

                // Get.to(() => SuccessScreen(
                //   image: TImages.success,
                //   title: TTexts.emailSuccess,
                //   subTitle: TTexts.successEmailSubTitle,
                //   onPressed: () => Get.to(() => const LoginScreen()),
                // )
              ),
            ),

            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => controller.sendEmailVerification(),
                //     Get.to(() => const ResetPassword()
                // ),
                child:  Text(TTexts.resendEmail),
              ),
            ),
          ]), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
