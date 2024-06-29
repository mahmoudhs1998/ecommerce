// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../features/shop/models/banner_model.dart';

// class AdminBannerController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final ImagePicker _picker = ImagePicker();

//   final TextEditingController targetScreenController = TextEditingController();
//   final RxBool active = false.obs;
//   final RxString imageUrl = ''.obs;

//   final RxString targetScreenError = ''.obs;

//   bool validateForm() {
//     bool isValid = true;

//     if (imageUrl.value.isEmpty) {
//       Get.snackbar('Error', 'Please select an image');
//       isValid = false;
//     }

//     if (targetScreenController.text.isEmpty) {
//       targetScreenError.value = 'Target Screen cannot be empty';
//       isValid = false;
//     } else {
//       targetScreenError.value = '';
//     }

//     return isValid;
//   }

//   Future<void> pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       File file = File(pickedFile.path);
//       String fileName = pickedFile.name;
//       String downloadUrl = await uploadImage(file, fileName);
//       imageUrl.value = downloadUrl;
//     }
//   }

//   Future<int> getNextDocumentId() async {
//     final querySnapshot = await _firestore
//         .collection('Banners')
//         .orderBy('id', descending: true)
//         .limit(1)
//         .get();
//     if (querySnapshot.docs.isEmpty) {
//       return 1;
//     } else {
//       final lastId = querySnapshot.docs.first.data()['id'] as int;
//       return lastId + 1;
//     }
//   }

//   Future<void> addBanner() async {
//     if (validateForm()) {
//       try {
//         final nextId = await getNextDocumentId();

//         final banner = BannerModel(
//           imageUrl: imageUrl.value,
//           targetScreen: targetScreenController.text,
//           active: active.value,
//         );

//         await _firestore.collection('Banners').doc(nextId.toString()).set({
//           'id': nextId,
//           ...banner.toJson(),
//         });

//         Get.snackbar('Success', 'Banner added successfully');
//         targetScreenController.clear();
//         active.value = false;
//         imageUrl.value = '';
//       } catch (e) {
//         Get.snackbar('Error', 'Failed to add Banner: $e');
//       }
//     }
//   }

//   Future<String> uploadImage(File file, String fileName) async {
//     final ref = _storage.ref().child('banners').child(fileName);
//     await ref.putFile(file);
//     return await ref.getDownloadURL();
//   }
// }
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/shop/screens/home/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../../data/repositories/banners/banners_repository.dart';
import '../../../features/shop/models/banner_model.dart';

// class AdminBannerController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final ImagePicker _picker = ImagePicker();

//   final TextEditingController targetScreenController = TextEditingController();
//   final RxBool active = false.obs;
//   final RxString imageUrl = ''.obs;
//   final Rx<File?> selectedImage = Rx<File?>(null);
//   final Rx<Uint8List?> selectedImageBytes = Rx<Uint8List?>(null);
//   RxList<BannerModel> banners = <BannerModel>[].obs;

//   final RxString targetScreenError = ''.obs;

//   bool validateForm() {
//     bool isValid = true;

//     if (imageUrl.value.isEmpty) {
//       Get.snackbar('Error', 'Please select an image');
//       isValid = false;
//     }

//     if (targetScreenController.text.isEmpty) {
//       targetScreenError.value = 'Target Screen cannot be empty';
//       isValid = false;
//     } else {
//       targetScreenError.value = '';
//     }

//     return isValid;
//   }

//   Future<void> pickImage() async {
//     if (kIsWeb) {
//       final pickedBytes = await ImagePickerWeb.getImageAsBytes();
//       if (pickedBytes != null) {
//         selectedImageBytes.value = pickedBytes;
//         String downloadUrl = await uploadImageWeb(
//             pickedBytes, 'banner_${DateTime.now().millisecondsSinceEpoch}.jpg');
//         imageUrl.value = downloadUrl;
//       }
//     } else {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         selectedImage.value = File(pickedFile.path);
//         String downloadUrl = await uploadImage(selectedImage.value!,
//             'banner_${DateTime.now().millisecondsSinceEpoch}.jpg');
//         imageUrl.value = downloadUrl;
//       }
//     }
//   }

//   Future<int> getNextDocumentId() async {
//     final querySnapshot = await _firestore
//         .collection('Banners')
//         .orderBy('id', descending: true)
//         .limit(1)
//         .get();
//     if (querySnapshot.docs.isEmpty) {
//       return 1;
//     } else {
//       final lastId = querySnapshot.docs.first.data()['id'] as int;
//       return lastId + 1;
//     }
//   }

//   Future<void> addBanner() async {
//     if (validateForm()) {
//       try {
//         final nextId = await getNextDocumentId();

