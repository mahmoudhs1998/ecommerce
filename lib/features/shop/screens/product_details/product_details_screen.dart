import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_images_slider.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:ecommerce/features/shop/screens/product_reviews/product_reviews_screen.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../../utils/constants/enums.dart';
import '../../models/product_model.dart';
import 'widgets/bottom_add_to_cart_widget.dart';
import 'widgets/product_meta_data.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    print('Description=========================================== ${product.description!.isEmpty}======================================================');
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          // 1 -- Product Image Slider
          TProductImageSlider(
            product: product,
          ),

          // 2 -- Product Details
          Padding(
              padding: const EdgeInsets.only(
                  left: TSizes.defaultSpace,
                  right: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(children: [
                // -- Rating & Share
                const TRatingAndShare(),
                // -- Price , Title , Stock & Brand
                TProductMetaData(product: product),
                const SizedBox(height: TSizes.spaceBtwSections),
                // -- Attributes
                if(product.productType == ProductType.variable.toString()) TProductsAttributes(product: product),
                if(product.productType == ProductType.variable.toString())const SizedBox(height: TSizes.spaceBtwSections),
                // -- Checkout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text('CheckOut')),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                // -- Description
                const TCategoriesSectionHeading(
                    title: 'Description', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),
                 ReadMoreText(
                  product.description ?? 'This is a Product description for Blue Nike Sleeve less vest. There are more things that can be added but iIIIIIIIIIIIIIIIIII',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Less',
                  moreStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  lessStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),


                // -- Reviews
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TCategoriesSectionHeading(
                        title: 'Reviews(199)', showActionButton: false),
                    IconButton(
                        onPressed: () =>
                            Get.to(() => const ProductReviewsScreen()),
                        icon: const Icon(
                          Iconsax.arrow_right_3,
                          size: 18,
                        )),
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwSections),
              ])),
        ]),
      ),
      bottomNavigationBar:  TBottomAddToCart(product: product),
    );
  }
}



// class Test2 extends StatelessWidget {
//   const Test2({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(children: [
//           // 1 -- Product Image Slider
//           const TProductImageSlider(),

//           // 2 -- Product Details
//           Padding(
//               padding: const EdgeInsets.only(
//                   left: TSizes.defaultSpace,
//                   right: TSizes.defaultSpace,
//                   bottom: TSizes.defaultSpace),
//               child: Column(children: [
//                 // -- Rating & Share
//                 const TRatingAndShare(),
//                 // -- Price , Title , Stock & Brand
//                 const TProductMetaData(),
//                 const SizedBox(height: TSizes.spaceBtwSections),
//                 // -- Attributes
//                 const TProductsAttributes(),
//                 const SizedBox(height: TSizes.spaceBtwSections),
//                 // -- Checkout Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                       onPressed: () {}, child: const Text('CheckOut')),
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwSections),
//                 // -- Description
//                 const TCategoriesSectionHeading(
//                     title: 'Description', showActionButton: false),
//                 const SizedBox(height: TSizes.spaceBtwItems),
//                 const ReadMoreText(
//                   'This is a Product description for Blue Nike Sleeve less vest. There are more things that can be added but i will add it later. then i will add it later.then i will add it later.then i will add it later.',
//                   trimLines: 2,
//                   trimMode: TrimMode.Line,
//                   trimCollapsedText: 'Show more',
//                   trimExpandedText: 'Less',
//                   moreStyle:
//                   TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
//                   lessStyle:
//                   TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
//                 ),

//                 // -- Reviews
//                 const Divider(),
//                 const SizedBox(height: TSizes.spaceBtwItems),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const TCategoriesSectionHeading(
//                         title: 'Reviews(199)', showActionButton: false),
//                     IconButton(
//                         onPressed: () =>
//                             Get.to(() => const ProductReviewsScreen()),
//                         icon: const Icon(
//                           Iconsax.arrow_right_3,
//                           size: 18,
//                         )),
//                   ],
//                 ),

//                 const SizedBox(height: TSizes.spaceBtwSections),
//               ])),
//         ]),
//       ),
//       bottomNavigationBar: const TBottomAddToCart(),
//     );
//   }
// }
