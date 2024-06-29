import 'package:ecommerce/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:ecommerce/features/authentication/screens/login/login_screen.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, actions: [
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.clear),
        ),
      ]),
      body: SingleChildScrollView(
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

            // Email
            Text(email, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),


            /// Title & SubTitle
            Text(
              TTexts.changePasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            Text(
              TTexts.changePasswordSubTitle,
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
                onPressed: ()=> Get.offAll(()=>const LoginScreen()),
                child: const Text(TTexts.done),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            /// Buttons
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: ()=> ForgetPasswordController.instance.resendPasswordResetEmail(email),
                child:  Text(TTexts.resendEmail),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
