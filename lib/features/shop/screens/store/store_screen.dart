import 'package:ecommerce/common/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/appbar/cart_counter_icon.dart';
import 'package:ecommerce/common/widgets/appbar/tab_bar.dart';
import 'package:ecommerce/common/widgets/cart/brand/brand_card.dart';
import 'package:ecommerce/common/widgets/search%20bar/search_bar.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/screens/all_brands/all_brands.dart';
import 'package:ecommerce/features/shop/screens/store/widgets/category_tab.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title:
              Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCartCounterIcon(
              icon: Iconsax.shopping_bag,
              onPressed: () {},
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: THelperFunctions.isDarkMode(context)
                  ? TColors.black
                  : TColors.white,
              expandedHeight: 440,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // -- Search Bar
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const TSearchBar(
                        searchBarHint: 'Search in Store',
                        showBorder: true,
                        showBackGround: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      // -- Features Brands
                      TCategoriesSectionHeading(
                        title: "Featured Brands",
                        onPressed: () => Get.to(() => const AllBrandsScreen()),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections / 1.5,
                      ),

                      TGridLayout(
                          itemCount: 4,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            return const TBrandCard(showBorder: false);
                          }),
                    ]),
              ),
              // -- Tabs Section

              bottom: const CategoryTabBar(tabs: [
                Tab(
                  text: "Sports",
                ),
                Tab(
                  text: "Furniture",
                ),
                Tab(
                  text: "Electronics",
                ),
                Tab(
                  text: "Mobiles",
                ),
                Tab(
                  text: "Books",
                ),
              ]),
            ),
          ],
          body: TabBarView(children: [
            for (int i = 0; i < 5; i++) const TCategoryTab(),
          ]),
        ),
      ),
    );
  }
}

