import 'package:ecommerce/common/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/cart/product_cards/product_card_vertical.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce/common/widgets/search%20bar/search_bar.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_app_bar_widget.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:ecommerce/utils/constants/shimmer.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import '../all_products/all_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
   
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(children: [
                // App Bar
                const THomeAppBar(),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                // Search Bar
                TSearchBar(
                  searchBarHint: TTexts.searchBarHint,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                // Categories Heading
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                  child: Column(
                    children: [
                      TCategoriesSectionHeading(
                        title: "Popular Categories",
                        showActionButton: false,
                        onPressed: () {},
                      ),

                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      // Categories
                      const HomeCategories(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ]),
            ),

            // Body --
            const Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TPromoSlider(),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            //heading
            TCategoriesSectionHeading(
              title: "Popular Products",
              showActionButton: true,
              onPressed: () => Get.to(() => const AllProducts()),
            ),
            // Popular Products
            Obx(() {
              if (controller.isLoading.value) {
                return const TVerticalProductShimmer();
              }
              if (controller.featuredProducts.isEmpty) {
                return const Center(
                    child:  CircularProgressIndicator(),
                //     Text(
                //   'No Data Found !',
                //   style: Theme.of(context).textTheme.bodyMedium,
                // )
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
      ),
    );
  }
}
