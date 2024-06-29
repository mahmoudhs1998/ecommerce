import 'package:ecommerce/utils/constants/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/network/network_connectivity.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/models/user_model.dart';
import '../../authentication/screens/login/login_screen.dart';
import '../screens/profile/widgets/reauth_user_login_form.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepository = Get.put(UserRepository());
  final profileLoading = false.obs;
  final imageUploading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();
  @override
  onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserData();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    }finally {
      profileLoading.value = false;
    }
  }

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh the user record
      await fetchUserRecord();
      // if no user record already exists
      if(user.value.id.isEmpty){
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameParts =
          UserModel.splitFullName(userCredentials.user!.displayName ?? "");
          final username =
          UserModel.generateUserName(userCredentials.user!.displayName ?? "");

          // Map Data
          final user = UserModel(
              id: userCredentials.user!.uid,
              firstName: nameParts[0],
              lastName:
              nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "",
              username: username,
              email: userCredentials.user!.email ?? "",
              phoneNumber: userCredentials.user!.phoneNumber ?? "",
              profilePicture: userCredentials.user!.photoURL ?? "");

          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }


    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              "Something went wrong while saving your information. You can re-save your data in your Profile.");
    }
  }


  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText:
      'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Delete')),
      ),
      // ElevatedButton
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ), // OutlinedButton
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.shopAnimation);

      /// First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.currentAuthUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
// Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    }catch (e) {
      TLoaders.warningSnackBar(
          title: 'Oh Snap!',
          message:e.toString());
    }
}

/// -- RE-AUTHENTICATE before deleting
 Future<void> reAuthenticateEmailAndPasswordUser() async {
   try {
     TFullScreenLoader.openLoadingDialog('Processing', TImages.shopAnimation);

     //Check Internet
     final isConnected = await NetworkManager.instance.isConnected();
     if (!isConnected) {
       TFullScreenLoader.stopLoading();
       return;
     }

     if (!reAuthFormKey. currentState !. validate()){
       TFullScreenLoader.stopLoading();
       return;
     }
     await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
     await AuthenticationRepository.instance.deleteAccount();
     TFullScreenLoader.stopLoading();
     Get.offAll(() => const LoginScreen());

   } catch (e) {
     TLoaders.warningSnackBar(
         title: 'Oh Snap!',
         message:e.toString());
   }
 }

 // upload profile image
 uploadUserProfilePicture()async{
    try{
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512
      );
      if(image != null){
        imageUploading.value = true;
        // Upload the image
        final imageUrl = await userRepository.uploadImage(Global.uploadProfileImage, image);

        // update user image record
        Map<String,dynamic> json = {Global.profilePictureKey: imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        TLoaders.successSnackBar(title: 'Congratulations' , message: 'Your Profile image has been Updated successfully');
      }
    }catch(e){
      TLoaders.errorSnackBar(title: 'OH snap!', message:'something went wrong $e');
    }finally{
      imageUploading.value = false;
    }
 }

  // Method to set date of birth
  Future<void> setDateOfBirth(DateTime dob) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Updating Date of Birth', TImages.shopAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return TLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message: 'Please check your internet connection and try again.');
      }

      // Update the user model
      user.update((val) {
        val?.dateOfBirth = dob;
      });

      // Prepare data for update
      Map<String, dynamic> json = {'dateOfBirth': dob.toIso8601String()};

      // Update in the database
      await userRepository.updateSingleField(json);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Success',
          message: 'Your date of birth has been updated successfully.');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Oh snap!',
          message: 'Something went wrong while updating date of birth: $e');
    }
  }

  void showDatePicker() async {
    final currentDate = DateTime.now();
    final selectedDate = await Get.dialog(
      DatePickerDialog(
        initialDate: user.value.dateOfBirth ?? DateTime(currentDate.year - 18),
        firstDate: DateTime(1900),
        lastDate:
            DateTime(currentDate.year - 13, currentDate.month, currentDate.day),
      ),
    );

    if (selectedDate != null && selectedDate is DateTime) {
      await setDateOfBirth(selectedDate);
    }
  }



   Future<void> switchGender() async {
    try {
      TFullScreenLoader.openLoadingDialog('Updating Gender', TImages.shopAnimation);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return TLoaders.errorSnackBar(title: 'No Internet Connection', message: 'Please check your internet connection and try again.');
      }

      // Switch the gender
      String newGender = user.value.gender == 'Male' ? 'Female' : 'Male';

      // Create a new UserModel with updated gender
      final updatedUser = UserModel(
        id: user.value.id,
        firstName: user.value.firstName,
        lastName: user.value.lastName,
        username: user.value.username,
        email: user.value.email,
        phoneNumber: user.value.phoneNumber,
        profilePicture: user.value.profilePicture,
        dateOfBirth: user.value.dateOfBirth,
        gender: newGender,
      );

      // Update the user model
      user.value = updatedUser;
      
      // Prepare data for update
      Map<String, dynamic> json = {'gender': newGender};
      
      // Update in the database
      await userRepository.updateSingleField(json);
      
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: 'Success', message: 'Your gender has been updated successfully.');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh snap!', message: 'Something went wrong while updating gender: $e');
    }
  }
}



