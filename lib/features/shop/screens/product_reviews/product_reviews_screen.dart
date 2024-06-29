// import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
// import 'package:ecommerce/utils/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../controllers/rating/rating_controller.dart';
// import 'widgets/overall_product_rating.dart';
// import 'widgets/rating_stars.dart';
// import 'widgets/user_review_card.dart';

// class ProductReviewsScreen extends StatelessWidget {
//   const ProductReviewsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //   final RatingController ratingController = Get.put(RatingController());
//     final RatinggController ratingController = Get.put(RatinggController());
//     return Scaffold(
//       // -- App Bar
//       appBar: TAppBar(
//         title: const Text(
//           'Reviews & Ratings',
//         ),
//         showBackArrow: true,
//         actions: [
//           IconButton(
//               onPressed: () => ratingController.showRatingDialog(),
//               icon: const Icon(Icons.add)),
//         ],
//       ),

//       // -- Body
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.defaultSpace),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // -- Reviews text
//               const Text(
//                   "Ratings and reviews are verified and are from people who use the same type of device that you use."),
//               const SizedBox(height: TSizes.spaceBtwItems),

//               // Overall Product Rating
//               Obx(() =>
//                   OverallProductRating(rating: ratingController.rating.value)),
//               // Rating Bar Stars
//               Obx(() => RatingBarStars(rating: ratingController.rating.value)),
//               // RatingBarStars(rating:  ratingController.rating.value),
//               Text('16.567', style: Theme.of(context).textTheme.bodySmall),
//               const SizedBox(height: TSizes.spaceBtwSections),

//               // -- List of Users Reviews Card Section
//               for (int i = 0; i < 10; i++)
//                 Obx(() =>
//                     UserReviewCard(review: ratingController.review.value)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/features/shop/controllers/rating/rate_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/rating/rating_controller.dart';
import 'widgets/overall_product_rating.dart';
import 'widgets/rating_stars.dart';
import 'widgets/user_review_card.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RatingController ratingController = Get.put(RatingController());
    final rateStars = Get.put(RateController());

    return Scaffold(
      appBar: TAppBar(
        title:  Text('Reviews & Ratings'.tr),
        showBackArrow: true,
        actions: [
          IconButton(
            onPressed: () => ratingController.showRatingDialog(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ratings and reviews are verified and are from people who use the same type of device that you use.",
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() =>
                  OverallProductRating(rating: ratingController.rating.value)),
              Obx(
                () => RatingBarStars(
                  rating: rateStars.rating.value,
                  onRatingUpdate: (newRating) {
                    rateStars.updateRating(newRating);
                  },
                ),
              ),
              Text('16.567', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),
              Obx(() {
                return Column(
                  children: ratingController.reviews.map((review) {
                    return UserReviewCard(
                      review: review,
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}






// class SubmittReviewScreen extends StatelessWidget {
//   const SubmittReviewScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final RatinggController ratingController = Get.put(RatinggController());
//     return Scaffold(
//       appBar: const TAppBar(
//         title: Text(
//           'Submit a Review',
//         ),
//         showBackArrow: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.defaultSpace),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ElevatedButton(
//                 onPressed: () => ratingController.showRatingDialog(),
//                 child: const Text("Review"),
//               ),
//               // -- Reviews text
//               const Text(
//                   "Ratings and reviews are verified and are from people who use the same type of device that you use."),
//               const SizedBox(height: TSizes.spaceBtwItems),
//               Obx(() => Text(ratingController.rating.value.toString())),
//               const SizedBox(height: TSizes.spaceBtwItems),
//               Obx(() => Text(ratingController.review.value)),
//               const SizedBox(height: TSizes.spaceBtwItems),

//               // Overall Product Rating
//               // Obx(() => OverallProductRating(rating: ratingController.rating.value)),
//               // Rating Bar Stars
//               // Obx(() => RatingBarStars(rating: ratingController.rating.value)),
//               // RatingBarStars(rating:  ratingController.rating.value),
//               Text('16.567', style: Theme.of(context).textTheme.bodySmall),
//               const SizedBox(height: TSizes.spaceBtwSections),

//               // -- List of Users Reviews Card Section
//               for (int i = 0; i < 10; i++)
//                 UserReviewCard(review: ratingController.review.value),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
