// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../features/shop/models/brand_model.dart';
// import '../../features/shop/models/category_model.dart';
// import '../../features/shop/models/product_attribute_model.dart';
// import '../../features/shop/models/product_model.dart';
// import '../../features/shop/models/product_variation_model.dart';
//
// class NewAdminPanelController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//
//   // Rx variables for images
//   RxList<File?> selectedImages = RxList<File?>([]);
//   Rx<bool> isFeatured = Rx<bool>(false);
//
//   // Uploaded image URLs
//   RxString thumbnailUrl = ''.obs;
//
//   // ImagePicker instance
//   final ImagePicker _picker = ImagePicker();
//
//   // Image handling variables
//   final thumbnailImageUrl = Rx<String?>(null);
//   final secondImageUrl = Rx<String?>(null);
//   final thirdImageUrl = Rx<String?>(null);
//   final fourthImageUrl = Rx<String?>(null);
//   final fifthImageUrl = Rx<String?>(null);
//
//   Rx<dynamic> thumbnailImage = Rx<dynamic>(null);
//   RxList<dynamic> productImages = RxList<dynamic>([]);
//   RxMap<String, dynamic> variationImages = RxMap<String, dynamic>({});
//
//   var addProductFormKey = GlobalKey<FormState>();
//
//   final ScrollController scrollController = ScrollController();
//   var scrollProgress = 0.0.obs;
//
//   // Image handling methods
//   Future<void> selectThumbnailImageurl() async {
//     try {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         if (kIsWeb) {
//           thumbnailImage.value = await pickedFile.readAsBytes();
//         } else {
//           thumbnailImage.value = File(pickedFile.path);
//         }
//       }
//     } catch (e) {
//       print('Error selecting thumbnail image: $e');
//     }
//   }
//
//   Future<void> selectProductImages() async {
//     try {
//       final pickedFiles = await _picker.pickMultiImage();
//       if (pickedFiles.isNotEmpty) {
//         final images = <dynamic>[];
//         if (kIsWeb) {
//           images.addAll(await Future.wait(pickedFiles.map((file) => file.readAsBytes())));
//         } else {
//           images.addAll(pickedFiles.map((file) => File(file.path)));
//         }
//         productImages.assignAll(images);
//       }
//     } catch (e) {
//       print('Error selecting product images: $e');
//     }
//   }
//
//   Future<String> uploadImageToFirebase(dynamic image, String folder) async {
//     try {
//       String fileName = '${DateTime.now().millisecondsSinceEpoch}_${UniqueKey().toString()}';
//       Reference ref = _storage.ref().child(folder).child(fileName);
//
//       TaskSnapshot uploadTask;
//       if (kIsWeb) {
//         if (image is Uint8List) {
//           uploadTask = await ref.putData(image);
//         } else {
//           throw Exception('Invalid image data for web upload');
//         }
//       } else {
//         if (image is File) {
//           uploadTask = await ref.putFile(image);
//         } else {
//           throw Exception('Invalid image data for mobile upload');
//         }
//       }
//
//       String downloadUrl = await uploadTask.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print('Error uploading image: $e');
//       return '';
//     }
//   }
//
//   Future<void> uploadAllImages() async {
//     if (thumbnailImageS.value != null) {
//       thumbnailImageUrl.value = await uploadImageToFirebase(thumbnailImageS.value, 'thumbnails');
//     }
//     for (int i = 0; i < productImages.length; i++) {
//       if (productImages[i] != null) {
//         final imageUrl = await uploadImageToFirebase(productImages[i], 'productImages');
//         if (imageUrl.isNotEmpty) {
//           switch (i) {
//             case 0:
//               secondImageS.value = imageUrl;
//               break;
//             case 1:
//               thirdImageS.value = imageUrl;
//               break;
//             case 2:
//               fourthImageS.value = imageUrl;
//               break;
//             case 3:
//               fifthImageS.value = imageUrl;
//               break;
//           }
//         }
//       }
//     }
//   }
//
//
//
//
//
//   // Text editing controllers
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController stockController = TextEditingController();
//   final TextEditingController skuController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController salePriceController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController categoryIdController = TextEditingController();
//   final TextEditingController thumbnailUrlController = TextEditingController();
//
//   // Brands list
//   RxList<NewBrandModel> brands = RxList<NewBrandModel>([]);
//   RxList<NewBrandModel> filteredBrands = RxList<NewBrandModel>([]);
//   Rx<NewBrandModel?> selectedBrand = Rx<NewBrandModel?>(null);
//
//   // Product type
//   Rx<ProductType> selectedProductType = ProductType.single.obs;
//
//   // Rx variables for images
//   RxList<File?> selectedImagesS = RxList<File?>([]);
//   Rx<bool> isFeaturedS = Rx<bool>(false);
//
//   // Uploaded image URLs
//   RxString thumbnailUrlS = ''.obs;
//
//
//
//
//
//   // ImagePicker instance
//   /// New Images Methods #######################################
//   ///
//   ///
//   // Updated image handling variables
// // Updated image handling variables
//
//
//   // Rxn variables for image URLs
//   // var thumbnailImageUrl = Rxn<dynamic>();
//   // var secondImageUrl = Rxn<dynamic>();
//   // var thirdImageUrl = Rxn<dynamic>();
//   // var fourthImageUrl = Rxn<dynamic>();
//   // var fifthImageUrl = Rxn<dynamic>();
//   final thumbnailImageUrlS = Rx<String?>(null);
//   final secondImageS = Rx<String?>(null);
//   final thirdImageS = Rx<String?>(null);
//   final fourthImageS = Rx<String?>(null);
//   final fifthImageS = Rx<String?>(null);
//   Rx<dynamic> thumbnailImageS = Rx<dynamic>(null);
//   RxList<dynamic> productImagesS = RxList<dynamic>([]);
//   RxMap<String, dynamic> variationImagesS = RxMap<String, dynamic>({});
//
//
//   //
//   // Future<void> selectThumbnailImageurl() async {
//   //   try {
//   //     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//   //     if (pickedFile != null) {
//   //       if (kIsWeb) {
//   //         thumbnailImage.value = await pickedFile.readAsBytes();
//   //       } else {
//   //         thumbnailImage.value = File(pickedFile.path);
//   //       }
//   //     }
//   //   } catch (e) {
//   //     print('Error selecting thumbnail image: $e');
//   //   }
//   // }
//   //
//   // // Updated method to select multiple product images
//   // Future<void> selectProductImages() async {
//   //   try {
//   //     final pickedFiles = await _picker.pickMultiImage();
//   //     if (pickedFiles.isNotEmpty) {
//   //       if (kIsWeb) {
//   //         productImages.addAll(await Future.wait(pickedFiles.map((file) => file.readAsBytes())));
//   //       } else {
//   //         productImages.addAll(pickedFiles.map((file) => File(file.path)));
//   //       }
//   //     }
//   //   } catch (e) {
//   //     print('Error selecting product images: $e');
//   //   }
//   // }
//
//   //################Perfect###############################
//   // Future<void> selectThumbnailImageurl() async {
//   //   try {
//   //     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//   //     if (pickedFile != null) {
//   //       if (kIsWeb) {
//   //         thumbnailImage.value = await pickedFile.readAsBytes();
//   //       } else {
//   //         thumbnailImage.value = File(pickedFile.path);
//   //       }
//   //     }
//   //   } catch (e) {
//   //     print('Error selecting thumbnail image: $e');
//   //   }
//   // }
//   //
//   // Future<void> selectProductImages() async {
//   //   try {
//   //     final pickedFiles = await _picker.pickMultiImage();
//   //     if (pickedFiles.isNotEmpty) {
//   //       final images = <dynamic>[];
//   //       if (kIsWeb) {
//   //         images.addAll(await Future.wait(pickedFiles.map((file) => file.readAsBytes())));
//   //       } else {
//   //         images.addAll(pickedFiles.map((file) => File(file.path)));
//   //       }
//   //       productImages.assignAll(images); // Efficiently update the list
//   //     }
//   //   } catch (e) {
//   //     print('Error selecting product images: $e');
//   //   }
//   // }
//
//
//   //##################test############################
//
//   // Image handling
//
//   var secondImage = Rxn<dynamic>();
//   var thirdImage = Rxn<dynamic>();
//   var fourthImage = Rxn<dynamic>();
//   var fifthImage = Rxn<dynamic>();
//
//
//   Future<void> pickImage({required int imageCardNumber}) async {
//     try {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         final image = kIsWeb ? await pickedFile.readAsBytes() : File(pickedFile.path);
//         switch (imageCardNumber) {
//           case 1:
//             thumbnailImage.value = image;
//             break;
//           case 2:
//             secondImage.value = image;
//             break;
//           case 3:
//             thirdImage.value = image;
//             break;
//           case 4:
//             fourthImage.value = image;
//             break;
//           case 5:
//             fifthImage.value = image;
//             break;
//         }
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }
//
//   void removeImage(int imageCardNumber) {
//     switch (imageCardNumber) {
//       case 1:
//         thumbnailImage.value = null;
//         break;
//       case 2:
//         secondImage.value = null;
//         break;
//       case 3:
//         thirdImage.value = null;
//         break;
//       case 4:
//         fourthImage.value = null;
//         break;
//       case 5:
//         fifthImage.value = null;
//         break;
//     }
//   }
//
//   // Future<void> selectThumbnailImageurl() async {
//   //   try {
//   //     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//   //     if (pickedFile != null) {
//   //       if (kIsWeb) {
//   //         thumbnailImage.value = await pickedFile.readAsBytes();
//   //       } else {
//   //         thumbnailImage.value = File(pickedFile.path);
//   //       }
//   //     }
//   //   } catch (e) {
//   //     print('Error selecting thumbnail image: $e');
//   //   }
//   // }
//
//   // Future<void> selectProductImages([int? index]) async {
//   //   try {
//   //     final pickedFiles = index == null
//   //         ? await _picker.pickMultiImage()
//   //         : [await _picker.pickImage(source: ImageSource.gallery)];
//   //
//   //     if (pickedFiles.isNotEmpty) {
//   //       final images = <dynamic>[];
//   //       if (kIsWeb) {
//   //         images.addAll(await Future.wait(pickedFiles.map((file) => file!.readAsBytes())));
//   //       } else {
//   //         images.addAll(pickedFiles.map((file) => File(file!.path)));
//   //       }
//   //       if (index == null) {
//   //         productImages.assignAll(images); // Efficiently update the list
//   //       } else {
//   //         productImages[index] = images.first; // Update specific image
//   //       }
//   //     }
//   //   } catch (e) {
//   //     print('Error selecting product images: $e');
//   //   }
//   // }
//
//   void removeProductImage(int index) {
//     if (index >= 0 && index < productImages.length) {
//       productImages.removeAt(index);
//     }
//   }
//
//
//   // Updated method to select variation image
//   Future<void> selectVariationImage(String variationId) async {
//     try {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         if (kIsWeb) {
//           variationImages[variationId] = await pickedFile.readAsBytes();
//         } else {
//           variationImages[variationId] = File(pickedFile.path);
//         }
//       }
//     } catch (e) {
//       print('Error selecting variation image: $e');
//     }
//   }
//
//   // Updated method to upload images to Firebase Storage
//   // Future<String> uploadImageToFirebase(dynamic image, String folder) async {
//   //   try {
//   //     String fileName = '${DateTime.now().millisecondsSinceEpoch}_${UniqueKey().toString()}';
//   //     Reference ref = _storage.ref().child(folder).child(fileName);
//   //
//   //     TaskSnapshot uploadTask;
//   //     if (kIsWeb) {
//   //       if (image is Uint8List) {
//   //         uploadTask = await ref.putData(image);
//   //       } else {
//   //         throw Exception('Invalid image data for web upload');
//   //       }
//   //     } else {
//   //       if (image is File) {
//   //         uploadTask = await ref.putFile(image);
//   //       } else {
//   //         throw Exception('Invalid image data for mobile upload');
//   //       }
//   //     }
//   //
//   //     String downloadUrl = await uploadTask.ref.getDownloadURL();
//   //     return downloadUrl;
//   //   } catch (e) {
//   //     print('Error uploading image: $e');
//   //     return '';
//   //   }
//   // }
//
//
//
//
//   ///
//   ///
//   ///
//   ///
//   /// New Images Methods #######################################
//
//   /// ---------- Attributes  & Variations
//   ///
//   // New variables for product attributes and variations
//
//   // new -------------------------------------------------------
//
//   final Rx<String?> selectedAttributeType = Rx<String?>(null);
//   final Rx<String?> selectedColorValue = Rx<String?>(null);
//
//   final TextEditingController attributeNameController = TextEditingController();
//   final TextEditingController attributeValueController =
//       TextEditingController();
//   final TextEditingController sizeInputController = TextEditingController();
//
//   var selectedSizes;
//
//   var selectedColors;
//
//   void setAttributeType(String? type) {
//     selectedAttributeType.value = type;
//     attributeNameController.text = type ?? '';
//   }
//
//   void setColorValue(String? value) {
//     selectedColorValue.value = value;
//     if (value != null) {
//       attributeValueController.text = value;
//     }
//   }
//
//   void addAttribute() {
//     if (attributeNameController.text.isNotEmpty &&
//         attributeValueController.text.isNotEmpty) {
//       productAttributes.add(ProductAttributeModel(
//         name: attributeNameController.text,
//         values: [attributeValueController.text],
//       ));
//       attributeValueController.clear();
//       sizeInputController.clear();
//     }
//   }
//
//   // new -------------------------------------------------------
//
//   RxList<ProductAttributeModel> productAttributes =
//       RxList<ProductAttributeModel>([]);
//   RxList<ProductVariationModel> productVariations =
//       RxList<ProductVariationModel>([]);
//
//   // final TextEditingController attributeNameController = TextEditingController();
//   // final TextEditingController attributeValueController =
//   //     TextEditingController();
//
//   final TextEditingController variationIdController = TextEditingController();
//   final TextEditingController variationStockController =
//       TextEditingController();
//   final TextEditingController variationPriceController =
//       TextEditingController();
//   final TextEditingController variationSalePriceController =
//       TextEditingController();
//   final TextEditingController variationDescriptionController =
//       TextEditingController();
//   final TextEditingController variationSkuController = TextEditingController();
//
//   void removeAttribute(ProductAttributeModel attribute) {
//     productAttributes.remove(attribute);
//     update();
//   }
//
//   void addVariation() {
//     var newVariation = ProductVariationModel(
//       id: variationIdController.text,
//       stock: int.parse(variationStockController.text),
//       price: double.parse(variationPriceController.text),
//       salePrice: double.parse(variationSalePriceController.text),
//       description: variationDescriptionController.text,
//       sku: variationSkuController.text,
//       attributeValues: {
//         'Color': selectedColorsss.isNotEmpty ? selectedColorsss.toList().join(', ') : '',
//                 'Size': selectedSizesss.isNotEmpty ? selectedSizesss.toList().join(', ') : '',
//       },
//     );
//     productVariations.add(newVariation);
//     update();
//   }
//
//   void updateVariationAttributeValue(
//       ProductVariationModel variation, String attributeName, String value) {
//     variation.attributeValues[attributeName] = value;
//     update();
//   }
//
//   void removeVariation(ProductVariationModel variation) {
//     productVariations.remove(variation);
//     update();
//   }
//
//
//   final selectedColorsss = <String>[].obs;
//   final selectedSizesss = <String>[].obs;
//   final sizeInputControllerss = TextEditingController();
//
//   void addAttributess() {
//     if (selectedAttributeType.value == 'Color' && selectedColorsss.isNotEmpty) {
//       productAttributes.add(ProductAttributeModel(
//         name: 'Color',
//         values: selectedColorsss.toList(),
//       ));
//       selectedColorsss.clear();
//     } else if (selectedAttributeType.value == 'Size' && selectedSizesss.isNotEmpty) {
//       productAttributes.add(ProductAttributeModel(
//         name: 'Size',
//         values: selectedSizesss.toList(),
//       ));
//       selectedSizesss.clear();
//     }
//   }
//
//   ///  ---------- Attributes  & Variations ---------------------------------
//
//   ///  ---------- get Category ID  ---------------------------------
//
// // Categories list
//   RxList<CategoryModel> categories = RxList<CategoryModel>([]);
//   RxList<CategoryModel> filteredCategories = RxList<CategoryModel>([]);
//   Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
//
//   void fetchCategories() async {
//     try {
//       final categoriesSnapshot =
//           await _firestore.collection('Categories').get();
//       if (categoriesSnapshot.docs.isNotEmpty) {
//         categories.assignAll(categoriesSnapshot.docs
//             .map((doc) => CategoryModel.fromSnapshot(doc))
//             .toList());
//         filteredCategories.assignAll(categories);
//       }
//     } catch (error) {
//       print('Error fetching categories: $error');
//     }
//   }
//
//   void filterCategories(String searchText) {
//     if (searchText.isEmpty) {
//       filteredCategories.assignAll(categories);
//     } else {
//       var filteredList = categories
//           .where((category) =>
//               category.name.toLowerCase().contains(searchText.toLowerCase()))
//           .toList();
//       filteredCategories.assignAll(filteredList);
//     }
//   }
//
//   void selectCategory(CategoryModel category) {
//     selectedCategory.value = category;
//     categoryIdController.text =
//         category.id; // Optionally set the ID in the controller
//   }
//
//   String? getCategoryIdByName(String categoryName) {
//     var category = categories.firstWhere(
//         (cat) => cat.name.toLowerCase() == categoryName.toLowerCase(),
//         orElse: () => CategoryModel.empty());
//     return category.id;
//   }
//
//   ///  ---------- get Category ID  ---------------------------------
//   ///
//   ///
//   ///
//   ///
//   ///
//   void _updateScrollProgress() {
//     final maxScrollExtent = scrollController.position.maxScrollExtent;
//     final currentScroll = scrollController.position.pixels;
//     scrollProgress.value = (currentScroll / maxScrollExtent).clamp(0.0, 1.0);
//     print('Scroll Progress: ${scrollProgress.value}');  // Debug log
//   }
//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize any necessary data or fetch brands
//     fetchBrands();
//     fetchCategories();
//     scrollController.addListener(_updateScrollProgress);
//     print('ScrollController initialized and listener added'); // Debug log
//
//   }
//
//   @override
//   void onClose() {
//     // TODO: implement onClose
//     scrollController.removeListener(_updateScrollProgress);
//     scrollController.dispose();
//     print('ScrollController listener removed and disposed'); // Debug log
//
//     super.onClose();
//   }
//
//   /// ---------- Attributes  & Variations ---------------------------------
//   ///
//   ///
//   ///
//   ///
//   // new
//
//   // Updated method to add product attribute
//   void addProductAttribute() {
//     String name = attributeNameController.text.trim();
//     String value = attributeValueController.text.trim();
//     if (name.isNotEmpty && value.isNotEmpty) {
//       var existingAttribute = productAttributes.firstWhere(
//         (attr) => attr.name == name,
//         orElse: () => ProductAttributeModel(name: name, values: []),
//       );
//       if (!existingAttribute.values!.contains(value)) {
//         existingAttribute.values!.add(value);
//       }
//       if (!productAttributes.contains(existingAttribute)) {
//         productAttributes.add(existingAttribute);
//       }
//       attributeNameController.clear();
//       attributeValueController.clear();
//     }
//   }
//
//   void removeProductAttribute(ProductAttributeModel attribute) {
//     productAttributes.remove(attribute);
//     // Remove this attribute from all variations
//     for (var variation in productVariations) {
//       variation.attributeValues.remove(attribute.name);
//     }
//   }
//
//   void addProductVariation() {
//     if (productAttributes.isEmpty) {
//       Get.snackbar('Error', 'Please add at least one product attribute first');
//       return;
//     }
//
//     Map<String, String> attributeValues = {};
//     for (var attribute in productAttributes) {
//       attributeValues[attribute.name!] =
//           attribute.values!.first; // Default to first value
//     }
//
//     productVariations.add(ProductVariationModel(
//       id: variationIdController.text.isEmpty
//           ? DateTime.now().millisecondsSinceEpoch.toString()
//           : variationIdController.text,
//       stock: int.tryParse(variationStockController.text) ?? 0,
//       price: double.tryParse(variationPriceController.text) ?? 0.0,
//       salePrice: double.tryParse(variationSalePriceController.text) ?? 0.0,
//       description: variationDescriptionController.text,
//       sku: variationSkuController.text,
//       attributeValues: attributeValues,
//     ));
//
//     variationIdController.clear();
//     variationStockController.clear();
//     variationPriceController.clear();
//     variationSalePriceController.clear();
//     variationDescriptionController.clear();
//     variationSkuController.clear();
//   }
//
//   void removeProductVariation(ProductVariationModel variation) {
//     productVariations.remove(variation);
//   }
//
//
//   final selectedColorValues = ''.obs;
//   final sizeInputControllers = TextEditingController();
//
//   void addAttributes() {
//     if (selectedAttributeType.value == 'Color') {
//       String colorValue = selectedColorValues.value;
//       if (!productAttributes.any((attr) => attr.name == 'Color')) {
//         productAttributes.add(ProductAttributeModel(
//           name: 'Color',
//           values: [colorValue],
//         ));
//       } else {
//         productAttributes
//             .firstWhere((attr) => attr.name == 'Color')
//             .values!
//             .add(colorValue);
//       }
//     } else if (selectedAttributeType.value == 'Size') {
//       String sizeValue = sizeInputControllers.text;
//       if (!productAttributes.any((attr) => attr.name == 'Size')) {
//         productAttributes.add(ProductAttributeModel(
//           name: 'Size',
//           values: [sizeValue],
//         ));
//       } else {
//         productAttributes
//             .firstWhere((attr) => attr.name == 'Size')
//             .values!
//             .add(sizeValue);
//       }
//     }
//
//     // Clear input controllers or selected values after adding attribute
//     sizeInputControllers.clear();
//     selectedColorValues.value = '';
//   }
//
//   ///
//   ///
//   ///
//   ///  ---------- Attributes  & Variations ---------------------------------
//
//   // Fetch brands from Firestore
//   void fetchBrands() async {
//     try {
//       final brandsSnapshot = await _firestore.collection('Brands').get();
//       if (brandsSnapshot.docs.isNotEmpty) {
//         brands.assignAll(brandsSnapshot.docs
//             .map((doc) => NewBrandModel.fromQuerySnapshot(doc))
//             .toList());
//         filteredBrands.assignAll(brands);
//       }
//     } catch (error) {
//       print('Error fetching brands: $error');
//     }
//   }
//
//   // Method to filter brands based on search text
//   void filterBrands(String searchText) {
//     if (searchText.isEmpty) {
//       filteredBrands.assignAll(brands);
//     } else {
//       var filteredList = brands
//           .where((brand) =>
//               brand.name.toLowerCase().contains(searchText.toLowerCase()))
//           .toList();
//       filteredBrands.assignAll(filteredList);
//     }
//   }
//
//   // Method to add a new product
//   Future<void> addProduct() async {
//     String? validationError = _validateProduct();
//     if (validationError != null) {
//       Get.snackbar('Error', validationError,
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//
//     List<String> imageUrls =
//         await uploadImagesToFirebase(selectedImages.toList());
//     final newProductId = await _getNextProductId();
//     // Upload all images and get their URLs
//     await uploadAllImages();
//
//
//     // New #####################################333
//
//
//     // // Upload thumbnail
//     // String thumbnailUrls = '';
//     // if (thumbnailImage.value != null) {
//     //   thumbnailUrls = await uploadImageToFirebase(thumbnailImage.value, 'thumbnails');
//     // }
//     //
//     // // Upload product images
//     // List<String> productImageUrls = [];
//     // for (var image in productImages) {
//     //   String url = await uploadImageToFirebase(image, 'product_images');
//     //   if (url.isNotEmpty) {
//     //     productImageUrls.add(url);
//     //   }
//     // }
//
//     String thumbnailUrl = '';
//     if (thumbnailImageUrlS.value != null) {
//       thumbnailUrl = await uploadImageToFirebase(thumbnailImageUrlS.value, 'thumbnails');
//     }
//
//
//
//     // List<String> productImageUrls = [];
//     RxList<String> productImagesS = RxList<String>([]);
//
//     for (var image in [secondImageS.value, thirdImageS.value, fourthImageS.value, fifthImageS.value]) {
//       if (image != null) {
//         String url = await uploadImageToFirebase(image, 'product_images');
//         if (url.isNotEmpty) {
//           productImagesS.add(url);
//         }
//       }
//     }
//
//     // Upload variation images and update variations
//     for (var variation in productVariations) {
//       if (variationImages.containsKey(variation.id)) {
//         String url = await uploadImageToFirebase(variationImages[variation.id], 'variation_images');
//         if (url.isNotEmpty) {
//           variation.image = url;
//         }
//       }
//     }
//
//
//     final product = ProductModel(
//       id: newProductId,
//       title: titleController.text.trim(),
//       stock: int.parse(stockController.text),
//       price: double.parse(priceController.text),
//       salePrice: double.parse(salePriceController.text),
//       sku: skuController.text.trim(),
//       thumbnail: thumbnailUrl,
//       productType: selectedProductType.value,
//       description: descriptionController.text.trim(),
//       categoryId: categoryIdController.text.trim(),
//       images: productImagesS,
//       isFeatured: isFeatured.value,
//       brand: selectedBrand.value,
//       date: DateTime.now(),
//       productAttributes: productAttributes,
//       productVariations: productVariations,
//     );
//
//     try {
//       await _firestore
//           .collection('Products')
//           .doc(newProductId)
//           .set(product.toJson());
//
//       if (selectedBrand.value != null) {
//         await _updateBrandProductCount(selectedBrand.value!.id);
//       }
//
//       Get.snackbar('Success', 'Product added successfully',
//           backgroundColor: Colors.green, colorText: Colors.white);
//       _clearForm();
//     } catch (error) {
//       Get.snackbar('Error', 'Failed to add product: $error',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }
//
//   // Method to select a brand
//   void selectBrand(NewBrandModel brand) {
//     selectedBrand.value = brand;
//   }
//
//   // Method to select thumbnail image from gallery
//   // Future<void> selectThumbnailImage() async {
//   //   try {
//   //     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//   //     if (pickedFile != null) {
//   //       File thumbnailFile = File(pickedFile.path);
//   //       String thumbnailUrl = await uploadThumbnailToFirebase(thumbnailFile);
//   //       if (thumbnailUrl.isNotEmpty) {
//   //         this.thumbnailUrl.value = thumbnailUrl;
//   //       }
//   //     } else {
//   //       print('No image selected');
//   //     }
//   //   } catch (e) {
//   //     print('Error selecting thumbnail image: $e');
//   //   }
//   // }
//
//   // Example of platform-specific upload code for thumbnail image
//   Future<String> uploadThumbnailToFirebase(File thumbnailFile) async {
//     try {
//       String fileName = '${DateTime.now().millisecondsSinceEpoch}_thumbnail';
//       Reference ref = _storage.ref().child('thumbnails').child(fileName);
//
//       TaskSnapshot uploadTask;
//       if (kIsWeb) {
//         // Web-specific upload method
//         uploadTask = await ref.putData(await thumbnailFile.readAsBytes());
//       } else {
//         // Mobile (Android/iOS) specific upload method
//         uploadTask = await ref.putFile(thumbnailFile);
//       }
//
//       String downloadUrl = await uploadTask.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print('Error uploading thumbnail: $e');
//       return '';
//     }
//   }
//
//   Future<List<String>> uploadImagesToFirebase(List<File?> images) async {
//     List<String> downloadUrls = [];
//
//     try {
//       for (int i = 0; i < images.length; i++) {
//         File? image = images[i];
//         if (image != null) {
//           String fileName = '${DateTime.now().millisecondsSinceEpoch}_$i';
//           Reference ref = _storage.ref().child('images').child(fileName);
//
//           TaskSnapshot uploadTask = await ref.putFile(image);
//           String downloadUrl = await uploadTask.ref.getDownloadURL();
//           downloadUrls.add(downloadUrl);
//         }
//       }
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//
//     return downloadUrls;
//   }
//
//   String? _validateProduct() {
//     if (titleController.text.trim().isEmpty) {
//       return 'Please enter a product title';
//     }
//     if (priceController.text.isEmpty ||
//         double.tryParse(priceController.text) == null) {
//       return 'Please enter a valid price';
//     }
//     if (stockController.text.isEmpty ||
//         int.tryParse(stockController.text) == null) {
//       return 'Please enter a valid stock quantity';
//     }
//     if (selectedBrand.value == null) {
//       return 'Please select a brand';
//     }
//     if (categoryIdController.text.trim().isEmpty) {
//       return 'Please select a category';
//     }
//     return null;
//   }
//
//   Future<String> _getNextProductId() async {
//     try {
//       final counterDoc = _firestore.collection('counters').doc('Products');
//       final snapshot = await counterDoc.get();
//
//       if (snapshot.exists) {
//         final data = snapshot.data()!;
//         final currentId = data['lastId'] as int;
//         final newId = currentId + 1;
//
//         await counterDoc.update({'lastId': newId});
//         return newId
//             .toString()
//             .padLeft(3, '0'); // Pads the ID with zeros (e.g., 001, 002, etc.)
//       } else {
//         await counterDoc.set({'lastId': 1});
//         return '001';
//       }
//     } catch (e) {
//       print('Error getting next product ID: $e');
//       return '001'; // Return a default ID in case of error
//     }
//   }
//
//   Future<void> _updateBrandProductCount(String brandId) async {
//     try {
//       await _firestore.collection('Brands').doc(brandId).update({
//         'ProductsCount': FieldValue.increment(1),
//       });
//     } catch (e) {
//       print('Error updating brand product count: $e');
//     }
//   }
//
//   void _clearForm() {
//     titleController.clear();
//     stockController.clear();
//     skuController.clear();
//     priceController.clear();
//     salePriceController.clear();
//     descriptionController.clear();
//     categoryIdController.clear();
//     thumbnailUrl.value = '';
//     thumbnailUrlController.clear();
//     selectedImages.clear();
//     isFeatured.value = false;
//     selectedBrand.value = null;
//     selectedProductType.value = ProductType.single;
//     thumbnailImage.value = null;
//     productImages.clear();
//     variationImages.clear();
//     thumbnailImage.value = null;
//     secondImage.value = null;
//     thirdImage.value = null;
//     fourthImage.value = null;
//     fifthImage.value = null;
//   }
//
//   @override
//   void dispose() {
//     // Dispose controllers to avoid memory leaks
//     titleController.dispose();
//     stockController.dispose();
//     skuController.dispose();
//     priceController.dispose();
//     salePriceController.dispose();
//     descriptionController.dispose();
//     categoryIdController.dispose();
//     thumbnailUrlController.dispose();
//     categoryIdController.dispose();
//
//     super.dispose();
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/shop/models/brand_model.dart';
import '../../features/shop/models/category_model.dart';
import '../../features/shop/models/product_attribute_model.dart';
import '../../features/shop/models/product_model.dart';
import '../../features/shop/models/product_variation_model.dart';

