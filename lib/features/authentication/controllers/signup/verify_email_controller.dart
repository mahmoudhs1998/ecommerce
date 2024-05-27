import 'dart:async';

import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';

class VerifyEmailController extends GetxController
{
  static VerifyEmailController get instance => Get.find();
  /// send email whenever verify screen appears & set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// send email verification Link
  sendEmailVerification()async{
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(title: 'Email Sent', message: 'Please Check your Inbox and Verify your Email');

    }catch(e) {
      TLoaders.errorSnackBar(title: 'Error Snap!', message: e.toString());
    }
  }


/// Timer to automatically redirect when verify screen appears
setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async{
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if(user?.emailVerified ?? false){
        timer.cancel();
        Get.off(() => SuccessScreen(
          title:'Email Verified',
          subTitle: 'Your account has been successfully Verified' ,
          image:TImages.success ,
          onPressed:()=>AuthenticationRepository.instance.screenRedirect(),
        ));
      }
    });
}
/// Manually check if email is verified
  checkEmailVerificationStatus() async{
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified){
      Get.off(() => SuccessScreen(
        title:'Email Verified',
        subTitle: 'Your account has been successfully Verified' ,
        image:TImages.success ,
        onPressed:()=>AuthenticationRepository.instance.screenRedirect(),
      ));
    }
  }
}