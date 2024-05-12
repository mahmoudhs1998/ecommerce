import 'package:ecommerce/common/widgets/chips/choice_chip.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class TProductsAttributes extends StatelessWidget {
  const TProductsAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Column(children: [
      // -- Selected  Attribute Pricing & Description
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
                        Text(
                          '\$250',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .apply(decoration: TextDecoration.lineThrough),
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),

                        // -- Sale Price
                        const TProductPriceText(price: '20'),
                      ],
                    ),

                    // -- Stock Status
                    Row(children: [
                      const TProductTitleText(title: 'Stock', smallSize: true),
                      const SizedBox(width: TSizes.spaceBtwItems / 2),
                      Text('In Stock',
                          style: Theme.of(context).textTheme.titleMedium),
                    ]),
                  ],
                ),
              ],
            ),
            // -- Variation Description
            const TProductTitleText(
              title:
                  'This is the Description of the product and it can go up to max 4 lines',
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
        children: [
          const TCategoriesSectionHeading(
              title: 'Colors', showActionButton: false),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          Wrap(
            spacing: 8,
            children: [
              TChoiceChip(
                  text: 'Green', selected: true, onSelected: (value) {}),
              TChoiceChip(
                  text: 'Blue', selected: false, onSelected: (value) {}),
              TChoiceChip(text: 'Red', selected: false, onSelected: (value) {}),
            ],
          ),
        ],
      ),
      const SizedBox(height: TSizes.spaceBtwItems / 2),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TCategoriesSectionHeading(
              title: 'Sizes', showActionButton: false),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          Wrap(
            spacing: 8,
            children: [
              TChoiceChip(
                  text: 'EU 36', selected: true, onSelected: (value) {}),
              TChoiceChip(
                  text: 'EU 35', selected: false, onSelected: (value) {}),
              TChoiceChip(
                  text: 'EU 34', selected: false, onSelected: (value) {}),
            ],
          ),
        ],
      ),
    ]);
  }
}
