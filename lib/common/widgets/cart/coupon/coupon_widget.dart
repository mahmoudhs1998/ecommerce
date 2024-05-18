import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helpers_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';

class TCouponCode extends StatelessWidget {
  const TCouponCode({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
        final isDark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      showBorder: true,
      backgroundColor: isDark ? TColors.dark : TColors.white,
      padding: const EdgeInsets.only(
          top: TSizes.sm,
          bottom: TSizes.sm,
          left: TSizes.md,
          right: TSizes.sm),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a Promo Code? Enter Here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
    
          // -- Apply Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: isDark
                      ? TColors.white.withOpacity(0.5)
                      : TColors.black.withOpacity(0.5),
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  side:
                      BorderSide(color: Colors.grey.withOpacity(0.1)),
                ),
                onPressed: () {},
                child: const Text('Apply')),
          ),
        ],
      ),
    );
  }
}
