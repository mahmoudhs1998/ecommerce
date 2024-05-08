import 'package:ecommerce/common/styles/shadows.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_image_container.dart';
import 'package:ecommerce/common/widgets/icons/brand_title_verify_icon.dart';
import 'package:ecommerce/common/widgets/icons/custom_circular_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: isDark ? TColors.darkGrey : TColors.light,
        ),
        child: Column(
          children: [
            // Thumbnail , whishlist button , Discount tag
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: isDark ? TColors.dark : TColors.white,
              child: Stack(
                children: [
                  // -- Thumbnail image
                  const Center(
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
                        icon: Iconsax.heart5,
                        onPressed: () {},
                        color: Colors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            // -- Details
            const Padding(
              padding: EdgeInsets.only(left: TSizes.sm),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TProductTitleText(
                        title: 'Green Nike Air Shoes', smallSize: true),
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                    TBrandTitleWithVerifiedIcon(
                      title: 'Nike',
                    ),
                  ]),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price
                const Padding(
                  padding: EdgeInsets.only(left: TSizes.sm),
                  child: TProductPriceText(price: '35'),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productImageRadius),
                    ), // BorderRadius.only
                  ), // BoxDecoration
                  child: const SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(child: Icon(Icons.add, color: TColors.white)),
                  ), // SizedBox
                ), // Container
              ],
            ), // Row;
          ],
        ),
      ),
    );
  }
}

