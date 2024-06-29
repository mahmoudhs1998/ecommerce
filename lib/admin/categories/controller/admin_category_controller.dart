import 'dart:io';

import 'package:ecommerce/features/shop/screens/home/home_screen.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/network/network_connectivity.dart';
import '../../../data/repositories/category/category_repository.dart';
import '../../../features/shop/models/category_model.dart';
import '../../../utils/popups/loaders.dart';

// class AdminCategoryController extends GetxController {
//   static AdminCategoryController get instance => Get.find();

//   final categoryRepository = Get.put(CategoryRepository());
//   final nameController = TextEditingController();
//   final imageController = TextEditingController();
//   final isFeaturedController = false.obs;
//   final parentIdController = TextEditingController();

//   Future<void> addCategory() async {
//     if (nameController.text.isEmpty || imageController.text.isEmpty) {
//       TLoaders.errorSnackBar(
//           title: 'Error', message: 'Please fill all required fields');
//       return;
//     }

//     try {
//       TFullScreenLoader.openLoadingDialog(
//           'Adding category...', TImages.shopAnimation);
//       //TLoaders.showLoading(message: 'Adding category...');

//       final isConnected = await NetworkManager.instance.isConnected();
//       if (!isConnected) {
//         TLoaders.errorSnackBar(
//             title: 'No Internet Connection',
//             message: 'Please check your internet connection and try again.');
//         return;
//       }

//       // Create category model
//       final category = CategoryModel(
//         id: '', // This will be replaced with the auto-generated ID in the repository
//         name: nameController.text,
//         image: imageController.text,
//         isFeatured: isFeaturedController.value,
//         parentId: parentIdController.text,
//       );

//       // Add category to Firestore
//       await categoryRepository.addCategory(category);

//       TLoaders.hideSnackBar();
//       TLoaders.successSnackBar(
//           title: 'Success', message: 'Category added successfully');
//       await categoryRepository.getAllCategories();
//       Get.offAll(() => const HomeScreen());

//       // Clear inputs
//       nameController.clear();
//       imageController.clear();
//       isFeaturedController.value = false;
//       parentIdController.clear();
//     } catch (e) {
//       TLoaders.hideSnackBar();
//       TLoaders.errorSnackBar(
//           title: 'Error', message: 'Failed to add category: $e');
//     }
//   }
// }

class AdminCategoryController extends GetxController {
  static AdminCategoryController get instance => Get.find();

  final categoryRepository = Get.put(CategoryRepository());
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final isFeaturedController = false.obs;
  final parentIdController = TextEditingController();
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = image;
    }
  }

  Future<void> addCategory() async {
    if (nameController.text.isEmpty || selectedImage.value == null) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Please fill all required fields');
      return;
    }

    try {
      TFullScreenLoader.openLoadingDialog(
          'Adding category...', TImages.shopAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message: 'Please check your internet connection and try again.');
        return;
      }

      // Upload image to Firebase Storage and get the URL
      final String imageUrl = await uploadImage(selectedImage.value!);

      // Create category model
      final category = CategoryModel(
        id: '', // This will be replaced with the auto-generated ID in the repository
        name: nameController.text,
        image: imageUrl,
        isFeatured: isFeaturedController.value,
        parentId: parentIdController.text,
      );

      // Add category to Firestore
      await categoryRepository.addCategory(category);

      TLoaders.hideSnackBar();
      TLoaders.successSnackBar(
          title: 'Success', message: 'Category added successfully');
      await categoryRepository.getAllCategories();
      Get.offAll(() => const HomeScreen());

      // Clear inputs
      nameController.clear();
      selectedImage.value = null;
      isFeaturedController.value = false;
      parentIdController.clear();
    } catch (e) {
      TLoaders.hideSnackBar();
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Failed to add category: $e');
    }
  }

  Future<String> uploadImage(XFile image) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imagesRef = storageRef.child('images/${image.name}');
    try {
      if (kIsWeb) {
        // For web, use bytes
        final Uint8List imageData = await image.readAsBytes();
        await imagesRef.putData(imageData);
      } else {
        // For mobile, use File
        await imagesRef.putFile(File(image.path));
      }
      final imageUrl = await imagesRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
