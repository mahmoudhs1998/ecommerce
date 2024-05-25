import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../common/network/network_connectivity.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/images.dart';

class LoginController extends GetxController
{
  static  LoginController get instance => Get.find();

  /// variables
  final email = TextEditingController();
  final password = TextEditingController();
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL');
    password.text = localStorage.read('REMEMBER_ME_PASSWORD');
    super.onInit();
  }

  /// Sign In Method
  Future<void> signIn() async{
    try {
      // start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in ... ', TImages.shopAnimation);
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      // Login user using EMail & Password Authentication
      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // remove loader
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();

    }catch (e){
      // remove loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OH Snap!' , message: e.toString());
    }
  }


}