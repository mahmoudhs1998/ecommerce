import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'order_cart_widget.dart';

class TOrdersListItems extends StatelessWidget {
  const TOrdersListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (_, index) => const OrderCartWidget(),
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwItems),
        itemCount: 10);
  }
}