class NewAdminPanelController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Text editing controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  final TextEditingController thumbnailUrlController = TextEditingController();

  // Brands list
  RxList<NewBrandModel> brands = RxList<NewBrandModel>([]);
  RxList<NewBrandModel> filteredBrands = RxList<NewBrandModel>([]);
  Rx<NewBrandModel?> selectedBrand = Rx<NewBrandModel?>(null);

  // Product type
  Rx<ProductType> selectedProductType = ProductType.single.obs;

  // Rx variables for images
  RxList<File?> selectedImages = RxList<File?>([]);
  Rx<bool> isFeatured = Rx<bool>(false);

  // Uploaded image URLs
  RxString thumbnailUrl = ''.obs;





  // ImagePicker instance
  final ImagePicker _picker = ImagePicker();

  /// New Images Methods #######################################
  ///
  ///
  // Updated image handling variables
// Updated image handling variables


  // Rxn variables for image URLs
  var thumbnailImageUrl = Rxn<dynamic>();
  var secondImageUrl = Rxn<dynamic>();
  var thirdImageUrl = Rxn<dynamic>();
  var fourthImageUrl = Rxn<dynamic>();
  var fifthImageUrl = Rxn<dynamic>();
  Rx<dynamic> thumbnailImage = Rx<dynamic>(null);
  // RxList<dynamic> productImages = RxList<dynamic>([]);
  var productImages = <String, Uint8List>{}.obs; // Map to store images with unique IDs
  // RxMap<String, dynamic> variationImages = RxMap<String, dynamic>({});
  final RxMap<String, Uint8List?> variationImages = RxMap<String, Uint8List?>();

  var addProductFormKey = GlobalKey<FormState>();
  //
  // Future<void> selectThumbnailImageurl() async {
  //   try {
  //     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //     if (pickedFile != null) {
  //       if (kIsWeb) {
  //         thumbnailImage.value = await pickedFile.readAsBytes();
  //       } else {
  //         thumbnailImage.value = File(pickedFile.path);
  //       }
  //     }
  //   } catch (e) {
  //     print('Error selecting thumbnail image: $e');
  //   }
  // }
  //
  // // Updated method to select multiple product images
  // Future<void> selectProductImages() async {
  //   try {
  //     final pickedFiles = await _picker.pickMultiImage();
  //     if (pickedFiles.isNotEmpty) {
  //       if (kIsWeb) {
  //         productImages.addAll(await Future.wait(pickedFiles.map((file) => file.readAsBytes())));
  //       } else {
  //         productImages.addAll(pickedFiles.map((file) => File(file.path)));
  //       }
  //     }
  //   } catch (e) {
  //     print('Error selecting product images: $e');
  //   }
  // }
  Future<void> selectThumbnailImageurl() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (kIsWeb) {
          thumbnailImage.value = await pickedFile.readAsBytes();
        } else {
          thumbnailImage.value = File(pickedFile.path);
        }
      }
    } catch (e) {
      print('Error selecting thumbnail image: $e');
    }
  }

  // Future<void> selectProductImages() async {
  //   try {
  //     final pickedFiles = await _picker.pickMultiImage();
  //     if (pickedFiles.isNotEmpty) {
  //       final images = <dynamic>[];
  //       if (kIsWeb) {
  //         images.addAll(await Future.wait(pickedFiles.map((file) => file.readAsBytes())));
  //       } else {
  //         images.addAll(pickedFiles.map((file) => File(file.path)));
  //       }
  //       productImages.assignAll(images); // Efficiently update the list
  //     }
  //   } catch (e) {
  //     print('Error selecting product images: $e');
  //   }
  // }

  Future<void> selectProductImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        final images = <String, Uint8List>{};
        if (kIsWeb) {
          for (var file in pickedFiles) {
            String uniqueId = UniqueKey().toString();
            images[uniqueId] = await file.readAsBytes();
          }
        } else {
          for (var file in pickedFiles) {
            String uniqueId = UniqueKey().toString();
            images[uniqueId] = await File(file.path).readAsBytes();
          }
        }
        productImages.addAll(images); // Add new images to the map
      }
    } catch (e) {
      print('Error selecting product images: $e');
    }
  }



  // Updated method to select variation image
  // Future<void> selectVariationImage(String variationId) async {
  //   try {
  //     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //     if (pickedFile != null) {
  //       if (kIsWeb) {
  //         variationImages[variationId] = await pickedFile.readAsBytes();
  //       } else {
  //         variationImages[variationId] = File(pickedFile.path);
  //       }
  //     }
  //   } catch (e) {
  //     print('Error selecting variation image: $e');
  //   }
  // }




  Future<void> selectVariationImage(String variationId) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery); // Single image
      if (pickedFile != null) {
        final imageBytes = await _getImageBytes(pickedFile);
        variationImages[variationId] = imageBytes; // Store image bytes for each variation ID
        update(); // Ensure UI updates
      }
    } catch (e) {
      print('Error selecting variation image: $e');
    }
  }

  Future<Uint8List> _getImageBytes(XFile xFile) async {
    return await xFile.readAsBytes();
  }


  Future<File> convertUint8ListToFile(Uint8List uint8list) async {
    try {
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/${UniqueKey().toString()}.png';
      final file = File(filePath);
      await file.writeAsBytes(uint8list);
      return file;
    } catch (e) {
      print('Error converting Uint8List to file: $e');
      rethrow;
    }
  }
    Future<void> uploadVariationImages() async {
    for (var variation in productVariations) {
      if (variationImages.containsKey(variation.id)) {
        String url = await uploadImageToFirebase(variationImages[variation.id], 'variation_images');
        if (url.isNotEmpty) {
          variation.image = url;
        }
      }
    }
  }

  // Updated method to upload images to Firebase Storage
  Future<String> uploadImageToFirebase(dynamic image, String folder) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}_${UniqueKey().toString()}';
      Reference ref = _storage.ref().child(folder).child(fileName);

      TaskSnapshot uploadTask;
      if (kIsWeb) {
        if (image is Uint8List) {
          uploadTask = await ref.putData(image);
        } else {
          throw Exception('Invalid image data for web upload');
        }
      } else {
        if (image is File) {
          uploadTask = await ref.putFile(image);
        } else {
          throw Exception('Invalid image data for mobile upload');
        }
      }

      String downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }




  ///
  ///
  ///
  ///
  /// New Images Methods #######################################

  /// ---------- Attributes  & Variations
  ///
  // New variables for product attributes and variations

  // new -------------------------------------------------------

  final Rx<String?> selectedAttributeType = Rx<String?>(null);
  final Rx<String?> selectedColorValue = Rx<String?>(null);

  final TextEditingController attributeNameController = TextEditingController();
  final TextEditingController attributeValueController =
  TextEditingController();
  final TextEditingController sizeInputController = TextEditingController();

  var selectedSizes;

  var selectedColors;

  void setAttributeType(String? type) {
    selectedAttributeType.value = type;
    attributeNameController.text = type ?? '';
  }

  void setColorValue(String? value) {
    selectedColorValue.value = value;
    if (value != null) {
      attributeValueController.text = value;
    }
  }

  void addAttribute() {
    if (attributeNameController.text.isNotEmpty &&
        attributeValueController.text.isNotEmpty) {
      productAttributes.add(ProductAttributeModel(
        name: attributeNameController.text,
        values: [attributeValueController.text],
      ));
      attributeValueController.clear();
      sizeInputController.clear();
    }
  }

  // new -------------------------------------------------------

  RxList<ProductAttributeModel> productAttributes =
  RxList<ProductAttributeModel>([]);
  RxList<ProductVariationModel> productVariations =
  RxList<ProductVariationModel>([]);

  // final TextEditingController attributeNameController = TextEditingController();
  // final TextEditingController attributeValueController =
  //     TextEditingController();

  final TextEditingController variationIdController = TextEditingController();
  final TextEditingController variationStockController =
  TextEditingController();
  final TextEditingController variationPriceController =
  TextEditingController();
  final TextEditingController variationSalePriceController =
  TextEditingController();
  final TextEditingController variationDescriptionController =
  TextEditingController();
  final TextEditingController variationSkuController = TextEditingController();

  void removeAttribute(ProductAttributeModel attribute) {
    productAttributes.remove(attribute);
    update();
  }

  void addVariation() {
    var newVariation = ProductVariationModel(
      id: variationIdController.text,
      stock: int.parse(variationStockController.text),
      price: double.parse(variationPriceController.text),
      salePrice: double.parse(variationSalePriceController.text),
      description: variationDescriptionController.text,
      sku: variationSkuController.text,
      attributeValues: {
        'Color': selectedColorsss.isNotEmpty ? selectedColorsss.toList().join(', ') : '',
        'Size': selectedSizesss.isNotEmpty ? selectedSizesss.toList().join(', ') : '',
      },
    );
    productVariations.add(newVariation);
    update();
  }

  void updateVariationAttributeValue(
      ProductVariationModel variation, String attributeName, String value) {
    variation.attributeValues[attributeName] = value;
    update();
  }

  void removeVariation(ProductVariationModel variation) {
    productVariations.remove(variation);
    update();
  }


  final selectedColorsss = <String>[].obs;
  final selectedSizesss = <String>[].obs;
  final sizeInputControllerss = TextEditingController();

  void addAttributess() {
    if (selectedAttributeType.value == 'Color' && selectedColorsss.isNotEmpty) {
      productAttributes.add(ProductAttributeModel(
        name: 'Color',
        values: selectedColorsss.toList(),
      ));
      selectedColorsss.clear();
    } else if (selectedAttributeType.value == 'Size' && selectedSizesss.isNotEmpty) {
      productAttributes.add(ProductAttributeModel(
        name: 'Size',
        values: selectedSizesss.toList(),
      ));
      selectedSizesss.clear();
    }
  }

  ///  ---------- Attributes  & Variations ---------------------------------

  ///  ---------- get Category ID  ---------------------------------

