import 'package:ecommerce/common/network/network_connectivity.dart';
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../models/user_model.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  // variables

  final email = TextEditingController(); // controller for email address
  final password = TextEditingController(); // controller for password
  final hidePassword = true.obs; // toggle to hide password
  final privacyPolicy = true.obs; // toggle to check privacy policy
  final firstName = TextEditingController(); // controller for firstName Input
  final lastName = TextEditingController(); // controller for lastName Input
  final userName = TextEditingController(); // controller for userName Input
  final phoneNumber =
      TextEditingController(); // controller for phoneNumber Input
  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); // Form Key for Form Validation

// -- SignUp

  void signup() async {
    try {
      // start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information ... ', TImages.shopAnimation);
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.errorSnackBar(
            title: 'Please Accept Privacy Policy',
            message:
                'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use ...');
        return;
      }

      // Register User in The Firebase Authentication & Save User Data in Firebase

      final UserCredential userCredential =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      // Save Authenticated User Data in The Firebase Firestore
      final nemUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(nemUser);

      TFullScreenLoader.stopLoading();
      // Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue.');
      // Move to Verify Email Screen

      Get.to(() =>  VerifyEmailScreen(email: email.text.trim()));
      // Register User in The Firebase Authentication & Save User Data in Firebase
      // Save Authenticated User Data in The Firebase Firestore
      // Show Success Message
      // Move to Verify Email Screen
    } catch (e) {
      // Show Some Generic Error to User
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
    // finally {
    //   // Remove Loader
    //   TFullScreenLoader.stopLoading();
    // }
  }
}
