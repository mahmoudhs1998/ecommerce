import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Re-Authenticate User'),),
      body: SingleChildScrollView(
        child: Padding(
          padding : const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  // Email
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: TValidator.validateEmail,
                  decoration: InputDecoration(
                    labelText: "E-Mail",
                    hintText: TTexts.email,
                    prefixIcon: const Icon(Iconsax.direct_right),
                    ),

                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

              /// Password
               Obx(
              () => TextFormField(
          obscureText: controller.hidePassword.value,
          controller: controller.verifyPassword,
          validator: (value) => TValidator.validateEmptyText('Password', value),
          decoration: InputDecoration(
            labelText: TTexts.password,
            prefixIcon: const Icon(Iconsax.password_check),
            suffixIcon: IconButton(
                onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                icon: const Icon(Iconsax.eye_slash),
          ), // IconButton
        ), // InputDecoration
      ), // TextFormField
    ), // 0bx
    const SizedBox(height: TSizes.spaceBtwSections),

                  // Re Log in button

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.reAuthFormKey.currentState!.validate()) {
                          controller.reAuthFormKey.currentState!.save();
                          await controller.reAuthenticateEmailAndPasswordUser();
                          // Get.offAndToNamed(AppRoutes.home);
                        }
                      },
                      child: const Text('Verify'),
                    ),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
