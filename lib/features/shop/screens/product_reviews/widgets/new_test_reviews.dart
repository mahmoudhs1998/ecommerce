// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../../authentication/models/user_model.dart';
// import '../../../models/product_model.dart';

// class ReviewModel {
//   final String userId;
//   final String review;
//   final double rating;
//   final DateTime timestamp;
//   final String userFullName;
//   final String userProfilePicture;

//   ReviewModel({
//     required this.userId,
//     required this.review,
//     required this.rating,
//     required this.timestamp,
//     required this.userFullName,
//     required this.userProfilePicture,
//   });

//   factory ReviewModel.fromJson(Map<String, dynamic> json) {
//     return ReviewModel(
//       userId: json['userId'],
//       review: json['review'],
//       rating: json['rating'].toDouble(),
//       timestamp: (json['timestamp'] as Timestamp).toDate(),
//       userFullName: json['userFullName'] ?? '',
//       userProfilePicture: json['userProfilePicture'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'userId': userId,
//       'review': review,
//       'rating': rating,
//       'timestamp': timestamp,
//       'userFullName': userFullName,
//       'userProfilePicture': userProfilePicture,
//     };
//   }
// }

// //-----------

// class ReviewController extends GetxController {
//   var reviews = <ReviewModel>[].obs;
//   var rating = 0.0.obs;

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   late User? _user;
//   late UserModel _currentUser;

//   @override
//   void onInit() {
//     super.onInit();
//     _user = _auth.currentUser;
//     _fetchCurrentUser();
//   }

//   void _fetchCurrentUser() async {
//     DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
//         .instance
//         .collection('Users')
//         .doc(_user!.uid)
//         .get() as DocumentSnapshot<Map<String, dynamic>>;

//     if (userDoc.exists && userDoc.data() != null) {
//       _currentUser = UserModel.fromSnapshot(userDoc);
//     } else {
//       // Handle the case where the user document doesn't exist or is empty
//       print('User document not found or empty');
//       // You might want to set _currentUser to a default value or handle this case differently
//     }
//   }

//   void fetchReviews(String productId) {
//     FirebaseFirestore.instance
//         .collection('Products')
//         .doc(productId)
//         .collection('reviews')
//         .orderBy('timestamp', descending: true)
//         .snapshots()
//         .listen((snapshot) {
//       reviews.value = snapshot.docs
//           .map(
//               (doc) => ReviewModel.fromJson(doc.data() as Map<String, dynamic>))
//           .toList();

//       updateOverallRating();
//     });
//   }

//   void updateOverallRating() {
//     if (reviews.isEmpty) {
//       rating.value = 0;
//     } else {
//       double total = reviews.fold(0, (sum, item) => sum + item.rating);
//       rating.value = total / reviews.length;
//     }
//   }

//   void addOrUpdateReview(String productId, {ReviewModel? existingReview}) {
//     String? reviewText = existingReview?.review ?? '';
//     double ratingValue = existingReview?.rating ?? 0.0;

//     Get.defaultDialog(
//       title: existingReview != null ? 'Edit Review' : 'Add Review',
//       content: Column(
//         children: [
//           TextField(
//             controller: TextEditingController(text: reviewText),
//             onChanged: (value) => reviewText = value,
//             decoration: InputDecoration(labelText: 'Review'),
//           ),
//           SizedBox(height: 16.0),
//           RatingBar(
//             initialRating: ratingValue,
//             minRating: 1,
//             direction: Axis.horizontal,
//             allowHalfRating: false,
//             itemCount: 5,
//             ratingWidget: RatingWidget(
//               full: Icon(Icons.star, color: Colors.amber),
//               half: Icon(Icons.star_half, color: Colors.amber),
//               empty: Icon(Icons.star_border, color: Colors.amber),
//             ),
//             itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//             onRatingUpdate: (value) => ratingValue = value,
//           ),
//         ],
//       ),
//       actions: [
//         ElevatedButton(
//           onPressed: () {
//             if (reviewText != null && reviewText!.isNotEmpty) {
//               ReviewModel newReview = ReviewModel(
//                 userId: _user!.uid,
//                 review: reviewText!,
//                 rating: ratingValue,
//                 timestamp: DateTime.now(),
//                 userFullName: _currentUser.fullName,
//                 userProfilePicture: _currentUser.profilePicture,
//               );

//               if (existingReview != null) {
//                 _updateReview(productId, existingReview.userId, newReview);
//               } else {
//                 _addReview(productId, newReview);
//               }

