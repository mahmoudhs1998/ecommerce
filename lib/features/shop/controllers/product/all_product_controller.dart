import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/repositories/product/product_repository.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';



// class AllProductsController extends GetxController {
//   static AllProductsController get instance => Get.find();
//
//   final ProductRepository repository = ProductRepository.instance;
//   final RxString selectedSortOption = 'Name'.obs;
//   final RxList<ProductModel> products = <ProductModel>[].obs;
//
//   Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
//     if (query == null) return [];
//     try {
//       final fetchedProducts = await repository.fetchProductsByQuery(query);
//       return fetchedProducts;
//     } catch (e) {
//       TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//       return [];
//     }
//   }
//
//   void sortProducts(String sortOption) {
//     selectedSortOption.value = sortOption;
//
//     switch (sortOption) {
//       case 'Name':
//         products.sort((a, b) => a.title.compareTo(b.title));
//         break;
//       case 'Higher Price':
//         products.sort((a, b) => b.price.compareTo(a.price)); // Descending order
//         break;
//       case 'Lower Price':
//         products.sort((a, b) => a.price.compareTo(b.price)); // Ascending order
//         break;
//       case 'Newest':
//         products.sort((a, b) {
//           if (a.date == null && b.date == null) {
//             return 0;
//           } else if (a.date == null) {
//             return 1;
//           } else if (b.date == null) {
//             return -1;
//           } else {
//             return b.date!.compareTo(a.date!);
//           }
//         });
//         break;
//       case 'Sale':
//         products.sort((a, b) {
//           final saleA = a.salePrice ?? 0;
//           final saleB = b.salePrice ?? 0;
//           return saleB.compareTo(saleA);
//         });
//         break;
//       default:
//         products.sort((a, b) => a.title.compareTo(b.title));
//     }
//   }
//
//   void assignProducts(List<ProductModel> newProducts) {
//     products.assignAll(newProducts);
//     sortProducts(selectedSortOption.value); // Sort according to the selected option
//   }
// }


class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final ProductRepository repository = ProductRepository.instance;
  final RxString selectedSortOption = 'name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    if (query == null) return [];
    try {
      final fetchedProducts = await repository.fetchProductsByQuery(query);
      return fetchedProducts;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortKey) {
    selectedSortOption.value = sortKey;

    switch (sortKey) {
      case 'name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'higher_price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'lower_price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'newest':
        products.sort((a, b) {
          if (a.date == null && b.date == null) {
            return 0;
          } else if (a.date == null) {
            return 1;
          } else if (b.date == null) {
            return -1;
          } else {
            return b.date!.compareTo(a.date!);
          }
        });
        break;
      case 'sale':
        products.sort((a, b) {
          final saleA = a.salePrice ?? 0;
          final saleB = b.salePrice ?? 0;
          return saleB.compareTo(saleA);
        });
        break;
      default:
        products.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> newProducts) {
    products.assignAll(newProducts);
    sortProducts(selectedSortOption.value);
  }
}