import 'package:ecommerce/features/authentication/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  //variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  //update current index when page scroll

  void updatePageIndicator(index) {
    currentPageIndex.value = index;
  }

  //jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  //update current index & jump to the next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      //Get.to(LoginScreen());
      // Get.offAll => to remove all previously screens created.
      Get.offAll(const LoginScreen());
    } else {
      int page = currentPageIndex.value++;
      pageController.jumpToPage(page);
    }
  }

  //update current index & jump to the last page

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}