import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../admin/translation_test.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  var post = Rxn<ProductModel>();
  final RxMap<String, String> titleTranslations = <String, String>{}.obs;
  final RxMap<String, String> descriptionTranslations = <String, String>{}.obs;


  @override
  void onInit() {
    fetchFeaturedProducts();
    loadValidCategoryIds();
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
  final products = <ProductModel>[].obs;
  // Method to fetch product details by ID
  // Observable property for selected product
  var selectedProduct = Rx<ProductModel?>(null);
  // Method to fetch product details by ID
  var errorMessage = Rx<String?>(null);

  void getProductDetails(String productId) {
    isLoading.value = true;
    errorMessage.value = null;

    productRepository.getProductById(productId).listen((productData) {
      if (productData == null) {
        errorMessage.value = "No products found";
        selectedProduct.value = null;
      } else {
        selectedProduct.value = productData;
      }
      isLoading.value = false;
    }).onError((error) {
      errorMessage.value = "Error fetching product details";
      isLoading.value = false;
    });
  }
  // void getProductsByCategory(String categoryId) {
  //   productRepository.getProductsByCategory(categoryId).listen((productsData) {
  //     products.assignAll(productsData);
  //   });
  // }
  var validCategoryIds = <String>{}.obs; // To store valid category IDs
  // Fetch valid CategoryIds from Categories
  Future<void> loadValidCategoryIds() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Categories')
          .get();

      validCategoryIds.value = querySnapshot.docs
          .map((doc) => doc.id.trim()) // Ensure IDs are trimmed of whitespace
          .toSet();

      print('Loaded valid Category IDs: $validCategoryIds'); // Debug print
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  // Fetch products by CategoryId
  Future<void> getProductsByCategory(String categoryId) async {
    // Ensure CategoryId is valid
    if (!validCategoryIds.contains(categoryId)) {
      print('Invalid CategoryId: $categoryId');
      products.clear();
      return;
    }

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('CategoryId', isEqualTo: categoryId) // Query by CategoryId
          .get();

      print('Query Snapshot Size: ${querySnapshot.size}'); // Debug print
      products.value = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      print('Error fetching products: $e');
      products.clear();
    }
  }
  Future<void> getProducts() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('CategoryId', whereIn: validCategoryIds.toList())
          .get();

      print('Query Snapshot Size: ${querySnapshot.size}'); // Debug print
      products.value = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      print('Error fetching products: $e');
      products.clear();
    }
  }

  //   try {
  //     final querySnapshot = await FirebaseFirestore.instance
  //         .collection('Products')
  //         .where('CategoryId', isEqualTo: categoryId)
  //         .get();
  //
  //     products.value = querySnapshot.docs
  //         .map((doc) => ProductModel.fromQuerySnapshot(doc))
  //         .toList();
  //   } catch (e) {
  //     print('Error fetching products: $e');
  //     products.clear();
  //   }
  // }

  // Fetch products by category ID
  void fetchProductsByCategoryId(String categoryId) {
    isLoading.value = false;
    errorMessage.value = null;

    productRepository.getProductsByCategoryId(categoryId).listen((productList) {
      if (productList.isEmpty) {
        errorMessage.value = "No products found";
      } else {
        products.value = productList;
      }
      isLoading.value = false;
    }).onError((error) {
      errorMessage.value = "Error fetching products";
      isLoading.value = false;
    });
  }
   void searchProductsByBrand(String brandName) async {
    final products = await productRepository.getFeaturedProducts();
    if (brandName.isEmpty) {
      featuredProducts.assignAll(products);
    } else {
      var filteredProducts = products.where((product) {
        return product.brand!.name.toLowerCase().contains(brandName.toLowerCase());
      }).toList();
      featuredProducts.assignAll(filteredProducts);
    }
  }

    void searchProducts(String query) async {
    final products = await productRepository.getFeaturedProducts();
    if (query.isEmpty) {
      featuredProducts.assignAll(products);
    } else {
      var filteredProducts = products.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase()) ||
               product.brand!.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      featuredProducts.assignAll(filteredProducts);
    }
  }
  // Fetch the featured products
  void fetchFeaturedProducts() async {

    try {
      // // Show loader while loading the products
      // isLoading.value = true;
      // // fetch the products
      // final products = await productRepository.getFeaturedProducts();
      // // Assign the products
      // featuredProducts.assignAll(products);
      // Show loader while loading the products
      isLoading.value = true;
      // fetch the products
      final products = await productRepository.getFeaturedProducts();
      // Assign the products
      featuredProducts.assignAll(products);

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

  /// Translations
///
///
//   String getTitle() {
//     String currentLang = Get.locale?.languageCode ?? english.tr;
//     return post.value?.titleTranslations?[currentLang] ?? post.value?.titleTranslations?[english]?.tr ?? 'No Title';
//   }
//
//   String getDescription() {
//     String currentLang = Get.locale?.languageCode ?? english.tr;
//     return post.value?.descriptionTranslations?[currentLang] ?? post.value?.descriptionTranslations?[english]?.tr ?? 'No Description';
//   }

  void searchLocalizedProducts(String query) async {
    final products = await productRepository.getFeaturedProducts();
    if (query.isEmpty) {
      featuredProducts.assignAll(products);
    } else {
      String locale = Get.locale?.languageCode ?? 'en';
      var filteredProducts = products.where((product) {
        String productName = product.title.toLowerCase();
        String? translatedName = product.titleTranslations?[locale]?.toLowerCase();
        String? translatedDescription = product.descriptionTranslations?[locale]?.toLowerCase();

        return productName.contains(query.toLowerCase()) ||
            (translatedName != null && translatedName.contains(query.toLowerCase())) ||
            (translatedDescription != null && translatedDescription.contains(query.toLowerCase()));
      }).toList();
      featuredProducts.assignAll(filteredProducts);
    }
  }


  String getLocalizedTitle(ProductModel product) {
    String locale = Get.locale?.languageCode ?? 'en';
    return product.titleTranslations?[locale] ?? product.titleTranslations?['en'] ?? product.title;
  }

  String getLocalizedDescription(ProductModel product) {
    String locale = Get.locale?.languageCode ?? 'en';
    return product.descriptionTranslations?[locale] ?? product.descriptionTranslations?['en'] ?? product.description ?? '';
  }


  String getTitle() {
    String currentLang = Get.locale?.languageCode ?? 'en';
    print("Current locale: $currentLang");
    print("Title translations: ${post.value?.titleTranslations}");

    if (post.value?.titleTranslations == null) {
      return post.value?.title ?? 'No Title';
    }

    return post.value!.titleTranslations![currentLang] ??
        post.value!.titleTranslations!['en'] ??
        post.value!.title ??
        'No Title';
  }

  String getDescription() {
    String currentLang = Get.locale?.languageCode ?? 'en';
    print("Current locale: $currentLang");
    print("Description translations: ${post.value?.descriptionTranslations}");

    if (post.value?.descriptionTranslations == null) {
      return 'No Description';
    }

    return post.value!.descriptionTranslations![currentLang] ??
        post.value!.descriptionTranslations!['en'] ??
        'No Description';
  }
  // Method to load post data
  void loadPost(Map<String, dynamic> data) {
    post.value = ProductModel.fromJson(data);
    update(); // Notify listeners
  }
}
