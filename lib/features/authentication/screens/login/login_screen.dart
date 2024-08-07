import 'package:ecommerce/common/styles/spacing_styles.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/form_divider.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/login_form.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/login_header.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/social_buttons.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/fcm_services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isThemeMode = THelperFunctions.isDarkMode(context);
    Get.lazyPut(()=>FCMService());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // logo , title ,subtitle
              LoginHeaderWidget(isThemeMode: isThemeMode),
              // Form
              const LoginFormWidget(),

              // Divider
              FormDivider( dividerText: "Or Sign In With".tr, isThemeMode: isThemeMode),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              // Footer
              const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

