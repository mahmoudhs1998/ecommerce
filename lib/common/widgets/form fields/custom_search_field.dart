import 'package:ecommerce/common/widgets/form%20fields/rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/shop/controllers/product/product_controller.dart';
import '../../../features/shop/controllers/search/search_controller.dart';

class CustomSearchField extends StatelessWidget {
  final bool showBackGround, showBorder;
  const CustomSearchField(
      {super.key, this.showBackGround = true, this.showBorder = true});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(SearchingController());
    final controller = ProductController.instance;

    return Row(
      children: [
        Expanded(
          child: CustomFormField(
            controller: searchController.searchController,
            focusNode: searchController.searchFocusNode,
            onChanged: (value) {
              //controller.searchProductsByTitle(value);
              //controller.searchProductsByBrand(value);
              //controller.searchProducts(value);
              ProductController.instance.searchLocalizedProducts(value);

            },
            labelText: 'Search'.tr,
            prefixIcon: Icons.search,
            suffixPressed: searchController.clearSearch,
          ),
        ),
      ],
    );
  }
}
