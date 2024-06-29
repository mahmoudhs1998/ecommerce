// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../personalization/controllers/user_controller.dart';
// import '../../../controllers/review/review_controller.dart';
// import '../../../models/review/review_model.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//
// class SubmitReviewScreen extends StatelessWidget {
//   SubmitReviewScreen({super.key});
//
//   final ReviewController reviewController = Get.put(ReviewController());
//   final UserController userController = Get.put(UserController());
//   final TextEditingController reviewTextController = TextEditingController();
//   final RxDouble rating = 0.0.obs;
//
//   @override
//   Widget build(BuildContext context) {
//     // Fetch current user
//     final currentUser = userController.user.value;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Submit a Review'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Rating:'),
//             Obx(() => RatingBar.builder(
//               initialRating: rating.value,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: true,
//               itemCount: 5,
//               itemBuilder: (context, _) => const Icon(
//                 Icons.star,
//                 color: Colors.blue,
//               ),
//               onRatingUpdate: (newRating) {
//                 rating.value = newRating;
//               },
//             )),
//             const SizedBox(height: 16.0),
//             const Text('Review:'),
//             TextField(
//               controller: reviewTextController,
//               maxLines: 5,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () async {
//                 final review = Review(
//                   reviewText: reviewTextController.text,
//                   rating: rating.value,
//                   date: DateTime.now().toString(),
//                   user: currentUser,
//                 );
//                 await reviewController.addReview(review);
//                 Get.back();
//               },
//               child: const Text('Submit Review'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
