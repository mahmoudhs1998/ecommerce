import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../../../features/shop/models/brand_model.dart';

class AdminBrandController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController nameController = TextEditingController();
  final RxBool isFeatured = false.obs;
  final RxString imageUrl = ''.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<Uint8List?> selectedImageBytes = Rx<Uint8List?>(null);
  RxList<BrandModel> brands = <BrandModel>[].obs;

  final RxString nameError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBrands();
  }

  bool validateForm() {
    bool isValid = true;

    if (imageUrl.value.isEmpty) {
      Get.snackbar('Error', 'Please select an image');
      isValid = false;
    }

    if (nameController.text.isEmpty) {
      nameError.value = 'Name cannot be empty';
      isValid = false;
    } else {
      nameError.value = '';
    }

    return isValid;
  }

  Future<void> pickImage() async {
    if (kIsWeb) {
      final pickedBytes = await ImagePickerWeb.getImageAsBytes();
      if (pickedBytes != null) {
        selectedImageBytes.value = pickedBytes;
        String downloadUrl = await uploadImageWeb(
            pickedBytes, 'brand_${DateTime.now().millisecondsSinceEpoch}.jpg');
        imageUrl.value = downloadUrl;
      }
    } else {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        String downloadUrl = await uploadImage(selectedImage.value!,
            'brand_${DateTime.now().millisecondsSinceEpoch}.jpg');
        imageUrl.value = downloadUrl;
      }
    }
  }

  Future<int> getNextDocumentId() async {
    final querySnapshot = await _firestore
        .collection('Brands')
        .orderBy('id', descending: true)
        .limit(1)
        .get();
    if (querySnapshot.docs.isEmpty) {
      return 1;
    } else {
      final lastId = querySnapshot.docs.first.data()['id'] as int;
      return lastId + 1;
    }
  }

  Future<void> addBrand() async {
    if (validateForm()) {
      try {
        final nextId = await getNextDocumentId();

        final brand = BrandModel(
          id: nextId.toString(),
          name: nameController.text,
          image: imageUrl.value,
          isFeatured: isFeatured.value,
          productsCount: 0, // Assuming initial products count is 0
        );

        await _firestore.collection('Brands').doc(nextId.toString()).set({
          'id': nextId,
          ...brand.toJson(),
        });

        Get.snackbar('Success', 'Brand added successfully');

        nameController.clear();
        isFeatured.value = false;
        imageUrl.value = '';
        selectedImage.value = null;
        selectedImageBytes.value = null;
      } catch (e) {
        Get.snackbar('Error', 'Failed to add Brand: $e');
      }
    }
  }

  void fetchBrands() {
    _firestore.collection('Brands').snapshots().listen((snapshot) {
      brands.value = snapshot.docs.map((doc) {
        return BrandModel.fromSnapshot(doc);
      }).toList();
    });
  }

  Future<String> uploadImage(File file, String fileName) async {
    try {
      final ref = _storage.ref().child('brands').child(fileName);
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
      return '';
    }
  }

  Future<String> uploadImageWeb(Uint8List bytes, String fileName) async {
    try {
      final ref = _storage.ref().child('brands').child(fileName);
      await ref.putData(bytes);
      return await ref.getDownloadURL();
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
      return '';
    }
  }
}
