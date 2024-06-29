import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/icons/brand_title_verify_icon.dart';
import 'package:ecommerce/common/widgets/images/circular_image.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class TBrandCard extends StatelessWidget {
  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;
  const TBrandCard({
    super.key, required this.showBorder,  this.onTap, required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            // -- Image
            Flexible(
              child: TcircularImage(
                isNetworkImage: true,
                image:  brand.image, // TImages.success,
                backgroundColor: Colors.transparent,
                overlayColor: THelperFunctions.isDarkMode(context)
                    ? TColors.white
                    : TColors.black,
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
            // -- Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TBrandTitleWithVerifiedIcon(
                    title: brand.name, //'Nike',
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                     '${brand.productsCount ?? 0} Products', //'256 Products ProductsProductsProducts',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
