import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/all_product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../layouts/grid_layout.dart';
import '../../cart/product_cards/product_card_vertical.dart';

class SortableProducts extends StatelessWidget {
  final List<ProductModel> products;
  const SortableProducts({
    super.key, required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);

    return Column(
      children: [
        // Dropdown
        DropdownButtonFormField(
          value: controller.selectedSortOption.value,
          decoration:
              const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {
            // sort products based on the selected option
            controller.sortProducts(value!);
          },
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity'
          ]
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        // Products
        Obx(
          ()=> TGridLayout(
              itemCount: controller.products.length,
              itemBuilder: (_, index) =>  TProductCardVertical(product: controller.products[index],)),
        ),
      ],
    );
  }
}
