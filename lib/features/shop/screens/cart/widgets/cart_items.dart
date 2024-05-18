import 'package:flutter/material.dart';

import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import 'add_remove_btns.dart';
import 'cart_item.dart';

class TCartItems extends StatelessWidget {
  final bool showAddRemoveButtons;
  const TCartItems({super.key, this.showAddRemoveButtons = true});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 4,
      separatorBuilder: (_, __) =>
          const SizedBox(height: TSizes.spaceBtwSections),
      itemBuilder: (_, __) => Column(children: [
        // -- Cart Item
        const TCartItem(),
        if (showAddRemoveButtons) const SizedBox(height: TSizes.spaceBtwItems),

        // -- Add or remove to cart button

        if (showAddRemoveButtons)
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 70),
                  TProductQuantityWithAddRemoveButton(),
                ],
              ),

              // -- Product Total Price
              TProductPriceText(price: '250'),
            ],
          ),
      ]),
    );
  }
}
