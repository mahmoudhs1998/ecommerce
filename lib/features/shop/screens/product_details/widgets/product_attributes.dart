import 'package:ecommerce/admin/products/new_controller.dart';
import 'package:ecommerce/common/widgets/chips/choice_chip.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../controllers/product/variations_controller.dart';
import '../../../models/product_model.dart';

// class TProductsAttributes extends StatelessWidget {
//   final ProductModel product;
//
//   const TProductsAttributes({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = THelperFunctions.isDarkMode(context);
//     final controller = Get.put(VariationsController());
//
//     return Obx(
//       () => Column(children: [
//         // -- Selected  Attribute Pricing & Description
//         // Display variation price and stock when some variation is selected.
//         if (controller.selectedVariation.value.id.isNotEmpty)
//           TRoundedContainer(
//             padding: const EdgeInsets.all(TSizes.md),
//             backgroundColor: isDark ? TColors.darkGrey : TColors.grey,
//             child: Column(
//               children: [
//                 // -- Title , Price & Stock Statues
//                 Row(
//                   children: [
//                     const TCategoriesSectionHeading(
//                       title: 'Variation',
//                       showActionButton: false,
//                     ),
//                     const SizedBox(width: TSizes.spaceBtwItems),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             /// The line `const TProductTitleText(title: 'Price', smallSize: true,)` is creating an instance of the `TProductTitleText` widget with the title set to 'Price' and the `smallSize` parameter set to `true`. This widget is likely responsible for displaying a text element styled as a product title, possibly used to label the price information in the UI. The `smallSize: true` parameter might be used to indicate that the text should be displayed in a smaller size compared to the regular size of the product title text.
//                             const TProductTitleText(
//                               title: 'Price',
//                               smallSize: true,
//                             ),
//                             const SizedBox(width: TSizes.spaceBtwItems / 2),
//                             // -- Actual Price
//                             if (controller.selectedVariation.value.salePrice >
//                                 0)
//                               Text(
//                                 '\$${controller.selectedVariation.value.price}',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleSmall!
//                                     .apply(
//                                         decoration: TextDecoration.lineThrough),
//                               ),
//                             const SizedBox(width: TSizes.spaceBtwItems),
//
//                             // -- Sale Price
//                             TProductPriceText(
//                                 price: controller.getVariationPrice()),
//                           ],
//                         ),
//
//                         // -- Stock Status
//                         Row(children: [
//                           const TProductTitleText(
//                               title: 'Stock', smallSize: true),
//                           const SizedBox(width: TSizes.spaceBtwItems / 2),
//                           Text(controller.variationStockStatus.value,
//                               style: Theme.of(context).textTheme.titleMedium),
//                         ]),
//                       ],
//                     ),
//                   ],
//                 ),
//                 // -- Variation Description
//                  TProductTitleText(
//                   title:
//                       controller.selectedVariation.value.description ?? 'Description',
//                   smallSize: true,
//                   maxLines: 4,
//                 ),
//               ],
//             ),
//           ),
//         const SizedBox(height: TSizes.spaceBtwItems),
//         // -- Other Attributes
//
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: product.productAttributes!
//               .map((attribute) => Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TCategoriesSectionHeading(
//                           title: attribute.name ?? '', showActionButton: false),
//                       const SizedBox(height: TSizes.spaceBtwItems / 2),
//                       Obx(
//                         () => Wrap(
//                           spacing: 8,
//                           children: attribute.values!.map((attributeValue) {
//                             final isSelected =
//                                 controller.selectedAttributes[attribute.name] ==
//                                     attributeValue;
//                             final available = controller
//                                 .getAttributesAvailabilityInVariation(
//                                     product.productVariations!, attribute.name!)
//                                 .contains(attributeValue);
//                             return TChoiceChip(
//                                 text: attributeValue,
//                                 selected: isSelected,
//                                 onSelected: available
//                                     ? (selected) {
//                                         if (selected && available) {
//                                           controller.onAttributeSelected(
//                                               product,
//                                               attribute.name ?? '',
//                                               attributeValue);
//                                         }
//                                       }
//                                     : null);
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ))
//               .toList(),
//         ),
//         // const SizedBox(height: TSizes.spaceBtwItems / 2),
//         // Column(
//         //   crossAxisAlignment: CrossAxisAlignment.start,
//         //   children: [
//         //     const TCategoriesSectionHeading(
//         //         title: 'Sizes', showActionButton: false),
//         //     const SizedBox(height: TSizes.spaceBtwItems / 2),
//         //     Wrap(
//         //       spacing: 8,
//         //       children: [
//         //         TChoiceChip(
//         //             text: 'EU 36', selected: true, onSelected: (value) {}),
//         //         TChoiceChip(
//         //             text: 'EU 35', selected: false, onSelected: (value) {}),
//         //         TChoiceChip(
//         //             text: 'EU 34', selected: false, onSelected: (value) {}),
//         //       ],
//         //     ),
//         //   ],
//         // ),
//       ]),
//     );
//   }
// }


class TProductsAttributes extends StatelessWidget {
  final ProductModel product;

