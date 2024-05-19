
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: TColors.dark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusMd),
          bottomRight:
              Radius.circular(TSizes.productImageRadius),
        ), // BorderRadius.only
      ), // BoxDecoration
      child: const SizedBox(
        width: TSizes.iconLg * 1.2,
        height: TSizes.iconLg * 1.2,
        child: Center(
            child: Icon(Icons.add, color: TColors.white)),
      ), // SizedBox
    );
  }
}
