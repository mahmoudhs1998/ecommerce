import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/products/sortable/sort_able_products.dart';
import 'package:ecommerce/features/shop/controllers/Brands/brand_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/cart/brand/brand_card.dart';
import '../../../../utils/constants/shimmer.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../models/brand_model.dart';

class BrandProducts extends StatelessWidget {
  final BrandModel brand;
  const BrandProducts({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return  Scaffold(
      appBar:  TAppBar(title: Text(brand.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Details
              TBrandCard(showBorder: true,
              brand: brand,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              FutureBuilder(
                future: brandController.getBrandProducts(brandId: brand.id),
                builder: (context, snapshot) {

                  /// Handle Loader, No Record, OR Error Message
                  const loader = TVerticalProductShimmer();
                  final widget = CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;
                  /// Record Found
                   final brandProducts = snapshot.data!;
                  return  SortableProducts(products: brandProducts);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
