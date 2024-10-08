import 'package:ecommerce/common/widgets/category_icons_with_texts/vertical_images_texts_widget.dart';
import 'package:ecommerce/features/shop/controllers/category_conotroller.dart';
import 'package:ecommerce/utils/constants/category_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helpers_functions.dart';
import '../../../../sub_category/new_sub_categories.dart';
import '../../../../sub_category/sub_categories.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.isLoading.value) return const TCategoryShimmer();
      if (categoryController.featuredCategories.isEmpty) {
        return Center(
            child: Text('No ota Found!',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: Colors.white)));
      }
      return SizedBox(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return TVerticalImageText(
              backgroundColor: THelperFunctions.isDarkMode(context)
                  ? TColors.light
                  : TColors.dark,
              isNetworkImage: true,
              title: category.name,
              image: category.image, //TImages.category1,
              onTap: () => Get.to(() =>
              NewSubCategoriesScreen(category:category) // SubCategoriesScreen(category: category)
              ),

            );

          },

        ),

      );

    });
  }
}
