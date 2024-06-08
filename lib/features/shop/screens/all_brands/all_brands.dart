import 'package:ecommerce/features/shop/controllers/Brands/brand_controller.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/layouts/grid_layout.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/cart/brand/brand_card.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import 'brand_products.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const TAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              const TCategoriesSectionHeading(
                  title: 'Brands', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// - Brands
              Obx(() {
                if(brandController.isLoading.value) return const TBrandsShimmer();
                if(brandController.featuredBrands.isEmpty) {

                  return Center(
                      child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
                }
                return TGridLayout(
                    itemCount: brandController.allBrands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (_, index) {
                      final brand = brandController.allBrands[index];
                      return TBrandCard(
                        showBorder: false ,
                        brand: brand ,
                        onTap: ()=> Get.to(()=> BrandProducts(brand: brand)),
                      );
                    });
              }),
            ],
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
