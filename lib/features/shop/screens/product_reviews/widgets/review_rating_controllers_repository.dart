// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerce/features/authentication/models/user_model.dart';
// import 'package:ecommerce/features/shop/models/product_model.dart';
// import 'package:ecommerce/features/shop/screens/product_reviews/widgets/models.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';

// class ReviewsRepository {
//   final CollectionReference reviewCollection =
//       FirebaseFirestore.instance.collection('reviews');

//   Future<List<Review>> getReviewsForProduct(int productId) async {
//     QuerySnapshot snapshot =
//         await reviewCollection.where('productId', isEqualTo: productId).get();

//     return snapshot.docs.map((doc) {
//       final data = doc.data() as Map<String, dynamic>;
//       return Review(
//         id: doc.id.hashCode,
//         productId: data['productId'],
//         userId: data['userId'],
//         rating: data['rating'],
//         reviewText: data['reviewText'],
//         date: (data['date'] as Timestamp).toDate(),
//       );
//     }).toList();
//   }

//   Future<void> addReview(Review review) async {
//     await reviewCollection.add({
//       'productId': review.productId,
//       'userId': review.userId,
//       'rating': review.rating,
//       'reviewText': review.reviewText,
//       'date': review.date,
//     });
//   }

//   Future<Rating> getProductRating(int productId) async {
//     List<Review> reviews = await getReviewsForProduct(productId);

//     double totalRating = reviews.fold(0, (sum, review) => sum + review.rating);
//     double averageRating = totalRating / reviews.length;

//     return Rating(
//       productId: productId.toString(),
//       averageRating: averageRating,
//       totalRatings: reviews.length,
//     );
//   }
// }

// class RatingController extends GetxController {
//   final ReviewsRepository _repository = ReviewsRepository();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   var currentUser = UserModel.empty().obs;
//   var currentProduct = ProductModel.empty().obs;

//   var averageRating = 0.0.obs;
//   var totalRatings = 0.obs;
//   var reviews = <Review>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchCurrentUser();
//     fetchCurrentProduct();
//   }

//   void fetchCurrentUser() async {
//     // Assuming currentUser id is stored in local storage
//     String userId = 'current_user_id'; // Fetch from local storage
//     DocumentSnapshot<Map<String, dynamic>> userSnapshot =
//         await _firestore.collection('Users').doc(userId).get();
//     currentUser.value = UserModel.fromSnapshot(userSnapshot);
//   }

//   void fetchCurrentProduct() async {
//     // Assuming currentProduct id is passed via Get.arguments
//     String productId = Get.arguments['Id'];
//     DocumentSnapshot<Map<String, dynamic>> productSnapshot =
//         await _firestore.collection('Products').doc(productId).get();
//     currentProduct.value = ProductModel.fromSnapshot(productSnapshot);
//     fetchProductReviews(currentProduct.value.id as int);
//   }

//   void fetchProductReviews(int productId) async {
//     reviews.value = await _repository.getReviewsForProduct(productId);
//     Rating rating = await _repository.getProductRating(productId);
//     averageRating.value = rating.averageRating;
//     totalRatings.value = rating.totalRatings;
//   }

//   void addReview(String reviewText, double ratingValue) async {
//     Review review = Review(
//       id: DateTime.now().millisecondsSinceEpoch,
//       productId: currentProduct.value.id,
//       userId: currentUser.value.id,
//       rating: ratingValue,
//       reviewText: reviewText,
//       date: DateTime.now(),
//     );

//     await _repository.addReview(review);
//     fetchProductReviews(currentProduct.value.id as int);
//   }

//   void showRatingDialog() {
//     Get.defaultDialog(
//       title: 'Add Review',
//       content: Column(
//         children: [
//           TextField(
//             decoration: InputDecoration(hintText: 'Enter your review'),
//             onChanged: (value) {
//               reviewText.value = value;
//             },
//           ),
//           RatingBar.builder(
//             initialRating: 0,
//             minRating: 1,
//             direction: Axis.horizontal,
//             allowHalfRating: true,
//             itemCount: 5,
//             itemSize: 20.0,
//             unratedColor: Colors.grey,
//             itemBuilder: (context, _) => Icon(
//               Icons.star,
//               color: Colors.blue,
//             ),
//             onRatingUpdate: (newRating) {
//               ratingValue.value = newRating;
//             },
//           ),
//         ],
//       ),
//       textConfirm: 'Submit',
//       onConfirm: () {
//         if (reviewText.isNotEmpty) {
//           addReview(reviewText.value, ratingValue.value);
//           Get.back();
//         }
//       },
//     );
//   }

//   var reviewText = ''.obs;
//   var ratingValue = 0.0.obs;
// }
