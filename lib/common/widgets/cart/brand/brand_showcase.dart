import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/widgets/cart/brand/brand_card.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/features/shop/screens/all_brands/brand_products.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/shimmer.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/models/brand_model.dart';

class TBrandShowCase extends StatelessWidget {
  final BrandModel brand;
  final List<String> images;
  const TBrandShowCase({
    required this.images,
    super.key, required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Get.to(()=> BrandProducts(brand: brand)),
      child: TRoundedContainer(
        showBorder: true,
        borderColor: TColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Column(children: [
          // -- Brand with product count
           TBrandCard(showBorder: false ,  brand: brand),
          const SizedBox(height: TSizes.spaceBtwItems,),

          // -- Brand with top 3 products images

          Row(
            children: images
                .map((image) => brandTopProductImageWidget(image, context))
                .toList(),
          ),
        ]),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, BuildContext context) {
    return Expanded(
      child: TRoundedContainer(
        height: 100,
        margin: const EdgeInsets.only(right: TSizes.sm),
        padding: const EdgeInsets.all(TSizes.md),
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkGrey
            : TColors.light,
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: image,
          progressIndicatorBuilder: (context , url , downloadProgress) => const TShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        // Image(
        //   image: AssetImage(image),
        //   fit: BoxFit.contain,
        // ),
      ),
    );
  }
}
