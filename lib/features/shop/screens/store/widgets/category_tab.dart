import 'package:ecommerce/common/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/cart/brand/brand_showcase.dart';
import 'package:ecommerce/common/widgets/cart/product_cards/product_card_vertical.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(children: [
            // -- Brands
            const TBrandShowCase(
              images: [
                TImages.banner3,
                TImages.banner4,
                TImages.banner5,
              ],
            ),
            const TBrandShowCase(
              images: [
                TImages.banner3,
                TImages.banner4,
                TImages.banner5,
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            // -- Products
            TCategoriesSectionHeading(
              title: "Featured Brands",
              onPressed: () {},
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TGridLayout(
                itemCount: 4,
                itemBuilder: (_, index) => const TProductCardVertical()),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
          ]),
        ),
      ],
    );
  }
}
