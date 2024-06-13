// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
//
// import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
// import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/sizes.dart';
// import '../../../utils/helpers/helpers_functions.dart';
//
// class OrderCartWidget extends StatelessWidget {
// const OrderCartWidget({ super.key });
//
//   @override
//   Widget build(BuildContext context){
//         final isDark = THelperFunctions.isDarkMode(context);
//
//     return TRoundedContainer(
//       showBorder: true,
//       padding: const EdgeInsets.all(TSizes.md),
//       backgroundColor: isDark ? TColors.dark : TColors.light,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // -- 1 - Row
//           Row(
//             children: [
//               // 1-- Icon
//
//               const Icon(Iconsax.ship),
//               const SizedBox(width: TSizes.spaceBtwItems / 2),
//
//               // -- Status & Date
//
//               Expanded(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Order Placed',
//                       style: Theme.of(context).textTheme.bodyLarge!.apply(
//                           color: TColors.primaryColor, fontWeightDelta: 1),
//                     ),
//                     Text('18 May 2024',
//                         style: Theme.of(context).textTheme.headlineSmall),
//                   ],
//                 ),
//               ),
//               IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm)),
//             ],
//           ),
//           const SizedBox(height: TSizes.spaceBtwItems),
//
//           // -- Row 2
//           Row(
//             children: [
//               Expanded(
//                 child: Row(
//                   children: [
//                     // 1-- Icon
//
//                     const Icon(Iconsax.tag),
//                     const SizedBox(width: TSizes.spaceBtwItems / 2),
//
//                     // -- Status & Date
//
//                     Expanded(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Order Placed',
//                             style: Theme.of(context).textTheme.labelMedium,
//                           ),
//                           Text('[#4378f438]',
//                               style: Theme.of(context).textTheme.titleMedium),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               Expanded(
//                 child: Row(
//                   children: [
//                     const Icon(Iconsax.calendar),
//                     const SizedBox(width: TSizes.spaceBtwItems / 2),
//
//                     // -- Status & Date
//
//                     Expanded(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Shipping Date',
//                             style: Theme.of(context).textTheme.labelMedium,
//                           ),
//                           Text('18 june 2024',
//                               style: Theme.of(context).textTheme.titleMedium),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // 1-- Icon
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../personalization/models/order.dart';

class OrderCartItem extends StatelessWidget {
  const OrderCartItem({
    super.key,
    required this.isDark,
    required this.order,
  });

  final bool isDark;
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
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
  }
}