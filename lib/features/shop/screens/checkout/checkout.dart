import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:ecommerce/zBottom_navigation_bar/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/cart/coupon/coupon_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helpers_functions.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../controllers/cart/cart_controller.dart';
import '../../controllers/checkout/order_controller.dart';
import 'widgets/billing_address_section.dart';
import 'widgets/billing_amount_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, 'US');
    final orderController = Get.put(OrderController());
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Order Review',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // -- Cart Items
              const TCartItems(showAddRemoveButtons: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              // -- Coupon TextField
              const TCouponCode(),

              const SizedBox(height: TSizes.spaceBtwSections),

              // -- Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: isDark ? TColors.dark : TColors.white,
                child: const Column(children: [
                  // -- Price
                  BillingAmountSection(),
                  SizedBox(height: TSizes.spaceBtwItems),
                  // -- Divider
                  Divider(),
                  SizedBox(height: TSizes.spaceBtwItems),

                  // -- Payment Method
                  BillingPaymentSection(),
                  SizedBox(height: TSizes.spaceBtwItems),
                  // -- Address
                  BillingAddressSection(),
                ]),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: ()=>orderController.processOrder(totalAmount),
          child: Text('Checkout \$$totalAmount'),
        ),
        // ElevatedButton(
        //     onPressed: () => subTotal > 0
        //         ?  ()=> orderController.processOrder(totalAmount)
        //         :  ()=> TLoaders.warningSnackBar(title: 'Empty Cart', message: 'Add items in the cart in order to proceed.'),
        //         // Get.to(() => SuccessScreen(
        //         //   title: 'Payment Successful',
        //         //   image: TImages.success,
        //         //   subTitle: 'Thank you for your purchase!',
        //         //   onPressed: () => Get.offAll(() => const NavigationMenu()),
        //         // )),
        //     child: Text('Checkout \$$totalAmount'),
        // ),
      ),
    );
  }
}
