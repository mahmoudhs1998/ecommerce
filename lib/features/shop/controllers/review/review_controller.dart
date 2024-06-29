// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../models/review/review_model.dart';


// class ReviewController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   var reviews = <Review>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchReviews();
//   }

//   Future<void> addReview(Review review) async {
//     await _firestore.collection('reviews').add(review.toJson());
//   }

//   void fetchReviews() {
//     _firestore.collection('reviews').snapshots().listen((QuerySnapshot snapshot) {
//       reviews.value = snapshot.docs.map((doc) {
//         return Review.fromJson(doc.data() as Map<String, dynamic>);
//       }).toList();
//     });
//   }
// }
