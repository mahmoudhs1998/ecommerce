import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'locale_controller.dart';

class LanguageSwitchDialog extends StatelessWidget {
  const LanguageSwitchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleController localeController = LocaleController.instance;

    return AlertDialog(
      title: Text('Switch Language'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              localeController.changeLanguage(english);
              Get.back();
            },
            child: Text('English'.tr),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          ElevatedButton(
            onPressed: () {
              localeController.changeLanguage(arabic);
              Get.back();
            },
            child: Text('Arabic'.tr),
          ),
        ],
      ),
    );
  }
}
