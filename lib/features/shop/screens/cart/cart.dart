import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/features/shop/screens/checkout/checkout.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../utils/constants/images.dart';
import '../../../../zBottom_navigation_bar/navigation_menu.dart';
import '../../controllers/cart/cart_controller.dart';
import 'widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Cart'.tr, style: Theme
            .of(context)
            .textTheme
            .headlineSmall),
      ),
      body: Obx(() {
        /// Nothing Found Widget
        final emptyWidget = TAnimationLoaderWidget(
        text: 'Whoops! Cart is EMPTY.'.tr,
        animation: TImages.shopAnimation,
        showAction: true,
        actionText: 'Let\'s fill it'.tr,
        onActionPressed: () => Get.off(() => const NavigationMenu()),
        ); //
        if (cartController.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            // -- Cart Items
            child: TCartItems(),
                    ),
          );
        }
      }),
      // -- Checkout Button
      bottomNavigationBar: cartController.cartItems.isEmpty
          ? const  SizedBox()
        :Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            child:  Obx(
              ()=>Text(
                  '${TTexts.checkout.tr} \$${cartController.totalCartPrice.value}'
              ),
            ),
        ),
      ),
    );
  }
}
