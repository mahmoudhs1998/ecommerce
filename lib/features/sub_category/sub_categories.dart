import 'package:ecommerce/common/widgets/cart/product_cards/product_card_horizontal.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_image_container.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/appbar/app_bar.dart';
import '../../utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(title: Text('Sub Categories'), showBackArrow: true),
      body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // -- Banner
              const TRoundedImage(
                  imageUrl: TImages.banner1,
                  width: double.infinity,
                  applyImageRadius: true),
              const SizedBox(height: TSizes.spaceBtwSections),

              // -- Sub Categories

              Column(
                children: [
                  // -- Heading
                  TCategoriesSectionHeading(
                    title: 'Sports Shirts',
                    onPressed: () {},
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: TSizes.spaceBtwItems),
                        itemBuilder: (context, index) =>
                            const TProductCardHorizontal()),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
