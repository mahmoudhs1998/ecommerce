import 'dart:convert';

import 'package:ecommerce/data/repositories/product/product_repository.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/globals.dart';
import 'package:ecommerce/utils/local_storage/storage_utility.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController
{
  static FavouritesController get instance => Get.find();

  // Variables
  final RxMap<String, bool> favorites = <String,bool>{}.obs;

@override
  void onInit() {

    super.onInit();
    initFavorites();
  }

  // Method to initialize favorites by reading from storage
  Future<void> initFavorites() async {
   final json = TLocalStorage.instance().readData(Global.favoritesKey);
   if(json != null) {
     final storedFavorites = jsonDecode(json) as Map<String,dynamic>;
     favorites.assignAll(storedFavorites.map((key, value) => MapEntry(key, value as bool)));
   }
  }

  bool isFavourite(String productId){
   return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId){
   if(!favorites.containsKey(productId)){
     favorites[productId] = true;
     saveFavoritesToStorage();
     TLoaders.customToast(message: 'Product has been added to wishlist');
   }else{
     TLocalStorage.instance().removeData(productId);
     favorites.remove(productId);
     saveFavoritesToStorage();
     favorites.refresh();
     TLoaders.customToast(message: 'Product has been removed from wishlist');
   }
  }
  void  saveFavoritesToStorage(){
   final encodedFavorites = jsonEncode(favorites);
   TLocalStorage.instance().saveData(Global.favoritesKey, encodedFavorites);
  }

   Future<List<ProductModel>> favoriteProducts() async  {
     return await ProductRepository.instance.getFavouriteProducts(favorites.keys.toList());
   }
}