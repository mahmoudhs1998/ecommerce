import 'package:ecommerce/common/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/appbar/cart_counter_icon.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/icons/brand_title_verify_icon.dart';
import 'package:ecommerce/common/widgets/images/circular_image.dart';
import 'package:ecommerce/common/widgets/search%20bar/search_bar.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
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
                    TCategoriesSection(
                      title: "Featured Brands",
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections / 1.5,
                    ),

                    TGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: TRoundedContainer(
                              padding: const EdgeInsets.all(TSizes.sm),
                              showBorder: true,
                              backgroundColor: Colors.transparent,
                              child: Row(
                                children: [
                                  // -- Image
                                  Flexible(
                                    child: TcircularImage(
                                      image: TImages.success,
                                      backgroundColor: Colors.transparent,
                                      overlayColor:
                                          THelperFunctions.isDarkMode(context)
                                              ? TColors.white
                                              : TColors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: TSizes.spaceBtwItems / 2,
                                  ),
                                  // -- Text
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const TBrandTitleWithVerifiedIcon(
                                          title: 'Nike',
                                          brandTextSize: TextSizes.large,
                                        ),
                                        Text(
                                          '256 Products ProductsProductsProducts',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ]),
            ),
          ),
        ],
        body: Container(),
      ),
    );
  }
}