// Categories list
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxList<CategoryModel> filteredCategories = RxList<CategoryModel>([]);
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);

  void fetchCategories() async {
    try {
      final categoriesSnapshot =
      await _firestore.collection('Categories').get();
      if (categoriesSnapshot.docs.isNotEmpty) {
        categories.assignAll(categoriesSnapshot.docs
            .map((doc) => CategoryModel.fromSnapshot(doc))
            .toList());
        filteredCategories.assignAll(categories);
      }
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  void filterCategories(String searchText) {
    if (searchText.isEmpty) {
      filteredCategories.assignAll(categories);
    } else {
      var filteredList = categories
          .where((category) =>
          category.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      filteredCategories.assignAll(filteredList);
    }
  }

  void selectCategory(CategoryModel category) {
    selectedCategory.value = category;
    categoryIdController.text =
        category.id; // Optionally set the ID in the controller
  }

  String? getCategoryIdByName(String categoryName) {
    var category = categories.firstWhere(
            (cat) => cat.name.toLowerCase() == categoryName.toLowerCase(),
        orElse: () => CategoryModel.empty());
    return category.id;
  }

  ///  ---------- get Category ID  ---------------------------------
  ///
  ///
  ///
  ///
  ///

  @override
  void onInit() {
    super.onInit();
    // Initialize any necessary data or fetch brands
    fetchBrands();
    fetchCategories();
  }

  /// ---------- Attributes  & Variations ---------------------------------
  ///
  ///
  ///
  ///
  // new

  // Updated method to add product attribute
  void addProductAttribute() {
    String name = attributeNameController.text.trim();
    String value = attributeValueController.text.trim();
    if (name.isNotEmpty && value.isNotEmpty) {
      var existingAttribute = productAttributes.firstWhere(
            (attr) => attr.name == name,
        orElse: () => ProductAttributeModel(name: name, values: []),
      );
      if (!existingAttribute.values!.contains(value)) {
        existingAttribute.values!.add(value);
      }
      if (!productAttributes.contains(existingAttribute)) {
        productAttributes.add(existingAttribute);
      }
      attributeNameController.clear();
      attributeValueController.clear();
    }
  }

  void removeProductAttribute(ProductAttributeModel attribute) {
    productAttributes.remove(attribute);
    // Remove this attribute from all variations
    for (var variation in productVariations) {
      variation.attributeValues.remove(attribute.name);
    }
  }

  void addProductVariation() {
    if (productAttributes.isEmpty) {
      Get.snackbar('Error', 'Please add at least one product attribute first');
      return;
    }

    Map<String, String> attributeValues = {};
    for (var attribute in productAttributes) {
      attributeValues[attribute.name!] =
          attribute.values!.first; // Default to first value
    }

    productVariations.add(ProductVariationModel(
      id: variationIdController.text.isEmpty
          ? DateTime.now().millisecondsSinceEpoch.toString()
          : variationIdController.text,
      stock: int.tryParse(variationStockController.text) ?? 0,
      price: double.tryParse(variationPriceController.text) ?? 0.0,
      salePrice: double.tryParse(variationSalePriceController.text) ?? 0.0,
      description: variationDescriptionController.text,
      sku: variationSkuController.text,
      attributeValues: attributeValues,
    ));

    variationIdController.clear();
    variationStockController.clear();
    variationPriceController.clear();
    variationSalePriceController.clear();
    variationDescriptionController.clear();
    variationSkuController.clear();
  }

  void removeProductVariation(ProductVariationModel variation) {
    productVariations.remove(variation);
  }


  final selectedColorValues = ''.obs;
  final sizeInputControllers = TextEditingController();

  void addAttributes() {
    if (selectedAttributeType.value == 'Color') {
      String colorValue = selectedColorValues.value;
      if (!productAttributes.any((attr) => attr.name == 'Color')) {
        productAttributes.add(ProductAttributeModel(
          name: 'Color',
          values: [colorValue],
        ));
      } else {
        productAttributes
            .firstWhere((attr) => attr.name == 'Color')
            .values!
            .add(colorValue);
      }
    } else if (selectedAttributeType.value == 'Size') {
      String sizeValue = sizeInputControllers.text;
      if (!productAttributes.any((attr) => attr.name == 'Size')) {
        productAttributes.add(ProductAttributeModel(
          name: 'Size',
          values: [sizeValue],
        ));
      } else {
        productAttributes
            .firstWhere((attr) => attr.name == 'Size')
            .values!
            .add(sizeValue);
      }
    }

    // Clear input controllers or selected values after adding attribute
    sizeInputControllers.clear();
    selectedColorValues.value = '';
  }

  ///
  ///
  ///
  ///  ---------- Attributes  & Variations ---------------------------------

  // Fetch brands from Firestore
  void fetchBrands() async {
    try {
      final brandsSnapshot = await _firestore.collection('Brands').get();
      if (brandsSnapshot.docs.isNotEmpty) {
        brands.assignAll(brandsSnapshot.docs
            .map((doc) => NewBrandModel.fromQuerySnapshot(doc))
            .toList());
        filteredBrands.assignAll(brands);
      }
    } catch (error) {
      print('Error fetching brands: $error');
    }
  }

  // Method to filter brands based on search text
  void filterBrands(String searchText) {
    if (searchText.isEmpty) {
      filteredBrands.assignAll(brands);
    } else {
      var filteredList = brands
          .where((brand) =>
          brand.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      filteredBrands.assignAll(filteredList);
    }
  }

  // Method to add a new product
  Future<void> addProduct() async {
    String? validationError = _validateProduct();
    if (validationError != null) {
      Get.snackbar('Error', validationError,
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    List<String> imageUrls =
    await uploadImagesToFirebase(selectedImages.toList());
    final newProductId = await _getNextProductId();

    // New #####################################333


    // Upload thumbnail
    String thumbnailUrls = '';
    if (thumbnailImage.value != null) {
      thumbnailUrls = await uploadImageToFirebase(thumbnailImage.value, 'thumbnails');
    }

    // // Upload product images
    // List<String> productImageUrls = [];
    // for (var image in productImages) {
    //   String url = await uploadImageToFirebase(image, 'product_images');
    //   if (url.isNotEmpty) {
    //     productImageUrls.add(url);
    //   }
    // }
    Future<List<String>> uploadProductImages() async {
      List<String> productImageUrls = [];
      for (var imageEntry in productImages.entries) {
        Uint8List imageData = imageEntry.value;
        String url = await uploadImageToFirebase(imageData, 'product_images');
        if (url.isNotEmpty) {
          productImageUrls.add(url);
        }
      }
      return productImageUrls;
    }

    // Upload variation images and update variations
    for (var variation in productVariations) {
      if (variationImages.containsKey(variation.id)) {
        String url = await uploadImageToFirebase(variationImages[variation.id], 'variation_images');
        if (url.isNotEmpty) {
          variation.image = url;
        }
      }
    }

    List<String> productImageUrls = await uploadProductImages();
    await uploadVariationImages();


    final product = ProductModel(
      id: newProductId,
      title: titleController.text.trim(),
      stock: int.parse(stockController.text),
      price: double.parse(priceController.text),
      salePrice: double.parse(salePriceController.text),
      sku: skuController.text.trim(),
      thumbnail: thumbnailUrls,
      productType: selectedProductType.value,
      description: descriptionController.text.trim(),
      categoryId: categoryIdController.text.trim(),
      images: productImageUrls,
      isFeatured: isFeatured.value,
      brand: selectedBrand.value,
      date: DateTime.now(),
      productAttributes: productAttributes,
      productVariations: productVariations,
    );

    try {
      await _firestore
          .collection('Products')
          .doc(newProductId)
          .set(product.toJson());

      if (selectedBrand.value != null) {
        await _updateBrandProductCount(selectedBrand.value!.id);
      }

      Get.snackbar('Success', 'Product added successfully',
          backgroundColor: Colors.green, colorText: Colors.white);
      _clearForm();
    } catch (error) {
      Get.snackbar('Error', 'Failed to add product: $error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Method to select a brand
  void selectBrand(NewBrandModel brand) {
    selectedBrand.value = brand;
  }

  // Method to select thumbnail image from gallery
  // Future<void> selectThumbnailImage() async {
  //   try {
  //     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //     if (pickedFile != null) {
  //       File thumbnailFile = File(pickedFile.path);
  //       String thumbnailUrl = await uploadThumbnailToFirebase(thumbnailFile);
  //       if (thumbnailUrl.isNotEmpty) {
  //         this.thumbnailUrl.value = thumbnailUrl;
  //       }
  //     } else {
  //       print('No image selected');
  //     }
  //   } catch (e) {
  //     print('Error selecting thumbnail image: $e');
  //   }
  // }

  // Example of platform-specific upload code for thumbnail image
  Future<String> uploadThumbnailToFirebase(File thumbnailFile) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}_thumbnail';
      Reference ref = _storage.ref().child('thumbnails').child(fileName);

      TaskSnapshot uploadTask;
      if (kIsWeb) {
        // Web-specific upload method
        uploadTask = await ref.putData(await thumbnailFile.readAsBytes());
      } else {
        // Mobile (Android/iOS) specific upload method
        uploadTask = await ref.putFile(thumbnailFile);
      }

      String downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading thumbnail: $e');
      return '';
    }
  }

  Future<List<String>> uploadImagesToFirebase(List<File?> images) async {
    List<String> downloadUrls = [];

    try {
      for (int i = 0; i < images.length; i++) {
        File? image = images[i];
        if (image != null) {
          String fileName = '${DateTime.now().millisecondsSinceEpoch}_$i';
          Reference ref = _storage.ref().child('images').child(fileName);

          TaskSnapshot uploadTask = await ref.putFile(image);
          String downloadUrl = await uploadTask.ref.getDownloadURL();
          downloadUrls.add(downloadUrl);
        }
      }
    } catch (e) {
      print('Error uploading image: $e');
    }

    return downloadUrls;
  }

  String? _validateProduct() {
    if (titleController.text.trim().isEmpty) {
      return 'Please enter a product title';
    }
    if (priceController.text.isEmpty ||
        double.tryParse(priceController.text) == null) {
      return 'Please enter a valid price';
    }
    if (stockController.text.isEmpty ||
        int.tryParse(stockController.text) == null) {
      return 'Please enter a valid stock quantity';
    }
    if (selectedBrand.value == null) {
      return 'Please select a brand';
    }
    if (categoryIdController.text.trim().isEmpty) {
      return 'Please select a category';
    }
    return null;
  }

  Future<String> _getNextProductId() async {
    try {
      final counterDoc = _firestore.collection('counters').doc('Products');
      final snapshot = await counterDoc.get();

      if (snapshot.exists) {
        final data = snapshot.data()!;
        final currentId = data['lastId'] as int;
        final newId = currentId + 1;

        await counterDoc.update({'lastId': newId});
        return newId
            .toString()
            .padLeft(3, '0'); // Pads the ID with zeros (e.g., 001, 002, etc.)
      } else {
        await counterDoc.set({'lastId': 1});
        return '001';
      }
    } catch (e) {
      print('Error getting next product ID: $e');
      return '001'; // Return a default ID in case of error
    }
  }

  Future<void> _updateBrandProductCount(String brandId) async {
    try {
      await _firestore.collection('Brands').doc(brandId).update({
        'ProductsCount': FieldValue.increment(1),
      });
    } catch (e) {
      print('Error updating brand product count: $e');
    }
  }

  void _clearForm() {
    titleController.clear();
    stockController.clear();
    skuController.clear();
    priceController.clear();
    salePriceController.clear();
    descriptionController.clear();
    categoryIdController.clear();
    thumbnailUrl.value = '';
    thumbnailUrlController.clear();
    selectedImages.clear();
    isFeatured.value = false;
    selectedBrand.value = null;
    selectedProductType.value = ProductType.single;
    thumbnailImage.value = null;
    productImages.clear();
    variationImages.clear();
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    titleController.dispose();
    stockController.dispose();
    skuController.dispose();
    priceController.dispose();
    salePriceController.dispose();
    descriptionController.dispose();
    categoryIdController.dispose();
    thumbnailUrlController.dispose();
    categoryIdController.dispose();

    super.dispose();
  }
}