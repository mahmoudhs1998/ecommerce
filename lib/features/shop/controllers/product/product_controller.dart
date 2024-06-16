import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }
  void searchProductsByTitle(String query)async {
    final products = await productRepository.getFeaturedProducts();
    if (query.isEmpty) {
      featuredProducts.assignAll(products);
    } else {
      var filteredProducts = products.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      featuredProducts.assignAll(filteredProducts);
    }
  }
  // Fetch the featured products
  void fetchFeaturedProducts() async {
    // Show loader while loading the products
    isLoading.value = true;
    // fetch the products
    final products = await productRepository.getFeaturedProducts();
    // Assign the products
    featuredProducts.assignAll(products);
    try {
      // // Show loader while loading the products
      // isLoading.value = true;
      // // fetch the products
      // final products = await productRepository.getFeaturedProducts();
      // // Assign the products
      // featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'oh no!!!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch All featured products
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {



    try {
      // fetch the products
      final products = await productRepository.getFeaturedProducts();
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'oh no!!!', message: e.toString());
      return <ProductModel>[];
    }
  }

  // Get the Product Price or Price Range for Variations
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;
    // If no variations exist, return the simple price or sale price
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      // Calculate the smallest and largest prices among variations
      for (var variation in product.productVariations!) {
        // Determine the price to consider (sale price if available, otherwise regular price)
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;
        // Update smallest and largest prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }
      // If smallest and largest prices are the same, return a single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
// Otherwise, return a price range
     return '$smallestPrice - \$$largestPrice';
      //  return '$smallestPrice';
      }
    }
  }

  /// -- Calculate Discount Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return '0';
    if (originalPrice <= 0) return '0';

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  /// -- Check Product Stock Status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
