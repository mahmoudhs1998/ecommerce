// Utility class for managing a full-screen loading dialog.
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/device/device_utility.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders/animation_loader.dart';

class TFullScreenLoader {
  // This method doesn't do anything.
  /// Open a full-screen loading dialog with a given text and animation.
  /// This method doesn't return anything.

  /// Parameters:
  ///- text: The text to be displayed in the loading dialog.
  ///    . animation: The Lottie animation to be shown.
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context:
          Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
      barrierDismissible: false, // Dialog won't dismiss on tapping outside
      builder: (BuildContext context) {
        return PopScope(
          canPop: false, // Disable back button
          child: Container(
            color: THelperFunctions.isDarkMode(Get.context!)
                ? TColors.dark
                : TColors.white, // Background color with opacity
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                 const SizedBox(height: 200),// Adjust the spacing as needed
                TAnimationLoaderWidget(text: text, animation: animation),
              ],
            ),
          ),
        );
      },
    );
  }
  /// Stop the currently open loading dialog.
  /// This method doesn't return anything.
  static stopLoading() {
    Navigator.of(Get.overlayContext!)
        .pop(); // Close the dialog using the Navigator
  }
}
