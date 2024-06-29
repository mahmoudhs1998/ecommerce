import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsOfUseController extends GetxController {
  static TermsOfUseController get instance => Get.find();
  void showTermsOfUse() {
    Get.defaultDialog(
      title: 'Terms of Use'.tr,
      content: SingleChildScrollView(
        child: Text(
          'Here are the terms of use for our application...'
              .tr, // Replace this with the actual terms or localized terms
          textAlign: TextAlign.justify,
        ),
      ),
      textConfirm: 'Accept'.tr,
      textCancel: 'Decline'.tr,
      onConfirm: () {
        Get.back(); // Close the dialog and take any action if necessary
      },
      onCancel: () {
        Get.back();
        showWarningMessage();
      },
    );
  }

  void showWarningMessage() {
    Get.defaultDialog(
      title: 'Warning'.tr,
      content: Text(
          'You must accept the terms of use and privacy policy to continue.'
              .tr),
      textConfirm: 'OK'.tr,
      onConfirm: () {
        Get.back(); // Close the warning dialog
      },
    );
  }
}

class PrivacyPolicyController extends GetxController {
    static PrivacyPolicyController get instance => Get.find();

  void showPrivacyPolicy() {
    Get.defaultDialog(
      title: 'Privacy Policy'.tr,
      content: SingleChildScrollView(
        child: Text(
          'Here is the privacy policy for our application...'
              .tr, // Replace this with the actual privacy policy or localized terms
          textAlign: TextAlign.justify,
        ),
      ),
      textConfirm: 'Accept'.tr,
      textCancel: 'Decline'.tr,
      onConfirm: () {
        Get.back(); // Close the dialog and take any action if necessary
      },
      onCancel: () {
        Get.back();
        showWarningMessage();
      },
    );
  }

  void showWarningMessage() {
    Get.defaultDialog(
      title: 'Warning'.tr,
      content: Text(
          'You must accept the terms of use and privacy policy to continue.'
              .tr),
      textConfirm: 'OK'.tr,
      onConfirm: () {
        Get.back(); // Close the warning dialog
      },
    );
  }
}
