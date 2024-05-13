import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SingleAddressWidget extends StatelessWidget {
  final bool selectedAddress;
  const SingleAddressWidget({super.key, required this.selectedAddress});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
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
            Text('John Doe',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: TSizes.sm / 2),
            const Text('(+123) 456 7890',
                maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: TSizes.sm / 2),
            const Text('82356 Timmy Coves, South Liana, Hawaii, 87665, USA',
                softWrap: true),
          ],
        ),
      ]),
    );
  }
}
