import 'package:ecommerce/features/authentication/controllers/signup/signup_controller.dart';
import 'package:ecommerce/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce/features/authentication/screens/signup/widgets/terms_conditioons_widget.dart';
import 'package:ecommerce/utils/constants/globals.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(children: [
        Row(children: [
          Expanded(
            child: TextFormField(
              controller: controller.firstName,
              validator:(value) =>  TValidator.validateEmptyText(Global.firstName, value),
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
              controller: controller.lastName,
              validator:(value) =>  TValidator.validateEmptyText(Global.lastName, value),
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
          controller: controller.userName,
          validator:(value) =>  TValidator.validateEmptyText(Global.userName, value),
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
          controller: controller.email,
          validator:(value) =>  TValidator.validateEmail(value),
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
          controller: controller.phoneNumber,
          validator:(value) =>  TValidator.validatePhoneNumber(value),
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
        Obx(
          ()=> TextFormField(
            controller: controller.password,
            validator:(value) =>  TValidator.validatePassword(value),
            obscureText: controller.hidePassword.value,
            expands: false,
            decoration:  InputDecoration(
              prefixIcon:const  Icon(Iconsax.password_check),
              suffixIcon: IconButton(
                  onPressed: ()=>controller.hidePassword.value =
                  !controller.hidePassword.value,
                  icon:  Icon( controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
              ),
              labelText: TTexts.password,
            ),
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
            onPressed: () => controller.signup(),
    child: const Text(TTexts.createAccount),
                // Get.to(() => const VerifyEmailScreen()
                 ),

          ),

      ]),
    );
  }
}

