import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/checkout/order_controller.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_images_slider.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../../admin/coupon.dart';
import '../../../../localization/locale_controller.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../../../utils/popups/loaders.dart';
import '../../controllers/cart/cart_controller.dart';
import '../../controllers/product/product_controller.dart';
import '../../models/product_model.dart';
import '../product_reviews/widgets/models.dart';
import '../product_reviews/widgets/new_test_reviews.dart';
import 'widgets/bottom_add_to_cart_widget.dart';
import 'widgets/product_meta_data.dart';

// class ProductDetailsScreen extends StatelessWidget {
//   final ProductModel product;
//
//   const ProductDetailsScreen({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     final orderController = Get.put(OrderController());
//     final cartController = CartController.instance;
//
//     final subTotal = cartController.totalCartPrice.value;
//     final totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, 'US');
//     print(
//         'Description=========================================== ${product.description!.isEmpty}======================================================');
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(children: [
//           // 1 -- Product Image Slider
//           TProductImageSlider(
//             product: product,
//           ),
//
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
//                 TProductMetaData(product: product),
//                 const SizedBox(height: TSizes.spaceBtwSections),
//               //  -- Attributes
//                 if (product.productType == ProductType.variable.toString())
//                   TProductsAttributes(product: product),
//                 if (product.productType == ProductType.variable.toString())
//                // Add this section to display colors and sizes
//                 if (product.productType == ProductType.variable.toString())
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Available Colors:', style: Theme.of(context).textTheme.subtitle1),
//                       SizedBox(height: 8),
//                       Wrap(
//                         spacing: 8,
//                         children: product.productAttributes
//                             ?.where((attr) => attr.name!.toLowerCase() == 'Color')
//                             .expand((attr) => attr.values!)
//                             .map((color) => Chip(label: Text(color)))
//                             .toList() ?? [],
//                       ),
//                       SizedBox(height: 16),
//                       Text('Available Sizes:', style: Theme.of(context).textTheme.subtitle1),
//                       SizedBox(height: 8),
//                       Wrap(
//                         spacing: 8,
//                         children: product.productAttributes
//                             ?.where((attr) => attr.name!.toLowerCase() == 'Size')
//                             .expand((attr) => attr.values!)
//                             .map((size) => Chip(label: Text(size)))
//                             .toList() ?? [],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: TSizes.spaceBtwSections),
//                 // -- Checkout Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                       onPressed: () {
//                         if (subTotal <= 0 || subTotal == null) {
//                           return TLoaders.warningSnackBar(
//                               title: 'Empty Cart',
//                               message:
//                                   'Add items in the cart in order to proceed.');
//                         } else {
//                           orderController.processOrder(totalAmount);
//                         }
//                       }, //orderController.processOrder(totalAmount),
//                       child: Text(TTexts.checkout.tr)),
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwSections),
//                 // -- Description
//                 const TCategoriesSectionHeading(
//                     title: 'Description', showActionButton: false),
//                 const SizedBox(height: TSizes.spaceBtwItems),
//                 ReadMoreText(
//                   product.description ??
//                       'This is a Product description for Blue Nike Sleeve less vest. There are more things that can be added but iIIIIIIIIIIIIIIIIII',
//                   trimLines: 2,
//                   trimMode: TrimMode.Line,
//                   trimCollapsedText: 'Show more',
//                   trimExpandedText: 'Less',
//                   moreStyle:
//                       const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
//                   lessStyle:
//                       const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
//                 ),
//
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
//                             Get.to(() => NewProductReviewsScreen(),
//                             arguments: product // const ProductReviewsScreen()
//                             ),
//                         icon: const Icon(
//                           Iconsax.arrow_right_3,
//                           size: 18,
//                         )),
//                   ],
//                 ),
//
//                 const SizedBox(height: TSizes.spaceBtwSections),
//               ])),
//         ]),
//       ),
//       bottomNavigationBar: TBottomAddToCart(product: product),
//     );
//   }
// }


class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    final cartController = Get.find<CartController>();

    final subTotal = cartController.totalCartPrice.value ?? 0.0;

    // Assuming you have a way to retrieve the user's coupon, if any.
    UserCouponModel? userCoupon = cartController.currentCoupon; // Replace with your coupon retrieval logic

    final totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, 'US', userCoupon);
    final controller = ProductController.instance;
    final LanguageController languageController = Get.put(LanguageController());


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Slider
            TProductImageSlider(product: product),

            // Product Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating & Share
                  const TRatingAndShare(),

                  const SizedBox(height: 16.0),

                  // Price, Title, Stock & Brand
                  TProductMetaData(product: product),

                  const SizedBox(height: 16.0),

                  // Attributes
                  if (product.productAttributes != null && product.productAttributes!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Attributes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8.0),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: product.productAttributes!.length,
                          itemBuilder: (context, index) {
                            final attribute = product.productAttributes![index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(attribute.name!),
                                Wrap(
                                  spacing: 8.0,
                                  children: attribute.values!.map((value) => Chip(label: Text(value))).toList(),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),

                  // Product Attributes Widget
                  if (product.productType == ProductType.variable)
                    TProductsAttributes(product: product),

                  const SizedBox(height: 16.0),

                  // Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (subTotal <= 0) {
                          TLoaders.warningSnackBar(
                            title: 'Empty Cart',
                            message: 'Add items to the cart to proceed.',
                          );
                        } else {
                          orderController.processOrder(totalAmount);
                        }
                      },
                      child: const Text('Checkout'),
                    ),
                  ),

                  const SizedBox(height: 16.0),

                  // Description
                  const TCategoriesSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(height: 8.0),
                  ReadMoreText(
                    product.description ?? 'No description available.',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 16.0),

                  Text(
                    controller.getLocalizedTitle(product),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    controller.getLocalizedDescription(product),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),


                  // Reviews
                  const Divider(),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TCategoriesSectionHeading(
                        title: 'Reviews',
                        showActionButton: false,
                      ),
                      IconButton(
                        onPressed: () => Get.to(() => NewProductReviewsScreen(), arguments: product),
                        icon: const Icon(Icons.arrow_right_alt, size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TBottomAddToCart(product: product),
    );
  }
  String getTranslation(Map<String, String>? translations, String defaultValue, String currentLanguage) {
    return translations?[currentLanguage] ?? defaultValue;
  }
}

class TranslationUtils {
  // Define the current language (this could be managed globally or from user preferences)
  static String currentLanguage = 'ar'; // or 'ar'

  // Function to get the translation or fallback to default value
  static String getTranslation(Map<String, String>? translations, String defaultValue) {
    return translations?[currentLanguage] ?? defaultValue;
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
