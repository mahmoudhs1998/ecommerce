import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/signup/signup_controller.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
        final isDark = THelperFunctions.isDarkMode(context);

    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            ()=> Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value,
            ),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: '${TTexts.isAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: '${TTexts.privacyPolicy} ',
                style:
                    Theme.of(context).textTheme.bodyMedium!.apply(
                          color: isDark
                              ? TColors.white
                              : TColors.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: isDark
                              ? TColors.white
                              : TColors.primaryColor,
                        ),
              ), // TextSpan
              TextSpan(
                  text: '${TTexts.and} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: TTexts.termsOfUse,
                style:
                    Theme.of(context).textTheme.bodyMedium!.apply(
                          color: isDark
                              ? TColors.white
                              : TColors.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: isDark
                              ? TColors.white
                              : TColors.primaryColor,
                        ),
              ), // TextSpan
            ],
          ),
        ),
      ],
    );
  }
}
