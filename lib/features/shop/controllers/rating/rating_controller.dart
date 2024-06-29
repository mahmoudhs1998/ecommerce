// import 'package:ecommerce/utils/local_storage/storage_utility.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rating_dialog/rating_dialog.dart';

// // class RatingController extends GetxController {
// //   static RatingController get instance => Get.find();
// //   RxDouble rating = 0.0.obs;

// //   RatingController() {
// //     // Load the saved rating
// //     rating.value = TLocalStorage.instance().readData('rating') ?? 4.8;
// //   }

// //   void updateRating(double newRating) {
// //     rating.value = newRating;
// //     // Save the rating
// //     TLocalStorage.instance().writeData('rating', newRating);
// //   }
// // }

// class RatinggController extends GetxController {
//   static RatinggController get instance => Get.find();
//   RxDouble rating = 0.0.abs().obs;
//   RxString review = ''.obs;
//   RatinggController() {
//     // Load the saved rating
//     rating.value = TLocalStorage.instance().readData('rating') ?? 0.0;
//   }

//   void updateRating(double newRating) {
//     rating.value = newRating;
//     // Save the rating
//     TLocalStorage.instance().writeData('rating', newRating);
//   }

//   @override
//   void onInit() {
//     rating.value = TLocalStorage.instance().readData('rating') ?? 0.0;

//     super.onInit();
//   }

//   @override
//   void onReady() {
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     super.onInit();
//   }

//   showRatingDialog() {
//     Get.dialog(RatingDialog(
//       starColor: Colors.amber,
//       title: const Text('Rating Dialog'),
//       message: const Text(
//           'Tap a star to set your rating. Add more description here if you want.'), //
//       image: Image.asset(
//         "image/logo.jpg",
//         height: 100,
//       ), // Image.asset
//       submitButtonText: 'Submit',
//       onCancelled: () => print('cancelled'),
//       onSubmitted: (response) {
//         rating.value = response.rating;
//         review.value = response.comment;
//         print('rating: ${response.rating}, comment: ${response.comment}');
//       },
//     )); // RatingDialog
//   }
// }

import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rating_dialog/rating_dialog.dart';

class RatingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<Review> reviews = <Review>[].obs;
  final UserModel user = UserModel.empty();
  final RxDouble rating = 0.0.obs;
  final RxString review = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReviews();
  }

  void fetchReviews() {
    _firestore.collection('reviews').snapshots().listen((snapshot) {
      reviews.value = snapshot.docs
          .map((doc) =>
              Review.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  void addReview(Review review) async {
    await _firestore.collection('reviews').add(review.toMap());
  }

  void showRatingDialog() {
    Get.dialog(RatingDialog(
      starColor: Colors.amber,
      title: const Text('Rating Dialog'),
      message: const Text(
          'Tap a star to set your rating. Add more description here if you want.'),
      image: Image.asset(
        "image/logo.jpg",
        height: 100,
      ),
      submitButtonText: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        rating.value = response.rating;
        review.value = response.comment;
        final newReview = Review(
          id: '', // Firestore will generate an ID
          userName: user.fullName, // Replace with the actual user's name
          userImageUrl:
              user.profilePicture, // Replace with the actual user's image URL
          content: response.comment,
          rating: response.rating,
          date: DateTime.now(),
        );
        addReview(newReview);
      },
    ));
  }
}

class Review {
  String id;
  String userName;
  String userImageUrl;
  String content;
  double rating;
  DateTime date;

  Review({
    required this.id,
    required this.userName,
    required this.userImageUrl,
    required this.content,
    required this.rating,
    required this.date,
  });

  factory Review.fromMap(Map<String, dynamic> data, String documentId) {
    return Review(
      id: documentId,
      userName: data['userName'],
      userImageUrl: data['userImageUrl'],
      content: data['content'],
      rating: data['rating'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userImageUrl': userImageUrl,
      'content': content,
      'rating': rating,
      'date': date,
    };
  }
}
