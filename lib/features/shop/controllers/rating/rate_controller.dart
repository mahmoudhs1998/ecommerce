import 'package:ecommerce/utils/local_storage/storage_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';

class RateController extends GetxController {
  static RateController get instance => Get.find();
  RxDouble rating = 0.0.obs;
  RxString review = ''.obs;
  RateController() {
    // Load the saved rating
    rating.value = TLocalStorage.instance().readData('rating') ?? 0.0;
  }

  void updateRating(double newRating) {
    rating.value = newRating;
    // Save the rating
    TLocalStorage.instance().writeData('rate', newRating);
  }

  @override
  void onInit() {
    rating.value = TLocalStorage.instance().readData('rate') ?? 0.0;

    super.onInit();
  }

  @override
  void onReady() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onInit();
  }

  showRatingDialog() {
    Get.dialog(RatingDialog(
      starColor: Colors.amber,
      title: const Text('Rating Dialog'),
      message: const Text(
          'Tap a star to set your rating. Add more description here if you want.'), //
      image: Image.asset(
        "image/logo.jpg",
        height: 100,
      ), // Image.asset
      submitButtonText: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        rating.value = response.rating;
        review.value = response.comment;
        print('rating: ${response.rating}, comment: ${response.comment}');
      },
    )); // RatingDialog
  }
}