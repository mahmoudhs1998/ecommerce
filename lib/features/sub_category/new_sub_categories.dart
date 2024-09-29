import 'package:ecommerce/features/shop/controllers/category_conotroller.dart';
import 'package:ecommerce/utils/constants/shimmer.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/appbar/app_bar.dart';
import '../../common/widgets/cart/product_cards/product_card_horizontal.dart';
import '../../common/widgets/custom_shapes/containers/rounded_image_container.dart';
import '../../common/widgets/texts/section_heading.dart';
import '../../utils/constants/sizes.dart';
import '../shop/models/category_model.dart';
import '../shop/models/product_model.dart';
import '../shop/screens/all_products/all_products.dart';

class NewSubCategoriesScreen extends StatelessWidget {
  final CategoryModel category;
  const NewSubCategoriesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: TAppBar(title: Text(category.name), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // -- Banner
              TRoundedImage(
                isNetworkImage: true,
                imageUrl: category.image,
                width: double.infinity,
                applyImageRadius: true,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // -- Sub Categories
              FutureBuilder(
                future: controller.getNewSubCategories(category.id),
                builder: (context, snapshot) {
          
                  // Handle Loader , Errors , No Record
          
                  const loader = THorizontalProductShimmer();
                  final widget = CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot , loader: loader);
                  if (widget != null) return widget;
          
                  // Record Found
                  final subCategories = snapshot.data!;
          
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                      itemBuilder: (_,index) {
                      final subCategory = subCategories[index];
          
                      return FutureBuilder(
                        future: controller.getCategoryProducts(categoryId: subCategory.id),
                        builder: (context, snapshot) {
          
                          // Handle Loader , Errors , No Record
          
                          const loader = THorizontalProductShimmer();
                          final widget = CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot , loader: loader);
                          if (widget != null) return widget;
          
                          // Record Found
                          final products = snapshot.data!;
          
                          return Column(
                            children: [
                              // -- Heading
                              TCategoriesSectionHeading(
                                  title: subCategory.name,
                                  onPressed: () =>
                                    Get.to(
                                  () => AllProducts(
                                    title: subCategory.name,
                                    futureMethod:
                                        controller
                                        .getCategoryProducts(
                                            categoryId: subCategory.id, limit: -1),
                                  ),
                                ),
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems / 2),
                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  itemCount: products.length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                  const SizedBox(width: TSizes.spaceBtwItems),
                                  itemBuilder: (context, index) =>
                                      TProductCardHorizontal(product: products[index]),
                                ),
                              ),
                              const SizedBox(height: TSizes.spaceBtwSections),
                            ],
                          );
                        }
                      );
                      }
                  );
          
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
