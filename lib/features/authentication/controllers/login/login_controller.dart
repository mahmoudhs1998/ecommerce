import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../common/network/network_connectivity.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../services/fcm_services.dart';
import '../../../../utils/constants/images.dart';
import '../../../personalization/controllers/user_controller.dart';

// class LoginController extends GetxController
// {
//   static  LoginController get instance => Get.find();
//
//   /// variables
//   final email = TextEditingController();
//   final password = TextEditingController();
//   final rememberMe = false.obs;
//   final hidePassword = true.obs;
//   final localStorage = GetStorage();
//   GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
//   final userController = Get.put(UserController());
//
//
//   @override
//   void onInit() {
//    // email.text = localStorage.read('REMEMBER_ME_EMAIL');
//     //password.text = localStorage.read('REMEMBER_ME_PASSWORD');
//     super.onInit();
//   }
//
//   /// Sign In Method
//   Future<void> signIn() async{
//     try {
//       // start Loading
//       TFullScreenLoader.openLoadingDialog(
//           'Logging you in ... ', TImages.shopAnimation);
//       // Check Internet Connectivity
//       final isConnected = await NetworkManager.instance.isConnected();
//       if (!isConnected) {
//         TFullScreenLoader.stopLoading();
//         return;
//       }
//       // Form Validation
//       if (!loginFormKey.currentState!.validate()) {
//         TFullScreenLoader.stopLoading();
//         return;
//       }
//       // Save Data if Remember Me is selected
//       if (rememberMe.value) {
//         localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
//         localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
//       }
//       // Login user using EMail & Password Authentication
//       final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
//       // Save User Record
//
//       await userController.saveUserRecord(userCredentials);
//
//
//       // remove loader
//       TFullScreenLoader.stopLoading();
//
//       // Redirect
//       AuthenticationRepository.instance.screenRedirect();
//
//     }catch (e){
//       // remove loader
//       TFullScreenLoader.stopLoading();
//       TLoaders.errorSnackBar(title: 'OH Snap!' , message: e.toString());
//     }
//   }
//
//   // Google SignIn Authentication
//   Future<void> googleSignIn() async {
//     try {
//       // Start Loading
//       TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.shopAnimation);
//       // Check Internet Connectivity
//       final isConnected = await NetworkManager.instance.isConnected();
//       if (!isConnected) {
//         TFullScreenLoader.stopLoading();
//         return;
//       }
//       // Google Authentication
//       final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();
//
//       // Save User Record
//
//       await userController.saveUserRecord(userCredentials);
//
//       // Remove Loader
//       TFullScreenLoader.stopLoading();
//
//       // Redirect
//       AuthenticationRepository.instance.screenRedirect();
//
//     } catch (e) {
//       // Remove Loader
//       TFullScreenLoader.stopLoading();
//
//       TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
//     }
//   }
//
//
//
// }



class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());
  final FCMService _fcmService = Get.find<FCMService>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> signIn() async {
    try {
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.shopAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      await userController.saveUserRecord(userCredentials);

      // Subscribe to FCM topic after successful sign-in
      await _fcmService.subscribeToTopic('user_notifications');

      // Display a notification
      LocalNotificationService.displayLocalNotification(
        title: "Welcome",
        body: "You have successfully logged in.",
      );

      TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.shopAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();
      await userController.saveUserRecord(userCredentials);

      // Subscribe to FCM topic after successful Google sign-in
      await _fcmService.subscribeToTopic('user_notifications');

      // Display a notification
      LocalNotificationService.displayLocalNotification(
        title: "Welcome",
        body: "You have successfully logged in with Google.",
      );

      TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
