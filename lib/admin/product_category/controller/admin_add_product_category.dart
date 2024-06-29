import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/shop/models/product_category_model.dart';

class ProductCategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final TextEditingController productIdController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  
  final RxString productIdError = ''.obs;
  final RxString categoryIdError = ''.obs;

  bool validateForm() {
    bool isValid = true;
    if (productIdController.text.isEmpty) {
      productIdError.value = 'Product ID cannot be empty';
      isValid = false;
    } else {
      productIdError.value = '';
    }

    if (categoryIdController.text.isEmpty) {
      categoryIdError.value = 'Category ID cannot be empty';
      isValid = false;
    } else {
      categoryIdError.value = '';
    }

    return isValid;
  }

  Future<void> addProductCategory() async {
    if (validateForm()) {
      try {
        final productCategory = ProductCategoryModel(
          productId:productIdController.text,
          categoryId: categoryIdController.text,
        );
        await _firestore.collection('ProductCategory').add(productCategory.toJson());
        Get.snackbar('Success', 'Product Category added successfully');
        productIdController.clear();
        categoryIdController.clear();
      } catch (e) {
        Get.snackbar('Error', 'Failed to add Product Category: $e');
      }
    }
  }
}
