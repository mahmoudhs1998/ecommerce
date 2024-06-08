import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/cart/brand/brand_showcase.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../../utils/constants/shimmer.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/Brands/brand_controller.dart';
import '../../../models/category_model.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({
  super.key,
  required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {

        /// Handle Loader, No Record, OR Error Message
        const loader = Column(
            children: [
            TListTileShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
        TBoxesShimmer(),
        SizedBox(height: TSizes.spaceBtwItems)
],
        ); // Column
        final widget = CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot , loader: loader);
        if(widget != null) return widget;
        // Record Found!
        final brands = snapshot.data!;

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: brands.length,
            itemBuilder: (_,index)
            {
              final brand = brands[index];

              return  FutureBuilder(
                future: controller.getBrandProducts(brandId: brand.id , limit: 3),
                builder: (context, snapshot) {

                  final widget = CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot , loader: loader);
                  if(widget != null) return widget;
                  // Record Found!
                  final products = snapshot.data!;
                  return TBrandShowCase(
                    brand: brand,
                      images: products.map((product) =>product.thumbnail).toList(),
                );
                }
              );
            },
        );

      }
    );
  }
}