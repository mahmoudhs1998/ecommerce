import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/form fields/rounded_text_field.dart';
import '../../controllers/address_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Scaffold(
      appBar:
          const TAppBar(showBackArrow: true, title: Text('Add new Address')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key : addressController.addressFormKey,
            child: Column(
              children: [
                 CustomFormField(
                   controller: addressController.name,
                  labelText: 'Name',
                  validator: (value)=>TValidator.validateEmptyText('Name', value),
                  prefixIcon: Iconsax.user,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                 CustomFormField(
                  controller: addressController.phoneNumber,
                  validator: TValidator.validatePhoneNumber,
                  labelText: ' Phone Number',
                  prefixIcon: Iconsax.mobile,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                 Row(children: [
                  Expanded(
                    child: CustomFormField(
                      controller: addressController.street,
                        validator:(value)=> TValidator.validateEmptyText('Street', addressController.street.text),
                        labelText: "Street", prefixIcon: Iconsax.building_31),
                  ),
                 const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: CustomFormField(
                      controller: addressController.postalCode,
                      validator: (value)=> TValidator.validateEmptyText('Postal Code', addressController.postalCode.text),

                        labelText: "Postal Code", prefixIcon: Iconsax.code),
                  ),
                ]),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                 Row(children: [
                  Expanded(
                    child: CustomFormField(
                      controller: addressController.city,
                      validator: (value)=> TValidator.validateEmptyText('City', addressController.city.text),

                        labelText: "City", prefixIcon: Iconsax.building),
                  ),
                  const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: CustomFormField(
                      controller: addressController.state,
                      validator: (value)=> TValidator.validateEmptyText('State', addressController.state.text),
                        labelText: "State", prefixIcon: Iconsax.activity),
                  ),
                ]),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                 CustomFormField(
                   controller: addressController.country,
                  validator: (value)=> TValidator.validateEmptyText('Country', addressController.country.text),
                  labelText: 'Country',
                  prefixIcon: Iconsax.global,
                ),
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => addressController.addNewAddress(), child: const Text('Save')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
