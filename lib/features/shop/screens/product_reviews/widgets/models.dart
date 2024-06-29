// import 'package:cloud_firestore/cloud_firestore.dart';

// class Rating {
//   final String productId;
//   final double averageRating;
//   final int totalRatings;

//   Rating({
//     required this.productId,
//     required this.averageRating,
//     required this.totalRatings,
//   });
// }

// class Review {
//   final int id;
//   final String productId;
//   final String userId;
//   final double rating;
//   final String reviewText;
//   final DateTime date;

//   Review({
//     required this.id,
//     required this.productId,
//     required this.userId,
//     required this.rating,
//     required this.reviewText,
//     required this.date,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'productId': productId,
//       'userId': userId,
//       'rating': rating,
//       'reviewText': reviewText,
//       'date': date,
//     };
//   }

//   factory Review.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
//     final data = document.data()!;
//     return Review(
//       id: document.id.hashCode,
//       productId: data['productId'],
//       userId: data['userId'],
//       rating: data['rating'],
//       reviewText: data['reviewText'],
//       date: (data['date'] as Timestamp).toDate(),
//     );
//   }
// }
