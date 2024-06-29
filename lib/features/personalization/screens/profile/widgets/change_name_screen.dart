import 'package:ecommerce/features/personalization/controllers/update_name_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/app_bar.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/validators/validation.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Change Name'.tr,
            style: Theme.of(context).textTheme.headlineSmall),
      ), // TAppBar
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              'Use real name for easy verification. This name will appear on several pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ), // Text
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Text field and Button
            Form(
                key: controller.updateUserNameFormKey,
                child: Column(children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        TValidator.validateEmptyText('First Name'.tr, value),
                    expands: false,
                    decoration: InputDecoration(
                        labelText: TTexts.firstName.tr,
                        prefixIcon: const Icon(Iconsax.user)),
                  ), // TextFormField
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Last Name', value),
                    expands: false,
                    decoration: InputDecoration(
                        labelText: TTexts.lastName.tr,
                        prefixIcon: const Icon(Iconsax.user)),
                  ),
                ] // TextFormField

                    )), // Column, Form
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateUserName(),
                  child:  Text('Save'.tr)),
            ), //
          ],
        ),
      ),
    );
  }
}



class ChangeUserNameScreen extends StatelessWidget {
  const ChangeUserNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUserNameController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Change UserName'.tr,
            style: Theme.of(context).textTheme.headlineSmall),
      ), // TAppBar
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              'Use real name for easy verification. This name will appear on several pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ), // Text
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Text field and Button
            Form(
                key: controller.updateUserNameFormKey,
                child: Column(children: [
                  TextFormField(
                    controller: controller.userName,
                    validator: (value) =>
                        TValidator.validateEmptyText(TTexts.username.tr, value),
                    expands: false,
                    decoration: InputDecoration(
                        labelText: TTexts.username.tr,
                        prefixIcon: const Icon(Iconsax.user)),
                  ), // TextFormField
                
                ] // TextFormField

                    )), // Column, Form
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateUserName(),
                  child:  Text('Save'.tr)),
            ), //
          ],
        ),
      ),
    );
  }
}
