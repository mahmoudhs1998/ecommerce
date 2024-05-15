import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/features/shop/screens/cart/cart.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(TTexts.homeAppBarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: TColors.grey)),
        Text(TTexts.homeAppBarTitle,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: TColors.grey)),
      ]),
      actions: [
        // Todo : Replace with TCartCounterIcon
        Stack(children: [
          IconButton(
            onPressed: () => Get.to(() => const CartScreen()),
            icon: const Icon(Iconsax.shopping_bag, color: TColors.white),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: TColors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  '2',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .apply(color: TColors.white, fontSizeFactor: 0.8),
                ),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
