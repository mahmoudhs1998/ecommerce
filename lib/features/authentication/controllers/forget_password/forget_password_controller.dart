 import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/features/authentication/screens/password_configurations/reset_password.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/network/network_connectivity.dart';



class ForgetPasswordController {
  static ForgetPasswordController get instance =>Get.find();


  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password EMail
  sendPasswordResetEmail() async {
    try {
      // Start the Loading
      TFullScreenLoader.openLoadingDialog('Processing your Request.....', TImages.shopAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        // Stop the Loading
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());
      // Stop the Loading
      TFullScreenLoader.stopLoading();

      // Show Success Screen
      TLoaders.successSnackBar(title: 'Email Sent' , message: 'Email Link Sent to Reset Password'.tr);

      // Redirect
      Get.to(() => ResetPasswordScreen(email:email.text.trim()));
     }
    catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OH Snap!',message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      // Start the Loading
      TFullScreenLoader.openLoadingDialog('Processing your Request.....', TImages.shopAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }


      await AuthenticationRepository.instance.sendPasswordResetEmail(email);
      // Stop the Loading
      TFullScreenLoader.stopLoading();

      // Show Success Screen
      TLoaders.successSnackBar(title: 'Email Sent' , message: 'Email Link Sent to Reset Password'.tr);

    }
    catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OH Snap!',message: e.toString());
    }
  }
}
