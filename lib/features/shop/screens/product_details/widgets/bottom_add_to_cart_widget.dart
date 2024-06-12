import 'package:ecommerce/common/widgets/icons/custom_circular_icon.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers/cart/cart_controller.dart';
import '../../../models/product_model.dart';

class TBottomAddToCart extends StatelessWidget {
  final ProductModel product;
  const TBottomAddToCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    cartController.updateAlreadyAddedProductCount(product);
    final isDark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: isDark ? TColors.darkGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Obx(
            ()=> Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Row(
                children: [
                   TCircularIcon(
                    icon: Iconsax.minus,
                    backgroundColor: TColors.grey,
                    width: 40,
                    height: 40,
                    color: TColors.white,
                     onPressed: ()=> cartController.productQuantityInCart.value < 1 ? null : cartController.productQuantityInCart.value -=1,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Text(cartController.productQuantityInCart.value.toString(), style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(width: TSizes.spaceBtwItems),
                   TCircularIcon(
                    icon: Iconsax.add,
                    backgroundColor: TColors.black,
                    width: 40,
                    height: 40,
                    color: TColors.white,
                     onPressed: ()=> cartController.productQuantityInCart.value +=1,
                  ),
                ],
              ),

            ElevatedButton(
                onPressed: () => cartController.productQuantityInCart.value < 1 ? null :() =>  cartController.addToCart(product),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: TColors.black,
                  side: const BorderSide(color: TColors.black),
                ),
                child: const Text('Add to Cart')),
          ],
        ),
      ),
    );
  }
}
