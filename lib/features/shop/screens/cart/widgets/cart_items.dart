import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/cart/cart_controller.dart';
import 'add_remove_btns.dart';
import 'cart_item.dart';

class TCartItems extends StatelessWidget {
  final bool showAddRemoveButtons;

  const TCartItems({super.key, this.showAddRemoveButtons = true});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(
          () =>
          ListView.separated(
            shrinkWrap: true,
            itemCount: cartController.cartItems.length,
            separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwSections),
            itemBuilder: (_, index) =>
                Obx(() {
                  final item = cartController.cartItems[index];
                  return Column(children: [
                    // -- Cart Item
                     TCartItem(cartItem: item,),
                    if (showAddRemoveButtons) const SizedBox(
                        height: TSizes.spaceBtwItems),

                    // -- Add or remove to cart button

                    if (showAddRemoveButtons)
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 70),
                              TProductQuantityWithAddRemoveButton(
                                quantity: item.quantity,
                                add: ()=> cartController.addOneToCart(item),
                                remove: ()=> cartController.removeOneFromCart(item)
                              ),
                            ],
                          ),

                          // -- Product Total Price
                          TProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1)),
                        ],
                      ),
                  ]);
                }),
          ),
    );
  }
}
