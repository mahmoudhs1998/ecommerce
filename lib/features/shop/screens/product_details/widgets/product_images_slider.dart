import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_image_container.dart';
import 'package:ecommerce/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ecommerce/features/shop/controllers/product/images_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../models/product_model.dart';

class TProductImageSlider extends StatelessWidget {
  final ProductModel product;
  const TProductImageSlider({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);
    final isDark = THelperFunctions.isDarkMode(context);

    return TCustomCurvedEdgesWidget(
      child: Container(
        color: isDark ? TColors.darkGrey : TColors.light,
        child: Stack(children: [
          // -- Product Main Large Image
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
              child: Center(
                child: Obx(() {
                  final image = controller.selectProductImage.value;
                  return GestureDetector(
                    onTap: ()=> controller.showEnlargedImage(image),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      progressIndicatorBuilder: (_,__, downloadProgress) => CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: TColors.primaryColor,
                      ),
                    ),
                  );
                  //Image.asset(TImages.banner5);
                }),
              ),
            ),
          ),

          /// Image Slider
          Positioned(
            right: 0,
            bottom: 30,
            left: TSizes.defaultSpace,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                itemCount: images.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (_, __) =>
                    const SizedBox(width: TSizes.spaceBtwItems),
                itemBuilder: (_, index) => Obx(
                  (){
                    final imageSelected = controller.selectProductImage.value == images[index];
                    return TRoundedImage(
                      isNetworkImage: true,
                      width: 80,
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      border: Border.all(color: imageSelected ? TColors.primaryColor : Colors.transparent),
                      padding: const EdgeInsets.all(TSizes.sm),
                      imageUrl: images[index],
                      onPressed: ()=>controller.selectProductImage.value = images[index],
                    );
                  }
                ), // TRoundedImage
              ), // ListView.separated
            ), // SizedBox
          ),
          // -- Appbar with back arrow and heart icon
          const TAppBar(
            showBackArrow: true,
            actions: [
              Icon(Iconsax.heart5, color: Colors.red),
            ],
          ),
        ]),
      ),
    );
  }
}
