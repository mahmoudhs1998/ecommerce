import 'package:ecommerce/features/authentication/controllers/login/login_controller.dart';
import 'package:ecommerce/features/authentication/screens/password_configurations/forget_password.dart';
import 'package:ecommerce/features/authentication/screens/signup/signup_screen.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            //Email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.direct_right),
                labelText: "E-Mail".tr,
                hintText: TTexts.email.tr,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            // Password
            Obx(
                  ()=> TextFormField(
                controller: controller.password,
                validator: (value) =>
                    TValidator.validateEmptyText('Password'.tr, value),
                        
                obscureText: controller.hidePassword.value,
                expands: false,
                decoration:  InputDecoration(
                  prefixIcon:const  Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: ()=>controller.hidePassword.value =
                    !controller.hidePassword.value,
                    icon:  Icon( controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                  ),
                  labelText: "Password".tr,
                  hintText: TTexts.password.tr,
                ),
              ),
            ),

            const SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),

            // remember me & forget password

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // remember me
                Row(
                  children: [
                    Obx(
                      ()=> Checkbox(value: controller.rememberMe.value, onChanged:
                      (value)=> controller.rememberMe.value = ! controller.rememberMe.value
                      ),
                    ),
                    Text(TTexts.rememberMe.tr),
                  ],
                ),
                //forget password

                TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword()),
                    child: Text(TTexts.forgetPassword.tr)),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            // sign in
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.signIn(),
                        // Get.to(() => const NavigationMenu()),
                    child: Text(TTexts.signIn.tr))),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            // create account
            SizedBox(
                width: double.infinity,
              child: OutlinedButton(
                child: Text(TTexts.createAccount.tr),
                onPressed: () => Get.to(
                  () => const SignUpScreen(),
                ),
              ),

            // SizedBox(
            //   height: TSizes.spaceBtwSections,
            // ),
            ),
          ],
        ),
      ),
    );
  }
}
