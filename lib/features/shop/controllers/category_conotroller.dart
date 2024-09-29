import 'package:ecommerce/data/repositories/category/category_repository.dart';
import 'package:get/get.dart';

import '../../../data/repositories/product/product_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

// -- Load category data

  Future<void> fetchCategories() async {
    try {
// Show loader while loading categories
    isLoading.value = true;

// Fetch categories from data source (Firestore, API, etc.)
    final categories = await _categoryRepository.getAllCategories();

// Update the categories list
    allCategories.assignAll(categories);

// Filter featured categories
    featuredCategories.assignAll(
        allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
//Remove Loader
    isLoading.value = false;
    }

    /// -- Load selected category data

    /// Get Category or Sub-Category Products.
  }


// -- Load Selected Category or Sub-Category Products  Data

  // Future<List<CategoryModel>> getSubCategories(String categoryId) async {
  //   try {
  //         final subCategories = await _categoryRepository.getSubCategories(categoryId);
  //         return subCategories;
  //   }catch(e){
  //     TLoaders.errorSnackBar(title: 'OH Snap!' , message: e.toString());
  //     return [];
  //   }
  // }

  // Future<List<CategoryModel>> getSubCategories(String categoryId) async {
  //   try {
  //     final subCategories = await _categoryRepository.getSubCategories(categoryId);
  //     return subCategories;
  //   } catch (e) {
  //     Get.snackbar('OH Snap!', e.toString());
  //     return [];
  //   }
  // }
  Future<List<CategoryModel>> getNewSubCategories(String categoryId) async {
    try {
      final subCategories = await _categoryRepository.getNewSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      Get.snackbar('OH Snap!', e.toString());
      return [];
    }
  }
// -- Get Category or Sub-Category Products

  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async {
// Fetch limited (4) products against each subCategory;
    final products = await ProductRepository.instance.getProductsForCategory(categoryId: categoryId, limit: limit);
    return products;
  }
}
