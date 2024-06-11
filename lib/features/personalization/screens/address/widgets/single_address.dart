import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce/features/personalization/models/address_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SingleAddressWidget extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onTap;

  //final bool selectedAddress;
  const SingleAddressWidget(
      {super.key, required this.address, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    final isDark = THelperFunctions.isDarkMode(context);
    return Obx(() {
      final  selectedAddressID = addressController.selectedAddress.value.id;
      final  selectedAddress = selectedAddressID == address.id;
      return InkWell(
        onTap: onTap,
        child: TRoundedContainer(
          width: double.infinity,
          showBorder: true,
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: selectedAddress
              ? TColors.primaryColor.withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : isDark
              ? TColors.darkGrey
              : TColors.grey,
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
          child: Stack(children: [
            Positioned(
              right: 0,
              top: 0,
              child: Icon(
                selectedAddress ? Iconsax.tick_circle5 : null,
                color: selectedAddress
                    ? isDark
                    ? TColors.light
                    : TColors.dark
                    : null,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge),
                const SizedBox(height: TSizes.sm / 2),
                 Text(address.phoneNumber,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: TSizes.sm / 2),
                 Text(address.toString(),
                    softWrap: true),
              ],
            ),
          ]),
        ),
      );
    });
  }
}
