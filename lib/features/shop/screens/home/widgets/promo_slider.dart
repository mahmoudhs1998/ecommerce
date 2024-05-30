import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_image_container.dart';
import 'package:ecommerce/features/shop/controllers/banner_controller.dart';
import 'package:ecommerce/features/shop/controllers/home_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/shimmer.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TPromoSlider extends StatelessWidget {
  // final List<String> banners;
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(
      (){
        // Loader
        if (controller.isLoading.value)return const TShimmerEffect(height: 190, width: double.infinity);

        // No Data Found
        if(controller.banners.isEmpty){
          return const Center(
            child: Text(
              'No Data Found',
              style: TextStyle(
                color: TColors.grey,
              ),
            ),
          );
        }else{
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, _) => controller.updateCarousalSlider(index),
                ),
                items:controller.banners.map((banner) => TRoundedImage(imageUrl: banner.imageUrl,isNetworkImage: true,onPressed: ()=> Get.toNamed(banner.targetScreen),)).toList(),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Center(
                child: Obx(
                      () => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < controller.banners.length; i++)
                        TCircularContainer(
                            margin: const EdgeInsets.only(right: 10),
                            backgroundColor: controller.carousalCurrentIndex == i
                                ? TColors.primaryColor
                                : TColors.grey,
                            width: 20,
                            height: 4),
                    ],
                  ),
                ),
              ),
            ],
          );
        }


      }

    );
  }
}
