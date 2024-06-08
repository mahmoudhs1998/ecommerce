import 'package:ecommerce/common/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/cart/brand/brand_showcase.dart';
import 'package:ecommerce/common/widgets/cart/product_cards/product_card_vertical.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/category_conotroller.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/shimmer.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import 'category_brands.dart';

class TCategoryTab extends StatelessWidget {
  final CategoryModel category;

  const TCategoryTab({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(children: [
            // -- Brands
            CategoryBrands(category: category),
            // const TBrandShowCase(
            //   images: [
            //     TImages.banner3,
            //     TImages.banner4,
            //     TImages.banner5,
            //   ],
            // ),
            // const TBrandShowCase(
            //   images: [
            //     TImages.banner3,
            //     TImages.banner4,
            //     TImages.banner5,
            //   ],
            // ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            // -- Products
            FutureBuilder(
              future: controller.getCategoryProducts(categoryId: category.id),
              builder: (context, snapshot) {

                /// Helper Function: Handle Loader, No Record, OR ERROR Message
                final response = CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: const TVerticalProductShimmer());
                if (response != null) return response;

                /// Record Found!
                final products = snapshot.data !;
                return Column(
                  children: [
                    TCategoriesSectionHeading(
                        title: "You Might Also Like",
                        onPressed: () => Get.to(
                          AllProducts(
                              title: category.name,
                            futureMethod: controller.getCategoryProducts(
                                categoryId: category.id ,
                                limit: -1
                            ),
                          ),
                        ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TGridLayout(
                      itemCount: products.length,
                      itemBuilder: (_, index) =>
                          TProductCardVertical(product: products[index]),
                    ),
                  ],
                );
              }
            ),
          ]),
        ),
      ],
    );
  }
}