//               Get.back();
//             } else {
//               Get.snackbar('Error', 'Please enter a review.');
//             }
//           },
//           child: Text(existingReview != null ? 'Update' : 'Save'),
//         ),
//         TextButton(
//           onPressed: () => Get.back(),
//           child: Text('Cancel'),
//         ),
//       ],
//     );
//   }

//   void _addReview(String productId, ReviewModel review) {
//     FirebaseFirestore.instance
//         .collection('Products')
//         .doc(productId)
//         .collection('reviews')
//         .add(review.toJson())
//         .then((_) => Get.snackbar('Success', 'Review added successfully'))
//         .catchError(
//             (error) => Get.snackbar('Error', 'Failed to add review: $error'));
//   }

//   void _updateReview(
//       String productId, String oldUserId, ReviewModel newReview) {
//     FirebaseFirestore.instance
//         .collection('Products')
//         .doc(productId)
//         .collection('reviews')
//         .where('userId', isEqualTo: oldUserId)
//         .get()
//         .then((snapshot) {
//       for (DocumentSnapshot doc in snapshot.docs) {
//         doc.reference.update(newReview.toJson());
//       }
//       Get.snackbar('Success', 'Review updated successfully');
//     }).catchError((error) =>
//             Get.snackbar('Error', 'Failed to update review: $error'));
//   }

//   void deleteReview(String productId, String userId) {
//     FirebaseFirestore.instance
//         .collection('Products')
//         .doc(productId)
//         .collection('reviews')
//         .where('userId', isEqualTo: userId)
//         .get()
//         .then((snapshot) {
//       for (DocumentSnapshot doc in snapshot.docs) {
//         doc.reference.delete();
//       }
//       Get.snackbar('Success', 'Review deleted successfully');
//     }).catchError((error) =>
//             Get.snackbar('Error', 'Failed to delete review: $error'));
//   }
// }

// // class NewProductReviewsScreen extends StatelessWidget {
// //   NewProductReviewsScreen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     final ReviewController reviewController = Get.put(ReviewController());

// //     final ProductModel? product = Get.arguments as ProductModel?;

// //     if (product == null) {
// //       return Scaffold(
// //         appBar: AppBar(title: Text('Error')),
// //         body: Center(
// //           child: Text('Product information not found.'),
// //         ),
// //       );
// //     }

