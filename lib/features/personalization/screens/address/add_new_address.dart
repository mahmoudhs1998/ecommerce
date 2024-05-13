import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/form fields/rounded_text_field.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const TAppBar(showBackArrow: true, title: Text('Add new Address')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                const CustomFormField(
                  labelText: 'Name',
                  prefixIcon: Iconsax.user,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                const CustomFormField(
                  labelText: ' Phone Number',
                  prefixIcon: Iconsax.mobile,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                const Row(children: [
                  Expanded(
                    child: CustomFormField(
                        labelText: "Street", prefixIcon: Iconsax.building_31),
                  ),
                  SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: CustomFormField(
                        labelText: "Postal Code", prefixIcon: Iconsax.code),
                  ),
                ]),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                const Row(children: [
                  Expanded(
                    child: CustomFormField(
                        labelText: "City", prefixIcon: Iconsax.building),
                  ),
                  SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: CustomFormField(
                        labelText: "State", prefixIcon: Iconsax.activity),
                  ),
                ]),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                const CustomFormField(
                  labelText: 'Country',
                  prefixIcon: Iconsax.global,
                ),
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text('Save')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
