import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/user_profile_pic.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/shimmer.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/formatters/formatters.dart';
import '../../../../utils/popups/loaders.dart';
import 'widgets/change_name_screen.dart';
import 'widgets/profile_details_menu.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Profile'.tr)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    // -- User Profile  Picture

                    Obx((){
                      final netWorkImage = controller.user.value.profilePicture;
                      final image = netWorkImage.isNotEmpty ? netWorkImage : TImages.banner4;
                      return controller.imageUploading.value
                          ?const  TShimmerEffect(width: 80, height: 80, radius: 80)
                          : UserProfilePic(height: 80, width: 80, image:image, isNetworkImage:netWorkImage.isNotEmpty);
          }),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: Text('Change Profile Picture'.tr)),
                  ],
                ),
              ),
              // -- Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              TCategoriesSectionHeading(
                  title: 'Profile Information'.tr, showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                  title: 'Name'.tr,
                  value: controller.user.value.fullName,
                  onTap: ()=> Get.to(()=> const ChangeNameScreen())),
              TProfileMenu(
                  title: 'Username'.tr,
                  value: controller.user.value.username,
                  onTap: () => Get.to(() => const ChangeUserNameScreen())),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Personal Info
              TCategoriesSectionHeading(
                  title: 'Personal Information'.tr, showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                  title: 'User ID'.tr,
                  icon: Iconsax.copy,
                  value: controller.user.value.id,
                  onTap: () {
                    Clipboard.setData(
                            ClipboardData(text: controller.user.value.id))
                        .then((_) {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //     content: Text("Email address copied to clipboard"))
                      //     );
                      TLoaders.customToast(
                          message: 'User ID copied to clipboard');
                    });
                  }),
              TProfileMenu(
                  title: 'E-mail'.tr,
                  value: controller.user.value.email,
                  onTap: () {}),
              TProfileMenu(
                  title: 'Phone Number'.tr,
                  value: controller.user.value.phoneNumber,
                  onTap: () {}),
              // todo : Localization and implement Date of Birth .
              // TProfileMenu(title: 'Gender', value: 'Male', onTap: () {}),
              // TProfileMenu(
              //     title: 'Date of Birth', value: '10 Oct, 1994', onTap: () {}),
              Obx(
                () => TProfileMenu(
                  title: 'Gender',
                  icon: Iconsax.arrow_swap_horizontal,
                  value: controller.user.value.gender.isEmpty
                      ? 'Not set'
                      : controller.user.value.gender,
                  onTap: () => controller.switchGender(),
                ),
              ),

              Obx(
                () => TProfileMenu(
                  title: 'Date of Birth',
                  value: controller.user.value.dateOfBirth != null
                      ? TFormatter.formatDate(
                          controller.user.value.dateOfBirth!)
                      : 'Not set',
                  onTap: () => controller.showDatePicker(),
                ),
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              Center(
                child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: Text(
                      'Close Account'.tr,
                      style: const TextStyle(color: Colors.red),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


