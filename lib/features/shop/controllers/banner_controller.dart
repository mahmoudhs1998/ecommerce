import 'package:ecommerce/data/repositories/banners/banners_repository.dart';
import 'package:ecommerce/features/shop/models/banner_model.dart';
import 'package:get/get.dart';

import '../../../utils/popups/loaders.dart';

class BannerController extends GetxController
{
  static BannerController get instance => Get.find();
  // -- variables
final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
  fetchBanners();
  super.onInit();
  }


// -- update Page Navigation Dots
  void updateCarousalSlider(index) {
    carousalCurrentIndex.value = index;
  }

  // -- fetch Banners
  Future<void> fetchBanners() async {
    try {
// Show loader while loading categories
      isLoading.value = true;

// Fetch Banners
      final bannerRepo = Get.put(BannersRepository());
      final banners = await bannerRepo.fetchBanners();

// Assign Banners
      this.banners.assignAll(banners);

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
//Remove Loader
      isLoading.value = false;
    }

    /// -- Load selected category data

    /// Get Category or Sub-Category Products.
  }

}