import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';

class SearchingController extends GetxController {
  static SearchingController get instance => Get.find();
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  var searchQuery = ''.obs;
  final filteredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
  }

  void handleSearch(String query) {
    // Implement your search logic here (e.g., filter a list of items).
    // You can use the value of 'query' to filter your data.
    print('Search query: $query');
  }

  void clearSearch() {
    searchController.clear();
    searchFocusNode.requestFocus();
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }
}


//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../models/product_model.dart';
//
// class SearchingController extends GetxController {
//   static SearchingController get instance => Get.find();
//   final TextEditingController searchController = TextEditingController();
//   final FocusNode searchFocusNode = FocusNode();
//   var searchQuery = ''.obs;
//   var filteredProducts = <ProductModel>[].obs;
//
//   Iterable<ProductModel> products = <ProductModel>[].obs;
//
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     searchController.addListener(() {
//       searchQuery.value = searchController.text;
//       handleSearch(searchQuery.value);
//     });
//     filteredProducts.addAll(products); // Initialize with all products
//   }
//
//   void handleSearch(String query) {
//     if (query.isEmpty) {
//       filteredProducts.assignAll(products);
//     } else {
//       filteredProducts.assignAll(
//           products.where((product) =>
//           product.title.toLowerCase().contains(query.toLowerCase()) ||
//               product.description!.toLowerCase().contains(query.toLowerCase())
//           ).toList()
//       );
//     }
//   }
//
//   void clearSearch() {
//     searchController.clear();
//     searchFocusNode.requestFocus();
//     filteredProducts.assignAll(products); // Reset to all products
//   }
//
//   @override
//   void onClose() {
//     searchController.dispose();
//     searchFocusNode.dispose();
//     super.onClose();
//   }
//}