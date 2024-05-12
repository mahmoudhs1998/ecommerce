import 'package:ecommerce/features/personalization/screens/settings/settings.dart';
import 'package:ecommerce/features/shop/screens/home/home_screen.dart';
import 'package:ecommerce/features/shop/screens/store/store_screen.dart';
import 'package:ecommerce/features/shop/screens/wishlist/wishlist.dart';
import 'package:get/get.dart';

class NavigationMenuController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [

    const HomeScreen(),
    const  StoreScreen(),
    const FavoriteScreen(),
    const SettingsScreen()
  ];
}
