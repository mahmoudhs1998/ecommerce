import 'package:ecommerce/common/widgets/icons/brand_title_verify_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helpers_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../custom_shapes/containers/rounded_image_container.dart';
import '../../favourite_icon/favourite_icon.dart';

class TProductCardHorizontal extends StatelessWidget {
  final ProductModel product;
  const TProductCardHorizontal({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
    controller.calculateSalePercentage(product.price, product.salePrice);
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
               SizedBox(
                width: 120,
                height: 120,
                child: TRoundedImage(
                  isNetworkImage: true,
                  imageUrl:  product.thumbnail, // TImages.banner1,
                  applyImageRadius: true,
                ),
              ),
              // -- Sale Tag
              if(salePercentage != null)
              Positioned(
                top: 10,
                child: TRoundedContainer(
                  radius: TSizes.sm,
                  backgroundColor: TColors.secondaryColor.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.sm, vertical: TSizes.xs),
                  child: Text(
                    "$salePercentage%",
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
                child: TFavouriteIcon(productId: product.id),
               // TCircularIcon(icon: Iconsax.heart5, onPressed: () {}, color: Colors.red),
              ),
            ]),
          ),

          // Details
           SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(left: TSizes.sm, top: TSizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitleText(title:product.title, smallSize: true,),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                       TBrandTitleWithVerifiedIcon(title: product.brand!.name),
                    ],
                  ),
                  const Spacer(),
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     // -- Price
                  //     Flexible(child: TProductPriceText(price: '250')),
                  //
                  //     // -- Add to cart button
                  //     AddToCartButton(),
                  //   ],
                  // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Price
                  Flexible(
                    child: Column(
                      children: [
                        if (product.productType ==
                            ProductType.single.toString() &&
                            product.salePrice > 0)
                          Padding(
                            padding: const EdgeInsets.only(left: TSizes.sm),
                            child: Text(
                              product.price.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .apply(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),

                        /// Price , show sale price
                        Padding(
                          padding: const EdgeInsets.only(left: TSizes.sm),
                          child: TProductPriceText(
                              price: controller.getProductPrice(product)),
                        ),
                      ],
                    ),
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
