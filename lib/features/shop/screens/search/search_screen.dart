
import 'package:ecommerce/common/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/cart/product_cards/product_card_vertical.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/form fields/custom_search_field.dart';
import '../../controllers/product/product_controller.dart';
import '../../../../utils/constants/shimmer.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =ProductController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            child: Column(

              children: [
                const CustomSearchField(),
                const SizedBox(height : TSizes.spaceBtwItems),

                      Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const TVerticalProductShimmer();
                        }
                        if (controller.featuredProducts.isEmpty) {
                          return const Center(
                            child:  CircularProgressIndicator(),

                          );
                        }

                        return TGridLayout(
                          itemCount: controller.featuredProducts.length,
                          itemBuilder: (context, index) => TProductCardVertical(

                            product: controller.featuredProducts[index],
                          ),
                        );
                      }),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




