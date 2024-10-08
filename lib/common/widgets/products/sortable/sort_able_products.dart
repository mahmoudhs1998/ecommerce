// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// import '../../../../features/shop/controllers/product/all_product_controller.dart';
// import '../../../../features/shop/models/product_model.dart';
// import '../../../../utils/constants/sizes.dart';
// import '../../../layouts/grid_layout.dart';
// import '../../cart/product_cards/product_card_vertical.dart';

// class SortableProducts extends StatelessWidget {
//   final List<ProductModel> products;
//   const SortableProducts({
//     super.key, required this.products,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(AllProductsController());
//     controller.assignProducts(products);
//     final dropdownItems = [
//       'Name'.tr,
//       'Higher Price'.tr,
//       'Lower Price'.tr,
//       'Sale'.tr,
//       'Newest'.tr,
//       'Popularity'.tr
//     ];

//     // Make sure the initial value is one of the localized items
//     controller.selectedSortOption.value = dropdownItems.first;

//     return Column(
//       children: [
//         // Dropdown
//         DropdownButtonFormField(
//           value: controller.selectedSortOption.value,
//           decoration:
//               const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
//           onChanged: (value) {
//             // sort products based on the selected option
//             controller.sortProducts(value!);
//           },
//           items: [
//             'Name',
//             'Higher Price',
//             'Lower Price',
//             'Sale',
//             'Newest',
//             'Popularity'
//           ]

//               .map((option) =>
//                   DropdownMenuItem(value: option, child: Text(option)))
//               .toList(),
//         ),
//         const SizedBox(height: TSizes.spaceBtwSections),
//         // Products
//         Obx(
//           ()=> TGridLayout(
//               itemCount: controller.products.length,
//               itemBuilder: (_, index) =>  TProductCardVertical(product: controller.products[index],)),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/all_product_controller.dart';
import '../../../../features/shop/models/category_model.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../layouts/grid_layout.dart';
import '../../cart/product_cards/product_card_vertical.dart';



// class SortableProducts extends StatelessWidget {
//   final List<ProductModel> products;
//
//   const SortableProducts({
//     Key? key,
//     required this.products,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(AllProductsController());
//     controller.assignProducts(products);
//
//     final dropdownItems = [
//       'Name'.tr,
//       'Higher Price'.tr,
//       'Lower Price'.tr,
//       'Sale'.tr,
//       'Newest'.tr,
//       'Popularity'.tr
//     ];
//
//     // Ensure that the selected sort option is within the localized dropdown items
//     if (!dropdownItems.contains(controller.selectedSortOption.value)) {
//       controller.selectedSortOption.value = dropdownItems.first;
//     }
//
//     return Column(
//       children: [
//         DropdownButtonFormField<String>(
//           value: controller.selectedSortOption.value,
//           decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
//           onChanged: (value) {
//             if (value != null) {
//               controller.sortProducts(value);
//             }
//           },
//           items: dropdownItems.map((option) {
//             return DropdownMenuItem<String>(
//               value: option,
//               child: Text(option),
//             );
//           }).toList(),
//         ),
//         const SizedBox(height: TSizes.spaceBtwSections),
//         Obx(
//               () => TGridLayout(
//             itemCount: controller.products.length,
//             itemBuilder: (_, index) => TProductCardVertical(product: controller.products[index]),
//           ),
//         ),
//       ],
//     );
//   }
// }


class SortableProducts extends StatelessWidget {
  final List<ProductModel> products;

  const SortableProducts({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);

    // Mapping of sort keys to localized display text
    final sortOptions = {
      'name': 'Name'.tr,
      'higher_price': 'Higher Price'.tr,
      'lower_price': 'Lower Price'.tr,
      'sale': 'Sale'.tr,
      'newest': 'Newest'.tr,
      'popularity': 'Popularity'.tr,
    };

    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: controller.selectedSortOption.value,
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {
            if (value != null) {
              controller.sortProducts(value);
            }
          },
          items: sortOptions.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text(entry.value),
            );
          }).toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        Obx(
              () => TGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) => TProductCardVertical(product: controller.products[index]),
          ),
        ),
      ],
    );
  }
}





class SortableCategories extends StatefulWidget {
  final List<CategoryModel> subCategories;

  const SortableCategories({Key? key, required this.subCategories}) : super(key: key);

  @override
  _SortableCategoriesState createState() => _SortableCategoriesState();
}

class _SortableCategoriesState extends State<SortableCategories> {
  String _selectedSort = 'Name';

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> sortedCategories = List.from(widget.subCategories);

    // Sorting logic based on selected sort option
    if (_selectedSort == 'Name') {
      sortedCategories.sort((a, b) => a.name.compareTo(b.name));
    } else if (_selectedSort == 'Date') {
      // Replace with appropriate date property
      sortedCategories.sort((a, b) => a.parentId.compareTo(b.parentId));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: DropdownButtonFormField<String>(
            value: _selectedSort,
            decoration: const InputDecoration(
              labelText: 'Sort by',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedSort = value;
                });
              }
            },
            items: [
              DropdownMenuItem(child: Text('Name'), value: 'Name'),
              DropdownMenuItem(child: Text('Date'), value: 'Date'),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: sortedCategories.length,
            itemBuilder: (context, index) {
              final category = sortedCategories[index];
              return ListTile(
                title: Text(category.name),
                leading: Image.network(category.image),
                onTap: () {
                  // Handle category tap, e.g., navigate to a details screen
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
