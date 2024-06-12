import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_image_container.dart';
import 'package:ecommerce/common/widgets/icons/brand_title_verify_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/features/shop/models/cart/cart_item_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/images.dart';

class TCartItem extends StatelessWidget {
  final CartItemModel cartItem;

  const TCartItem({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedImage(
          isNetworkImage: true,
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkGrey
              : TColors.white,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        // -- Title , Price & Size
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TBrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ''),
                Flexible(
                  child: TProductTitleText(title: cartItem.title, maxLines: 1),
                ),

                // -- Attributes

                Text.rich(
                  TextSpan(
                      children: (cartItem.selectedVariation ?? {})
                          .entries
                          .map(
                            (e) => TextSpan(
                              children: [
                                TextSpan(
                                    text: '${e.key}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                TextSpan(
                                    text: '${e.value}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                          )
                          .toList()
                      // [
                      //   TextSpan(
                      //       text: 'Color ',
                      //       style: Theme.of(context).textTheme.bodySmall),
                      //   TextSpan(
                      //       text: 'Black ',
                      //       style: Theme.of(context).textTheme.bodyLarge),
                      //   TextSpan(
                      //       text: 'Size ',
                      //       style: Theme.of(context).textTheme.bodySmall),
                      //   TextSpan(
                      //       text: 'UK 07',
                      //       style: Theme.of(context).textTheme.bodyLarge),
                      // ]
                      ),
                ),
              ]),
        ),
      ],
    );
  }
}
