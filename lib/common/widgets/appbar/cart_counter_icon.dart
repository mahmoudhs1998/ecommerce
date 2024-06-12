import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/shop/controllers/cart/cart_controller.dart';
import '../../../features/shop/screens/cart/cart.dart';

class TCartCounterIcon extends StatelessWidget {

  final Color? iconColor, counterBgColor, counterTextColor;
  const TCartCounterIcon({
    super.key,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
  });

  @override
  Widget build(BuildContext context) {
    // get an instance of the Cart Controller
    final cartController = Get.put(CartController());
    final isDark = THelperFunctions.isDarkMode(context);
    return Stack(children: [
      IconButton(onPressed: () => Get.to(() => const CartScreen()), icon: Icon(Iconsax.shopping_bag, color: iconColor)),
      Positioned(
        right: 0,
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: counterBgColor ?? (isDark ? TColors.white : TColors.black),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Obx(
              ()=> Text(
                cartController.noOfCartItems.value.toString(),
                style: Theme.of(context).textTheme.labelSmall!.apply(
                    color: counterTextColor ??( isDark ? TColors.black : TColors.white),
                    fontSizeFactor: 0.8),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
