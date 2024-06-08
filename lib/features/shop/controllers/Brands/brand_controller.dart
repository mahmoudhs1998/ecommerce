import 'package:ecommerce/data/repositories/Brand/brand_repository.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../models/brand_model.dart';
import '../../models/product_model.dart';

class BrandController extends GetxController
{
  static BrandController get instance => Get.find();
  RxBool isLoading = true.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;

  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;

  final brandRepository = Get.put(BrandRepository()) ;

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

/// -- Load Brands
Future<void> getFeaturedBrands() async {
    try {
      // show Loader While Loading the Brands
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);
      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    }catch(e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      // Stop the Loader
      isLoading.value = false;
    }
}

  /// -- Get Brands For Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      TLoaders.errorSnackBar(title: '0h Snap!', message: e.toString());
      return [];
    }
  }


/// Get Brand Specific Products from your data source
  /// Get Brand Specific Products from your data source
  Future<List<ProductModel>> getBrandProducts(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance.getProductsForBrand(brandId: brandId , limit: limit);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: '0h Snap!', message: e.toString());
      return [];
    }
  }
}