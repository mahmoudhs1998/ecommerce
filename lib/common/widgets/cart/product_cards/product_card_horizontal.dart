import 'package:ecommerce/common/widgets/icons/brand_title_verify_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helpers_functions.dart';
import '../../custom_shapes/containers/add_to_cart_button.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../custom_shapes/containers/rounded_image_container.dart';
import '../../icons/custom_circular_icon.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: isDark ? TColors.darkGrey : TColors.softGrey,
      ),
      child: Row(
        children: [
          // Thumbnail
          TRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: isDark ? TColors.dark : TColors.light,
            child: Stack(children: [
              // -- Thumbnail image
              const SizedBox(
                width: 120,
                height: 120,
                child: TRoundedImage(
                  imageUrl: TImages.banner1,
                  applyImageRadius: true,
                ),
              ),
              // -- Sale Tag
              Positioned(
                top: 10,
                child: TRoundedContainer(
                  radius: TSizes.sm,
                  backgroundColor: TColors.secondaryColor.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.sm, vertical: TSizes.xs),
                  child: Text(
                    "25%",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: TColors.black),
                  ),
                ),
              ),
              // -- Favorite icon button
              Positioned(
                top: 0,
                right: 0,
                child: TCircularIcon(
                    icon: Iconsax.heart5, onPressed: () {}, color: Colors.red),
              ),
            ]),
          ),

          // Details
          const SizedBox(
            width: 172,
            child: Padding(
              padding: EdgeInsets.only(left: TSizes.sm, top: TSizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitleText(
                          title: 'Green Nike Half Sleeves Shirt',
                          smallSize: true,
                          maxLines: 2,
                          textAlign: TextAlign.start),
                      SizedBox(height: TSizes.spaceBtwItems / 2),
                      TBrandTitleWithVerifiedIcon(title: 'Nike'),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // -- Price
                      Flexible(child: TProductPriceText(price: '250')),

                      // -- Add to cart button
                      AddToCartButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
