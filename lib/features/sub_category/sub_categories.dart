import 'package:ecommerce/common/widgets/cart/product_cards/product_card_horizontal.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_image_container.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/category_conotroller.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/appbar/app_bar.dart';
import '../../utils/constants/shimmer.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/cloud_helper_functions.dart';

class SubCategoriesScreen extends StatelessWidget {
  final CategoryModel category;
  const SubCategoriesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryController.instance;

    return Scaffold(
      appBar:  TAppBar(title: Text(category.name), showBackArrow: true),
      body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // -- Banner
               TRoundedImage(
                isNetworkImage: true,
                  imageUrl:  category.image,//TImages.banner1,
                  width: double.infinity,
                  applyImageRadius: true),
              const SizedBox(height: TSizes.spaceBtwSections),

              // -- Sub Categories

              FutureBuilder(
                future: categoryController.getSubCategories(category.id),
                builder: (context, snapshot) {

                  /// Handle Loader, No Record, OR Error Message
                  const loader=CircularProgressIndicator();  // THorizontalProductShimmer(); //CircularProgressIndicator();//
                  final widget = CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  /// Record found.
                  final subCategories = snapshot.data!;
                  print('subCategories ===================================== ${subCategories.isEmpty}');

                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: subCategories.length,
                      itemBuilder: (_,index){
                        final subCategory = subCategories[index];
                        return FutureBuilder(
                          future: categoryController.getCategoryProducts(categoryId: subCategory.id),
                          builder: (context, snapshot) {
                            /// Handle Loader, No Record, OR Error Message
                            const loader=CircularProgressIndicator(); //THorizontalProductShimmer();
                            final widget = CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                            if (widget != null) return widget;

                            ///Congratulations Record found.
                            final products = snapshot.data!;
                            print('products ===================================== $products');
                            return Column(
                              children: [
                                // -- Heading
                                TCategoriesSectionHeading(
                                  title: subCategory.name,
                                  onPressed: () => Get.to(
                                          ()=>AllProducts(
                                              title: subCategory.name,
                                            futureMethod: categoryController.getCategoryProducts(categoryId: subCategory.id , limit: -1),
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
                                       TProductCardHorizontal(product: products[index])),
                                ),
                              ],
                            );
                          }
                        );
                      }
                  );

                }
              ),
            ],
          )),
    );
  }
}
