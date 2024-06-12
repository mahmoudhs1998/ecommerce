import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/icons/custom_circular_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helpers_functions.dart';

// --  Product Quantity With Add Remove Buttons

 

class TProductQuantityWithAddRemoveButton extends StatelessWidget {
  final int quantity;
  final VoidCallback? add,remove;
  const TProductQuantityWithAddRemoveButton({
    super.key, required this.quantity, this.add, this.remove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      TCircularIcon(
        icon: Iconsax.minus,
        width: 32,
        height: 32,
        size: TSizes.md,
        color: THelperFunctions.isDarkMode(context)
            ? TColors.white
            : TColors.black,
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkGrey
            : TColors.light,
        onPressed: remove,
      ),
      const SizedBox(width: TSizes.spaceBtwItems),
      Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
      const SizedBox(width: TSizes.spaceBtwItems),
        TCircularIcon(
        icon: Iconsax.add,
        width: 32,
        height: 32,
        size: TSizes.md,
        color: TColors.white,
        backgroundColor: TColors.primaryColor,
        onPressed: add,
      ),
    ]);
  }
}