  const TProductsAttributes({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationsController());
    final controllers = Get.put(NewAdminPanelController());

    return Obx(
          () => Column(
        children: [
          // Selected Attribute Pricing & Description
          if (controller.selectedVariation.value.id.isNotEmpty)
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: THelperFunctions.isDarkMode(context)
                  ? TColors.darkGrey
                  : TColors.grey,
              child: Column(
                children: [
                  // Title, Price & Stock Status
                  Row(
                    children: [
                      const TCategoriesSectionHeading(
                        title: 'Variation',
                        showActionButton: false,
                      ),
                       TCategoriesSectionHeading(
                        title: controllers.variationDescriptionController.value.text,
                        showActionButton: false,
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const TProductTitleText(
                                title: 'Price:',
                                smallSize: true,
                              ),
                              const SizedBox(width: TSizes.spaceBtwItems / 2),
                              // Actual Price
                              if (controller
                                  .selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  '\$${controller.selectedVariation.value.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              const SizedBox(width: TSizes.spaceBtwItems),
                              // Sale Price
                              TProductPriceText(
                                price: controller.getVariationPrice(),
                              ),
                            ],
                          ),
                          // Stock Status
                          Row(
                            children: [
                              const TProductTitleText(
                                title: 'Stock:',
                                smallSize: true,
                              ),
                              const SizedBox(width: TSizes.spaceBtwItems / 2),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  // // Assuming you have a Text widget for the description
                  // Obx(() {
                  //   final description = VariationsController.instance.getVariationDescription();
                  //   return Text(
                  //     description ?? 'No description available',
                  //     style: TextStyle(fontSize: 16),
                  //   );
                  // }),

                  Obx(() {
                    final description = VariationsController.instance.getVariationDescription();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ReadMoreText(
                        description ?? 'No description available',
                        trimLines: 2,
                        colorClickableText: Colors.blue,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        style: TextStyle(fontSize: 16),
                        moreStyle: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    );
                  })




                  // //Variation Description
                  // TProductTitleText(
                  //   title: controller.selectedVariation.value.description ??
                  //       'No description available',
                  //   smallSize: true,
                  //   maxLines: 4,
                  // ),
                  // TProductTitleText(
                  //   title: controllers.variationDescriptionController.value.text,
                  //
                  //   smallSize: true,
                  //   maxLines: 4,
                  // ),
                ],
              ),
            ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Colors
          if (product.productAttributes!
              .any((attr) => attr.name?.toLowerCase() == 'Color'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TCategoriesSectionHeading(
                  title: 'Colors',
                  showActionButton: false,
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Wrap(
                  spacing: 8,
                  children: product.productAttributes!
                      .firstWhere(
                          (attr) => attr.name?.toLowerCase() == 'Color')
                      .values!
                      .map((color) {
                    final isSelected =
                        controller.selectedAttributes['Color'] == color;
                    final available = controller
                        .getAttributesAvailabilityInVariation(
                        product.productVariations!, 'Color')
                        .contains(color);
                    return TChoiceChip(
                      text: color,
                      selected: isSelected,
                      onSelected: available
                          ? (selected) {
                        if (selected && available) {
                          controller.onAttributeSelected(
                              product, 'Color', color);
                        }
                      }
                          : null,
                    );
                  }).toList(),
                ),
              ],
            ),

          const SizedBox(height: TSizes.spaceBtwItems),

          // Sizes
          if (product.productAttributes!
              .any((attr) => attr.name?.toLowerCase() == 'Size'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TCategoriesSectionHeading(
                  title: 'Sizes',
                  showActionButton: false,
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Wrap(
                  spacing: 8,
                  children: product.productAttributes!
                      .firstWhere((attr) => attr.name?.toLowerCase() == 'Size')
                      .values!
                      .map((size) {
                    final isSelected =
                        controller.selectedAttributes['Size'] == size;
                    final available = controller
                        .getAttributesAvailabilityInVariation(
                        product.productVariations!, 'Size')
                        .contains(size);
                    return TChoiceChip(
                      text: size,
                      selected: isSelected,
                      onSelected: available
                          ? (selected) {
                        if (selected && available) {
                          controller.onAttributeSelected(
                              product, 'Size', size);
                        }
                      }
                          : null,
                    );
                  }).toList(),
                ),
              ],
            ),

          const SizedBox(height: TSizes.spaceBtwItems),

          // Other Attributes
          ...product.productAttributes!
              .where((attribute) =>
          attribute.name?.toLowerCase() != 'Color' &&
              attribute.name?.toLowerCase() != 'Size')
              .map((attribute) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TCategoriesSectionHeading(
                title: attribute.name ?? '',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Wrap(
                spacing: 8,
                children: attribute.values!.map((attributeValue) {
                  final isSelected =
                      controller.selectedAttributes[attribute.name] ==
                          attributeValue;
                  final available = controller
                      .getAttributesAvailabilityInVariation(
                      product.productVariations!, attribute.name!)
                      .contains(attributeValue);
                  return TChoiceChip(
                    text: attributeValue,
                    selected: isSelected,
                    onSelected: available
                        ? (selected) {
                      if (selected && available) {
                        controller.onAttributeSelected(product,
                            attribute.name ?? '', attributeValue);
                      }
                    }
                        : null,
                  );
                }).toList(),
              ),
            ],
          ))
              .toList(),
        ],
      ),
    );
  }
}