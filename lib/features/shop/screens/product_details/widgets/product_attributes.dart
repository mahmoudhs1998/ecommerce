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

import '../../../controllers/product/variations_controller.dart';
import '../../../models/product_model.dart';

class TProductsAttributes extends StatelessWidget {
  final ProductModel product;

  const TProductsAttributes({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationsController());

    return Obx(
      () => Column(children: [
        // -- Selected  Attribute Pricing & Description
        // Display variation price and stock when some variation is selected.
        if (controller.selectedVariation.value.id.isNotEmpty)
          TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.md),
            backgroundColor: isDark ? TColors.darkGrey : TColors.grey,
            child: Column(
              children: [
                // -- Title , Price & Stock Statues
                Row(
                  children: [
                    const TCategoriesSectionHeading(
                      title: 'Variation',
                      showActionButton: false,
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            /// The line `const TProductTitleText(title: 'Price', smallSize: true,)` is creating an instance of the `TProductTitleText` widget with the title set to 'Price' and the `smallSize` parameter set to `true`. This widget is likely responsible for displaying a text element styled as a product title, possibly used to label the price information in the UI. The `smallSize: true` parameter might be used to indicate that the text should be displayed in a smaller size compared to the regular size of the product title text.
                            const TProductTitleText(
                              title: 'Price',
                              smallSize: true,
                            ),
                            const SizedBox(width: TSizes.spaceBtwItems / 2),
                            // -- Actual Price
                            if (controller.selectedVariation.value.salePrice >
                                0)
                              Text(
                                '\$${controller.selectedVariation.value.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .apply(
                                        decoration: TextDecoration.lineThrough),
                              ),
                            const SizedBox(width: TSizes.spaceBtwItems),

                            // -- Sale Price
                            TProductPriceText(
                                price: controller.getVariationPrice()),
                          ],
                        ),

                        // -- Stock Status
                        Row(children: [
                          const TProductTitleText(
                              title: 'Stock', smallSize: true),
                          const SizedBox(width: TSizes.spaceBtwItems / 2),
                          Text(controller.variationStockStatus.value,
                              style: Theme.of(context).textTheme.titleMedium),
                        ]),
                      ],
                    ),
                  ],
                ),
                // -- Variation Description
                 TProductTitleText(
                  title:
                      controller.selectedVariation.value.description ?? 'Description',
                  smallSize: true,
                  maxLines: 4,
                ),
              ],
            ),
          ),
        const SizedBox(height: TSizes.spaceBtwItems),
        // -- Other Attributes

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: product.productAttributes!
              .map((attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TCategoriesSectionHeading(
                          title: attribute.name ?? '', showActionButton: false),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      Obx(
                        () => Wrap(
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
                                          controller.onAttributeSelected(
                                              product,
                                              attribute.name ?? '',
                                              attributeValue);
                                        }
                                      }
                                    : null);
                          }).toList(),
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
        // const SizedBox(height: TSizes.spaceBtwItems / 2),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const TCategoriesSectionHeading(
        //         title: 'Sizes', showActionButton: false),
        //     const SizedBox(height: TSizes.spaceBtwItems / 2),
        //     Wrap(
        //       spacing: 8,
        //       children: [
        //         TChoiceChip(
        //             text: 'EU 36', selected: true, onSelected: (value) {}),
        //         TChoiceChip(
        //             text: 'EU 35', selected: false, onSelected: (value) {}),
        //         TChoiceChip(
        //             text: 'EU 34', selected: false, onSelected: (value) {}),
        //       ],
        //     ),
        //   ],
        // ),
      ]),
    );
  }
}
