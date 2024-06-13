import 'package:ecommerce/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/cart/cart_controller.dart';

class BillingAmountSection extends StatelessWidget {
const BillingAmountSection({ super.key });

  @override
   Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(children: [
      // -- Sub total
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
        Text('\$$subTotal', style: Theme.of(context).textTheme.bodyMedium),
      ]),
      const SizedBox(height: TSizes.spaceBtwItems / 2),

      // -- Shipping Fee

      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
        Text('\$${TPricingCalculator.calculateShippingCost(subTotal, 'US')}', style: Theme.of(context).textTheme.labelLarge),
      ]),
      const SizedBox(height: TSizes.spaceBtwItems / 2),

      // -- Tax Fee

      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
        Text('\$${TPricingCalculator.calculateTax(subTotal, 'US')}', style: Theme.of(context).textTheme.labelLarge),
      ]),
      const SizedBox(height: TSizes.spaceBtwItems / 2),

      // -- Order Total

      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
        Text('\$${TPricingCalculator.calculateTotalPrice(subTotal, 'US')}', style: Theme.of(context).textTheme.titleMedium),
      ]),
    ]);
  }
}