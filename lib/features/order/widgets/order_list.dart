import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../common/widgets/loaders/animation_loader.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../../utils/helpers/helpers_functions.dart';
import '../../../zBottom_navigation_bar/navigation_menu.dart';
import '../../shop/controllers/checkout/order_controller.dart';

class TOrdersListItems extends StatelessWidget {
  const TOrdersListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final orderController = Get.put(OrderController());

    return FutureBuilder(
      future: orderController.fetchUserOrders(),
      builder: (_, snapshot) {

        /// Nothing Found Widget
        final emptyWidget = TAnimationLoaderWidget(
            text: 'Whoops! No Orders Yet!',
            animation: TImages.shopAnimation,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
        );
        /// Helper Function: Handle Loader, No Record, OR ERROR Message
        final response = CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, nothingFound: emptyWidget);
        if (response != null) return response;

        /// Congratulations Record found.
        final orders = snapshot.data!;
        return ListView.separated(
          shrinkWrap: true,
            itemCount: orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
            itemBuilder: (_, index){
            final order = orders[index];
             // return OrderCartItem(isDark: isDark, order: order);
            return TRoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: isDark ? TColors.dark : TColors.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // -- 1 - Row
                  Row(
                    children: [
                      // 1-- Icon

                      const Icon(Iconsax.ship),
                      const SizedBox(width: TSizes.spaceBtwItems / 2),

                      // -- Status & Date

                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStatusText,
                              style: Theme.of(context).textTheme.bodyLarge!.apply(
                                  color: TColors.primaryColor, fontWeightDelta: 1),
                            ),
                            Text(order.formattedOrderDate,
                                style: Theme.of(context).textTheme.headlineSmall),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm)),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  // -- Row 2
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            // 1-- Icon

                            const Icon(Iconsax.tag),
                            const SizedBox(width: TSizes.spaceBtwItems / 2),

                            // -- Status & Date

                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order',
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(order.id,
                                      maxLines: 1,
                                      style: Theme.of(context).textTheme.titleMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Iconsax.calendar),
                            const SizedBox(width: TSizes.spaceBtwItems / 2),

                            // -- Status & Date

                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shipping Date',
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(order.formattedDeliveryDate,
                                      style: Theme.of(context).textTheme.titleMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 1-- Icon
                    ],
                  ),
                ],
              ),
            );
            },// const OrderCartWidget(),
            );
      }
    );
  }
}


