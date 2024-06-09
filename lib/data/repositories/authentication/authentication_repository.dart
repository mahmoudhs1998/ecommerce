import 'package:ecommerce/common/widgets/exceptions/exceptions.dart';
import 'package:ecommerce/features/authentication/screens/login/login_screen.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:ecommerce/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce/zBottom_navigation_bar/navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utils/local_storage/storage_utility.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // variables

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Get Authenticated User Data 

  User? get currentAuthUser => _auth.currentUser;

  // called from main.dart on app launch

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // function to show relevant screen

  void screenRedirect() async {
    final user = _auth.currentUser;
    if (kDebugMode) {
      print('=========== Get Storage Auth Repo =============');
      print(deviceStorage.read('IsFirstTime'));
    }
    if (user != null) {
      // If the user is logged in
      if (user.emailVerified) {
        // Initialize User Specific Storage
        await TLocalStorage.init(user.uid);
        // If the user's email is verified, navigate to the main Navigation Menu
        Get.offAll(() => const NavigationMenu());
      } else {
        // If the user's email is not verified, navigate to the VerifyEmailScreen
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  /*----------------- Email & Password Sign In--------------------------------*/
/// [Email Authentication] Sign In
  Future<UserCredential> loginWithEmailAndPassword(String email, String password)async{
   try{
        return await _auth.signInWithEmailAndPassword(email: email, password: password);
   } on FirebaseAuthException catch (e) {
     throw TFirebaseAuthException(e.code).message;
   } on FirebaseException catch (e) {
     throw TFirebaseException(e.code).message;
   } on FormatException catch (e) {
     throw TFormatException();
   } on PlatformException catch (e) {
     throw TPlatformException(e.code).message;
   }catch(e){
     throw ' something went wrong';
   }
  }
/// [Email Authentication] Register

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' something went wrong';
    }
  }

//// [Email Verification] Mail Verification

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' something went wrong';
    }
  }

  //// [Email Verification - Reset Password] Forget Password

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' something went wrong';
    }
  }



  /// [GoogleAuthentication] - GO0GLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
// Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

// Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount
          ?.authentication;

// Create a new credential
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

// Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw  TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }


  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' something went wrong';
    }
  }


  /// [ReAuthenticate] - RE AUTHENTICATE USER
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
// Create a credential
      AuthCredential credential = EmailAuthProvider.credential(
          email: email, password: password);

// ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw  TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Delete Account] Delete User Account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserData(_auth.currentUser!.uid);
      await _auth.currentUser ?. delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        // Handle the case where the user must reauthenticate
        // Example: Prompt the user to reauthenticate and then try again
        throw 'User needs to reauthenticate. Please log in again.';
      } else {
        throw TFirebaseAuthException(e.code).message;
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }
}


