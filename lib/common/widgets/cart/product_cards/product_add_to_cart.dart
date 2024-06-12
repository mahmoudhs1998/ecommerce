import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/screens/product_details/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/controllers/cart/cart_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  final ProductModel product;

  const ProductCardAddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        // If the product have variations then show the product Details for variation selection.
        // ELse add product to the cart.
        if (product.productType == ProductType.single.toString()) {
          final cartItems = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItems);
        } else {
          Get.to(()=> ProductDetailsScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart= cartController.getProductQuantityInCart(product.id);

        return Container(
          decoration:  BoxDecoration(
            color: productQuantityInCart > 0 ? TColors.primaryColor : TColors.dark,
            borderRadius:const BorderRadius.only(
              topLeft: Radius.circular(TSizes.cardRadiusMd),
              bottomRight: Radius.circular(TSizes.productImageRadius),
            ), // BorderRadius.only
          ), // BoxDecoration
          child:  SizedBox(
            width: TSizes.iconLg * 1.2,
            height: TSizes.iconLg * 1.2,
            child: Center(
                child: productQuantityInCart > 0
                ?Text(productQuantityInCart.toString() , style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.white),)
                : const Icon(Icons.add, color: TColors.white)
            ),
          ), // SizedBox
        );
      }),
    );
  }
}
