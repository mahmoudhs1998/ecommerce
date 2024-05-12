import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_image_container.dart';
import 'package:ecommerce/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return TCustomCurvedEdgesWidget(
      child: Container(
        color: isDark ? TColors.darkGrey : TColors.light,
        child: Stack(children: [
          // -- Product Main Large Image
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
              child: Center(child: Image.asset(TImages.banner5)),
            ),
          ),

          /// Image Slider
          Positioned(
            right: 0,
            bottom: 30,
            left: TSizes.defaultSpace,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                itemCount: 6,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (_, __) =>
                    const SizedBox(width: TSizes.spaceBtwItems),
                itemBuilder: (_, index) => TRoundedImage(
                  width: 80,
                  backgroundColor: isDark ? TColors.dark : TColors.white,
                  border: Border.all(color: TColors.primaryColor),
                  padding: const EdgeInsets.all(TSizes.sm),
                  imageUrl: TImages.banner5,
                ), // TRoundedImage
              ), // ListView.separated
            ), // SizedBox
          ),
          // -- Appbar with back arrow and heart icon
          const TAppBar(
            showBackArrow: true,
            actions: [
              Icon(Iconsax.heart5, color: Colors.red),
            ],
          ),
        ]),
      ),
    );
  }
}
