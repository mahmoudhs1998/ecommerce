import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/layouts/grid_layout.dart';
import '../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../helpers/helpers_functions.dart';

class TShimmerEffect extends StatelessWidget {
  final double width, height, radius;
  final Color? color;

  const TShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (isDark ? TColors.darkGrey : TColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

class TVerticalProductShimmer extends StatelessWidget {
  const TVerticalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            TShimmerEffect(width: 180, height: 180),
            SizedBox(height: TSizes.spaceBtwItems),

            /// Text
            TShimmerEffect(width: 160, height: 15),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            TShimmerEffect(width: 110, height: 15),
          ],
        ), // SizedBox
      ), // TGridLayout
    );
  }
}

class THorizontalProductShimmer extends StatelessWidget {
  const THorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder:(_, __) =>const SizedBox(width: TSizes.spaceBtwItems ),
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
        child: Container(
          width: 310,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: TColors.softGrey,
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Thumbnail shimmer
              TRoundedContainer(
                height: 120,
                padding: EdgeInsets.all(TSizes.sm),
                backgroundColor: TColors.light,
                child: TShimmerEffect(width: 120, height: 120),
              ),

              // Details shimmer
              SizedBox(
                width: 172,
                child: Padding(
                  padding: EdgeInsets.only(left: TSizes.sm, top: TSizes.sm),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TShimmerEffect(width: 160, height: 15),
                          SizedBox(height: TSizes.spaceBtwItems / 2),
                          TShimmerEffect(width: 110, height: 15),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: TShimmerEffect(width: 50, height: 15)),
                          TShimmerEffect(width: 24, height: 24),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class TBrandsShimmer extends StatelessWidget {
  const TBrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const TShimmerEffect(width: 300, height: 80),
    ); // TGridLayout
  }
}

class TListTileShimmer extends StatelessWidget {
  const TListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            TShimmerEffect(width: 50, height: 50, radius: 58),
            SizedBox(width: TSizes.spaceBtwItems),
            Column(
              children: [
                TShimmerEffect(width: 100, height: 15),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                TShimmerEffect(width: 80, height: 12),
              ],
            ), // Column
          ],
        ), // Row
      ],
    );
  }
}

class TBoxesShimmer extends StatelessWidget {
  const TBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Row(
        children: [
          Expanded(child: TShimmerEffect(width: 150, height: 118)),
          SizedBox(width: TSizes.spaceBtwItems),
          Expanded(child: TShimmerEffect(width: 150, height: 110)),
          SizedBox(width: TSizes.spaceBtwItems),
          Expanded(child: TShimmerEffect(width: 150, height: 110)),
        ],
      ) // ROw
    ]); // Column
  }
}