// //     reviewController.fetchReviews(product.id);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Reviews & Ratings'.tr),
// //         leading: BackButton(),
// //         actions: [
// //           IconButton(
// //             onPressed: () => reviewController.addOrUpdateReview(product.id),
// //             icon: const Icon(Icons.add),
// //           ),
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const Text(
// //                 "Ratings and reviews are verified and are from people who use the same type of device that you use.",
// //               ),
// //               const SizedBox(height: 16.0),
// //               Obx(() => NewOverallProductRating(
// //                   rating: reviewController.rating.value)),
// //               Obx(() {
// //                 if (reviewController.reviews.isEmpty) {
// //                   return Center(
// //                     child: Text('No reviews yet. Be the first to review!'),
// //                   );
// //                 } else {
// //                   return Column(
// //                     children: reviewController.reviews.map((review) {
// //                       return NewUserReviewCard(
// //                         review: review,
// //                         productId: product.id,
// //                         onEdit: () {
// //                           reviewController.addOrUpdateReview(product.id,
// //                               existingReview: review);
// //                         },
// //                         onDelete: () {
// //                           reviewController.deleteReview(
// //                               product.id, review.userId);
// //                         },
// //                       );
// //                     }).toList(),
// //                   );
// //                 }
// //               }),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// class NewProductReviewsScreen extends StatelessWidget {
//   NewProductReviewsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final ReviewController reviewController = Get.put(ReviewController());
//     final ProductModel? product = Get.arguments as ProductModel?;
//     final User? user = FirebaseAuth.instance.currentUser;

//     if (product == null) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Error')),
//         body: Center(
//           child: Text('Product information not found.'),
//         ),
//       );
//     }

//     reviewController.fetchReviews(product.id);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reviews & Ratings'.tr),
//         leading: BackButton(),
//         actions: user != null
//             ? [
//                 IconButton(
//                   onPressed: () =>
//                       reviewController.addOrUpdateReview(product.id),
//                   icon: const Icon(Icons.add),
//                 ),
//               ]
//             : null,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Ratings and reviews are verified and are from people who use the same type of device that you use.",
//               ),
//               const SizedBox(height: 16.0),
//               Obx(() => NewOverallProductRating(
//                   rating: reviewController.rating.value)),
//               Obx(() {
//                 if (reviewController.reviews.isEmpty) {
//                   return Center(
//                     child: Text('No reviews yet. Be the first to review!'),
//                   );
//                 } else {
//                   return Column(
//                     children: reviewController.reviews.map((review) {
//                       return NewUserReviewCard(
//                         review: review,
//                         productId: product.id,
//                         isEditable: user != null && user.uid == review.userId,
//                         onEdit: () {
//                           reviewController.addOrUpdateReview(product.id,
//                               existingReview: review);
//                         },
//                         onDelete: () {
//                           reviewController.deleteReview(
//                               product.id, review.userId);
//                         },
//                       );
//                     }).toList(),
//                   );
//                 }
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class NewUserReviewCard extends StatelessWidget {
// //   final ReviewModel review;
// //   final String productId;
// //   final VoidCallback onEdit;
// //   final VoidCallback onDelete;

// //   NewUserReviewCard({
// //     Key? key,
// //     required this.review,
// //     required this.productId,
// //     required this.onEdit,
// //     required this.onDelete,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Row(
// //                   children: [
// //                     // TRoundedImage(
// //                     //     isNetworkImage: true,
// //                     //     imageUrl: review.userProfilePicture),
// //                     CircleAvatar(
// //                       backgroundImage: NetworkImage(review.userProfilePicture),
// //                       radius: 20,
// //                     ),
// //                     SizedBox(width: 10),
// //                     Text(
// //                       review.userFullName,
// //                       style: Theme.of(context).textTheme.subtitle1,
// //                     ),
// //                   ],
// //                 ),
// //                 Row(
// //                   children: [
// //                     IconButton(
// //                       icon: Icon(Icons.edit),
// //                       onPressed: onEdit,
// //                     ),
// //                     IconButton(
// //                       icon: Icon(Icons.delete),
// //                       onPressed: onDelete,
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 10),
// //             Row(
// //               children: List.generate(
// //                 5,
// //                 (index) => Icon(
// //                   index < review.rating ? Icons.star : Icons.star_border,
// //                   color: Colors.amber,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 10),
// //             Text(
// //               review.review,
// //               style: Theme.of(context).textTheme.bodyText2,
// //             ),
// //             SizedBox(height: 10),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.end,
// //               children: [
// //                 Text(
// //                   DateFormat('dd MMM yyyy').format(review.timestamp),
// //                   style: Theme.of(context).textTheme.caption,
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// class NewUserReviewCard extends StatelessWidget {
//   final ReviewModel review;
//   final String productId;
//   final bool isEditable;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;

//   NewUserReviewCard({
//     Key? key,
//     required this.review,
//     required this.productId,
//     required this.isEditable,
//     required this.onEdit,
//     required this.onDelete,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 20,
//                       backgroundImage: CachedNetworkImageProvider(
//                         review.userProfilePicture,
//                       ),
//                       child: review.userProfilePicture.isEmpty
//                           ? Icon(Icons.person)
//                           : null,
//                     ),
//                     SizedBox(width: 10),
//                     Text(
//                       review.userFullName,
//                       style: Theme.of(context).textTheme.subtitle1,
//                     ),
//                   ],
//                 ),
//                 if (isEditable)
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.edit),
//                         onPressed: onEdit,
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.delete),
//                         onPressed: onDelete,
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: List.generate(
//                 5,
//                 (index) => Icon(
//                   index < review.rating ? Icons.star : Icons.star_border,
//                   color: Colors.amber,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               review.review,
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   DateFormat('dd MMM yyyy').format(review.timestamp),
//                   style: Theme.of(context).textTheme.caption,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NewOverallProductRating extends StatelessWidget {
//   final double rating;

//   NewOverallProductRating({Key? key, required this.rating}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           'Overall Rating:',
//           style: Theme.of(context).textTheme.headline6,
//         ),
//         SizedBox(width: 10),
//         Text(
//           rating.toStringAsFixed(1),
//           style: Theme.of(context).textTheme.headline6,
//         ),
//         SizedBox(width: 10),
//         Row(
//           children: List.generate(
//             5,
//             (index) => Icon(
//               index < rating ? Icons.star : Icons.star_border,
//               color: Colors.amber,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
