// import 'package:ecommerce/utils/constants/colors.dart';
// import 'package:ecommerce/utils/constants/sizes.dart';
// import 'package:ecommerce/utils/constants/texts.dart';
// import 'package:ecommerce/utils/helpers/helpers_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../controllers/signup/signup_controller.dart';
// import '../../../controllers/termsofuse_and_privacy/termsofuse_and_privacy.dart';

// class TermsAndConditionsWidget extends StatelessWidget {
//   const TermsAndConditionsWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller = SignupController.instance;
//     final termsOfUseController = Get.put(TermsOfUseController());
//      final privacyController = Get.put(PrivacyPolicyController());
//     final isDark = THelperFunctions.isDarkMode(context);

//     return Row(
//       children: [
//         SizedBox(
//           width: 24,
//           height: 24,
//           child: Obx(
//             () => Checkbox(
//               value: controller.privacyPolicy.value,
//               onChanged: (value) => controller.privacyPolicy.value =
//                   !controller.privacyPolicy.value,
//             ),
//           ),
//         ),
//         const SizedBox(width: TSizes.spaceBtwItems),
//         Text.rich(
//           TextSpan(
//             children: [
//               TextSpan(
//                   text: '${TTexts.isAgreeTo} ',
//                   style: Theme.of(context).textTheme.bodySmall),

//               TextSpan(
//                 text: '${TTexts.privacyPolicy} ',
//                 style: Theme.of(context).textTheme.bodyMedium!.apply(
//                       color: isDark ? TColors.white : TColors.primaryColor,
//                       decoration: TextDecoration.underline,
//                       decorationColor:
//                           isDark ? TColors.white : TColors.primaryColor,
//                     ),
//               ), // TextSpan
//               TextSpan(
//                   text: '${TTexts.and} ',
//                   style: Theme.of(context).textTheme.bodySmall),
//               TextSpan(
//                 text: TTexts.termsOfUse,
//                 style: Theme.of(context).textTheme.bodyMedium!.apply(
//                       color: isDark ? TColors.white : TColors.primaryColor,
//                       decoration: TextDecoration.underline,
//                       decorationColor:
//                           isDark ? TColors.white : TColors.primaryColor,
//                     ),
//               ), // TextSpan
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/texts.dart';
import '../../../controllers/signup/signup_controller.dart';
import '../../../controllers/termsofuse_and_privacy/termsofuse_and_privacy.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final termsOfUseController = Get.put(TermsOfUseController());
    final privacyController = Get.put(PrivacyPolicyController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    TapGestureRecognizer privacyPolicyRecognizer = TapGestureRecognizer()
      ..onTap = () {
        privacyController.showPrivacyPolicy();
      };

    TapGestureRecognizer termsOfUseRecognizer = TapGestureRecognizer()
      ..onTap = () {
        termsOfUseController.showTermsOfUse();
      };

    return Row(
      children: [
        Obx(
          () => Wrap(
            children: [
              Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.privacyPolicy.value = value;
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 4.0), // TSizes.spaceBtwItems
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '${TTexts.isAgreeTo.tr} ',
                    style: Theme.of(context).textTheme.labelSmall),
                TextSpan(
                  text: '${TTexts.privacyPolicy.tr} ',
                  style: Theme.of(context).textTheme.labelSmall!.apply(
                        color: isDark ? Colors.white : Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: isDark ? Colors.white : Colors.blue,
                      ),
                  recognizer: privacyPolicyRecognizer,
                ),
          
                TextSpan(
                    text: '${TTexts.and.tr} ',
                    style: Theme.of(context).textTheme.labelSmall),
                TextSpan(
                  text: TTexts.termsOfUse.tr,
                  style: Theme.of(context).textTheme.labelSmall!.apply(
                        color: isDark ? Colors.white : Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: isDark ? Colors.white : Colors.blue,
                      ),
                  recognizer: termsOfUseRecognizer,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
