import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  // Variables
  RxString selectProductImage = ''.obs;

  // -- get all images from product and variations
  List<String> getAllProductImages(ProductModel product) {
    // use set to add unique images only

    Set<String> images = {};

    // Load Thumbnail Image
    images.add(product.thumbnail);

    // Assign Thumbnail as selectedImage
    selectProductImage.value = product.thumbnail;

    // -- get all images from ProductModel if not null
    if (product.images != null) {
      images.addAll(product.images!);
    }

    // -- get all images from Product Variations if not null
    if (product.productVariations != null ||
        product.productVariations!.isNotEmpty) {
      images.addAll(
          product.productVariations!.map((variation) => variation.image));
    }
    return images.toList();
  }

  // -- show Image Popup

  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: TSizes.defaultSpace * 2,
                  horizontal: TSizes.defaultSpace),
              child: CachedNetworkImage(imageUrl: image),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                    onPressed: () => Get.back(), child: const Text('Close')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
