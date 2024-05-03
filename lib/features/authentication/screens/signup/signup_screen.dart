import 'package:ecommerce/features/authentication/screens/login/widgets/form_divider.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/social_buttons.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

import 'widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                TTexts.signUpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Form

              const SignUpForm(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              // Divider
              FormDivider(
                  isThemeMode: isDark, dividerText: TTexts.signUpDivider),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