//         final banner = BannerModel(
//           imageUrl: imageUrl.value,
//           targetScreen: '/${targetScreenController.text}',
//           active: active.value,
//         );

//         await _firestore.collection('Banners').doc(nextId.toString()).set({
//           'id': nextId,
//           ...banner.toJson(),
//         });

//         Get.snackbar('Success', 'Banner added successfully');

//         targetScreenController.clear();
//         active.value = false;
//         imageUrl.value = '';
//         selectedImage.value = null;
//         selectedImageBytes.value = null;
//         // Fetch Banners
//         final bannerRepo = Get.put(BannersRepository());
//         final banners = await bannerRepo.fetchBanners();
//         Get.off(() => const HomeScreen());
//         // Assign Banners
//         this.banners.assignAll(banners);
//       } catch (e) {
//         Get.snackbar('Error', 'Failed to add Banner: $e');
//       }
//     }
//   }

//   Future<String> uploadImage(File file, String fileName) async {
//     try {
//       final ref = _storage.ref().child('banners').child(fileName);
//       await ref.putFile(file);
//       return await ref.getDownloadURL();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to upload image: $e');
//       return '';
//     }
//   }

//   Future<String> uploadImageWeb(Uint8List bytes, String fileName) async {
//     try {
//       final ref = _storage.ref().child('banners').child(fileName);
//       await ref.putData(bytes);
//       return await ref.getDownloadURL();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to upload image: $e');
//       return '';
//     }
//   }
// }

class AdminBannerController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController targetScreenController = TextEditingController();
  final RxBool active = false.obs;
  final RxString imageUrl = ''.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<Uint8List?> selectedImageBytes = Rx<Uint8List?>(null);
  RxList<BannerModel> banners = <BannerModel>[].obs;

  final RxString targetScreenError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  bool validateForm() {
    bool isValid = true;

    if (imageUrl.value.isEmpty) {
      Get.snackbar('Error', 'Please select an image');
      isValid = false;
    }

    if (targetScreenController.text.isEmpty) {
      targetScreenError.value = 'Target Screen cannot be empty';
      isValid = false;
    } else {
      targetScreenError.value = '';
    }

    return isValid;
  }

  Future<void> pickImage() async {
    if (kIsWeb) {
      final pickedBytes = await ImagePickerWeb.getImageAsBytes();
      if (pickedBytes != null) {
        selectedImageBytes.value = pickedBytes;
        String downloadUrl = await uploadImageWeb(
            pickedBytes, 'banner_${DateTime.now().millisecondsSinceEpoch}.jpg');
        imageUrl.value = downloadUrl;
      }
    } else {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        String downloadUrl = await uploadImage(selectedImage.value!,
            'banner_${DateTime.now().millisecondsSinceEpoch}.jpg');
        imageUrl.value = downloadUrl;
      }
    }
  }

  Future<int> getNextDocumentId() async {
    final querySnapshot = await _firestore
        .collection('Banners')
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

  Future<void> addBanner() async {
    if (validateForm()) {
      try {
        final nextId = await getNextDocumentId();

        final banner = BannerModel(
          imageUrl: imageUrl.value,
          targetScreen: '/${targetScreenController.text}',
          active: active.value,
        );

        await _firestore.collection('Banners').doc(nextId.toString()).set({
          'id': nextId,
          ...banner.toJson(),
        });

        Get.snackbar('Success', 'Banner added successfully');
        fetchBanners();

// Fetch Banners
        final bannerRepo = Get.put(BannersRepository());
        final banners = await bannerRepo.fetchBanners();

// Assign Banners
        this.banners.assignAll(banners);

        Get.to(const HomeScreen());

        targetScreenController.clear();
        active.value = false;
        imageUrl.value = '';
        selectedImage.value = null;
        selectedImageBytes.value = null;
      } catch (e) {
        Get.snackbar('Error', 'Failed to add Banner: $e');
      }
    }
  }

  void fetchBanners() {
    _firestore.collection('Banners').snapshots().listen((snapshot) {
      banners.value = snapshot.docs.map((doc) {
        return BannerModel.fromSnapshot(doc);
      }).toList();
    });
  }

  Future<String> uploadImage(File file, String fileName) async {
    try {
      final ref = _storage.ref().child('banners').child(fileName);
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
      return '';
    }
  }

  Future<String> uploadImageWeb(Uint8List bytes, String fileName) async {
    try {
      final ref = _storage.ref().child('banners').child(fileName);
      await ref.putData(bytes);
      return await ref.getDownloadURL();
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
      return '';
    }
  }
}

class AdminBannersRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<BannerModel>> fetchBanners() {
    return _firestore.collection('Banners').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return BannerModel.fromSnapshot(doc);
      }).toList();
    });
  }
}
