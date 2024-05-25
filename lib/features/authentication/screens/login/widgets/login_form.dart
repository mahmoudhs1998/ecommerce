import 'package:ecommerce/features/authentication/controllers/login/login_controller.dart';
import 'package:ecommerce/features/authentication/screens/password_configurations/forget_password.dart';
import 'package:ecommerce/features/authentication/screens/signup/signup_screen.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:ecommerce/zBottom_navigation_bar/navigation_menu.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
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
              validator: (value)=>TValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            // Password
            Obx(
                  ()=> TextFormField(
                controller: controller.password,
                validator:(value) =>  TValidator.validateEmptyText('Password',value),
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
                    const Text(TTexts.rememberMe),
                  ],
                ),
                //forget password

                TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword()),
                    child: const Text(TTexts.forgetPassword)),
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
                    child: const Text(TTexts.signIn))),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            // create account
            SizedBox(
                width: double.infinity,
              child: OutlinedButton(
                child: const Text(TTexts.createAccount),
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
