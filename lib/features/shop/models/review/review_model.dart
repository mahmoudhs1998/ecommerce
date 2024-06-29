import '../../../authentication/models/user_model.dart';

class Review {
  final String reviewText;
  final double rating;
  final String date;
  final UserModel user;
  final String? companyReview;

  Review({
    required this.reviewText,
    required this.rating,
    required this.date,
    required this.user,
    this.companyReview,
  });

  Map<String, dynamic> toJson() {
    return {
      'reviewText': reviewText,
      'rating': rating,
      'date': date,
      'user': user.toJson(),
      'companyReview': companyReview,
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewText: json['reviewText'],
      rating: json['rating'],
      date: json['date'],
      user: UserModel.fromSnapshot(json['user']),
      companyReview: json['companyReview'],
    );
  }
}
