import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/shop/models/brand_category_model.dart';

class BrandCategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final TextEditingController brandIdController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  
  final RxString brandIdError = ''.obs;
  final RxString categoryIdError = ''.obs;

  bool validateForm() {
    bool isValid = true;
    if (brandIdController.text.isEmpty) {
      brandIdError.value = 'Brand ID cannot be empty';
      isValid = false;
    } else {
      brandIdError.value = '';
    }

    if (categoryIdController.text.isEmpty) {
      categoryIdError.value = 'Category ID cannot be empty';
      isValid = false;
    } else {
      categoryIdError.value = '';
    }

    return isValid;
  }

  Future<void> addBrandCategory() async {
    if (validateForm()) {
      try {
        final brandCategory = BrandCategoryModel(
          brandId: brandIdController.text,
          categoryId: categoryIdController.text,
        );
        await _firestore.collection('BrandCategory').add(brandCategory.toJson());
        Get.snackbar('Success', 'Brand Category added successfully');
        brandIdController.clear();
        categoryIdController.clear();
      } catch (e) {
        Get.snackbar('Error', 'Failed to add Brand Category: $e');
      }
    }
  }
}
