import 'package:ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce/common/widgets/search%20bar/search_bar.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_bar_widget.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                const Padding(
                  padding: EdgeInsets.only(left: TSizes.defaultSpace),
                  child: Column(
                    children: [
                      TCategoriesSection(
                        title: "Popular Categories",
                        showActionButton: false,
                      ),

                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      // Categories
                      HomeCategories(),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

