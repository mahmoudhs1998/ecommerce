import 'package:ecommerce/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce/features/authentication/screens/signup/widgets/terms_conditioons_widget.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        Row(children: [
          Expanded(
            child: TextFormField(
              expands: false,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.user),
                labelText: TTexts.firstName,
              ),
            ),
          ),
          const SizedBox(
            width: TSizes.spaceBtwInputFields,
          ),
          Expanded(
            child: TextFormField(
              expands: false,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.user),
                labelText: TTexts.lastName,
              ),
            ),
          ),
        ]),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        // Username
        TextFormField(
          expands: false,
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.user_edit),
            labelText: TTexts.username,
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        // Email
        TextFormField(
          expands: false,
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.direct),
            labelText: TTexts.email,
          ),
        ),
    
        // phone Number
    
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        // Email
        TextFormField(
          expands: false,
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.call),
            labelText: TTexts.phoneNo,
          ),
        ),
    
        // Password
    
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        // Email
        TextFormField(
          obscureText: true,
          expands: false,
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.password_check),
            suffixIcon: Icon(Iconsax.eye_slash),
            labelText: TTexts.password,
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
    
        // Terms & Conditions
    
        const TermsAndConditionsWidget(),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
    
        // sign up button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.to(() => const VerifyEmailScreen()),
            child: const Text(TTexts.createAccount),
          ),
        ),
      ]),
    );
  }
}

