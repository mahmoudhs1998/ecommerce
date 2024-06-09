import 'package:ecommerce/common/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/cart/product_cards/product_card_vertical.dart';
import 'package:ecommerce/common/widgets/icons/custom_circular_icon.dart';
import 'package:ecommerce/features/shop/controllers/product/favourites_controller.dart';
import 'package:ecommerce/features/shop/screens/home/home_screen.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/constants/shimmer.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../zBottom_navigation_bar/navigation_menu.dart';
import '../../models/product_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteController = FavouritesController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'WishList',
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(() =>
             FutureBuilder(
                future: favoriteController.favoriteProducts(),
                builder: (context, snapshot) {

                  /// Nothing Found Widget
                  final emptyWidget = TAnimationLoaderWidget(
                    text: 'Whoops! Wishlist is Empty.',
                    animation: TImages.shopAnimation,
                    showAction: true,
                    actionText: 'Let\'s add some',
                    onActionPressed: () =>
                        Get.off(() => const NavigationMenu()),
                  ); // TAnimationLoaderWidget

                  const loader = TVerticalProductShimmer(itemCount: 6);
                  final widget = CloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                      nothingFound: emptyWidget);
                  if (widget != null) return widget;

                  final products = snapshot.data!;
                  return TGridLayout(
                      itemCount: products.length,
                      itemBuilder: (_, index) =>
                          TProductCardVertical(product: products[index]));
                }
            ),
          ),
        ),
      ),
    );
  }
}
