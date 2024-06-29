// import 'package:ecommerce/features/shop/controllers/rating/rating_controller.dart';
// import 'package:ecommerce/utils/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// class RatingBarStars extends StatelessWidget {
//   final double rating;
//   const RatingBarStars({super.key, required this.rating});

//   @override
//   Widget build(BuildContext context) {
//     final rating = Get.put(RatinggController());

//     return RatingBarIndicator(
//       rating: rating.rating.value,
//       itemSize: 20,
//       unratedColor: TColors.grey,
//       itemBuilder: (_, __) {
//         return const Icon(Iconsax.star1, color: TColors.primaryColor);
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class RatingBarStars extends StatelessWidget {
//   final double rating;
//   const RatingBarStars({super.key, required this.rating});

//   @override
//   Widget build(BuildContext context) {
//     // final rating = Get.put(RatingController());
//     final rating = Get.put(RatingController());

//     return RatingBar.builder(
//       initialRating: rating.rating.toDouble(),
//       minRating: 1,
//       direction: Axis.horizontal,
//       allowHalfRating: true,
//       itemCount: 5,
//       itemSize: 20.0,
//       unratedColor: Colors.grey,
//       itemBuilder: (context, _) => const Icon(
//         Icons.star,
//         color: Colors.blue,
//       ),
//       onRatingUpdate: (newRating) {
//         rating.updateRating(newRating);
//         rating.rating.value = newRating;
//       },
//     );
//   }
// }
class RatingBarStars extends StatelessWidget {
  final double rating;
  final  void Function(double) onRatingUpdate;

  const RatingBarStars({super.key, required this.rating, required this.onRatingUpdate});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 20.0,
      unratedColor: Colors.grey,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.blue,
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}

class UserRatingBarStars extends StatelessWidget {
  final double rating;

  const UserRatingBarStars({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    //final rating = Get.put(RatingController());

    return RatingBar.builder(
      initialRating: 4.8, // rating.rating.toDouble(),
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 20.0,
      unratedColor: Colors.grey,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.blue,
      ),
      onRatingUpdate: (newRating) {
        // rating.updateRating(newRating);
      },
    );
  }
}
