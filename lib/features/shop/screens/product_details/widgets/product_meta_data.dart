import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/icons/brand_title_verify_icon.dart';
import 'package:ecommerce/common/widgets/images/circular_image.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TProductMetaData extends StatelessWidget {
  final ProductModel product;
  const TProductMetaData({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
    controller.calculateSalePercentage(product.price, product.salePrice);
    final checkProductType = product.productType == ProductType.single.toString() && product.salePrice > 0 ;
    //final isDark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -- Price & Sale Price
        Row(
          children: [
            // -- Sale Tag
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondaryColor.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                '$salePercentage%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),

            // -- Price
            if(checkProductType)
               Text(
              '\$${product.price}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            if(checkProductType) const SizedBox(width: TSizes.spaceBtwItems),
             TProductPriceText(
              price: controller.getProductPrice(product),
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        // -- Title
         TProductTitleText(title: product.title),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        // -- Stock Status
        Row(
          children: [
            const TProductTitleText(title: 'Status'),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(controller.getProductStockStatus(product.stock), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        // -- Brand
        Row(
          children: [
            TcircularImage(
             // isNetworkImage: true,
              image: product.brand != null ? product.brand!.image : '', //TImages.success,
              height: 32,
              width: 32,
             //overlayColor: isDark ? TColors.black:TColors.white ,
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
             TBrandTitleWithVerifiedIcon(
              title:  product.brand != null ? product.brand!.name : '', //'Nike',
              brandTextSize: TextSizes.medium,
            ),
          ],
        )
      ],
    );
  }
}
