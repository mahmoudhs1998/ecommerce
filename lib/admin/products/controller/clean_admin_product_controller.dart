// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerce/admin/products/controller/test/logic.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../../data/repositories/category/category_repository.dart';
// import '../../../features/shop/models/brand_model.dart';
// import '../../../features/shop/models/category_model.dart';
// import '../../../features/shop/models/product_attribute_model.dart';
// import '../../../features/shop/models/product_model.dart';
// import '../../../features/shop/models/product_variation_model.dart';
//
// // class AdminPanelController extends GetxController {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   final titleController = TextEditingController();
// //   final stockController = TextEditingController();
// //   final skuController = TextEditingController();
// //   final priceController = TextEditingController();
// //   final salePriceController = TextEditingController();
// //   final thumbnailController = TextEditingController();
// //   final productTypeController = TextEditingController();
// //   final descriptionController = TextEditingController();
// //   final categoryIdController = TextEditingController();
// //   final imagesController = TextEditingController();
// //   final dateController = TextEditingController();
// //   final brandIdController = TextEditingController();
// //   final brandImageController = TextEditingController();
// //   final brandNameController = TextEditingController();
// //   final brandProductsCountController = TextEditingController();
// //   final categoryRepository = Get.put(CategoryRepository());
// //
// //   final isFeatured = false.obs;
// //   final brandIsFeatured = false.obs;
// //
// //   var productAttributes = <ProductAttributeModel>[].obs;
// //   var productVariations = <ProductVariationModel>[].obs;
// //   final Rx<XFile?> selectedThumbnailImage = Rx<XFile?>(null);
// //
// //
// //   // Assuming you have a list of categories and subcategories
// //   Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
// //   Rx<SubCategoryModel?> selectedSubcategory = Rx<SubCategoryModel?>(null);
// //   RxList<CategoryModel> categories = <CategoryModel>[].obs;
// //   RxList<SubCategoryModel> subcategories = <SubCategoryModel>[].obs;
// //   // Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
// //   //
// //   // RxList<BrandModel> sbrands = <BrandModel>[].obs;
// //   TextEditingController sbrandIdController = TextEditingController();
// //   TextEditingController sbrandImageController = TextEditingController();
// //   TextEditingController sbrandNameController = TextEditingController();
// //   Rx<NewBrandModel?> selectedBrand = Rx<NewBrandModel?>(null);
// //   RxList<NewBrandModel> allBrands = <NewBrandModel>[].obs;
// //
// //   RxList<CategoryModel> subCategories = <CategoryModel>[].obs;
// //
// //   final SubCategoryRepository subCategoryRepository = Get.put(SubCategoryRepository());
// //   bool isAddingColor = true;
// //
// //   void toggleAttributeType() {
// //     isAddingColor = !isAddingColor;
// //   }
// //
// //   void addAttribute(String name, List<String> values) {
// //     productAttributes.add(ProductAttributeModel(name: name, values: values));
// //   }
// //
// //   void addVariation(ProductVariationModel variation) {
// //     productVariations.add(variation); // Assuming productVariations is a RxList<ProductVariationModel>
// //     print('Added variation: $variation');
// //   }
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     getSubCategories();
// //     fetchAllCategories();
// //
// //     fetchSubcategories();
// //     fetchBrands();
// //   }
// //   Future<void> fetchAllCategories() async {
// //     try {
// //       categories.value = await categoryRepository.getAllCategories();
// //     } catch (e) {
// //       Get.snackbar('Error', 'Failed to fetch categories: $e');
// //     }
// //   }
// //
// //   Future<void> fetchSubcategories() async {
// //     try {
// //       List<SubCategoryModel> updatedSubCategories = await subCategoryRepository.getSubCategoriess();
// //       subcategories.assignAll(updatedSubCategories);
// //     } catch (e) {
// //       print('Error fetching subcategories: $e');
// //       // Handle error, show message, etc.
// //     }
// //   }
// //
// //
// //   // Fetch Brands
// //
// //   Future<void> fetchBrands() async {
// //     try {
// //       List<NewBrandModel> brands = await getBrands();
// //       brands.assignAll(brands);
// //     } catch (e) {
// //       print('Error fetching brands: $e');
// //       // Handle error, show message, etc.
// //     }
// //   }
// //
// //   void selectBrandByName(String name) {
// //     selectedBrand.value = allBrands.firstWhere((brand) => brand.name == name, orElse: () => NewBrandModel.empty());
// //     print('Selected brand updated to: ${selectedBrand.value?.name}');
// //     if (selectedBrand.value != null) {
// //       sbrandIdController.text = selectedBrand.value!.id;
// //       sbrandImageController.text = selectedBrand.value!.image;
// //       sbrandNameController.text = selectedBrand.value!.name;
// //     } else {
// //       sbrandIdController.clear();
// //       sbrandImageController.clear();
// //       sbrandNameController.clear();
// //     }
// //   }
// //
// //   Future<List<NewBrandModel>> getBrands() async {
// //     try {
// //       QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('Brands').get();
// //       return snapshot.docs.map((doc) => NewBrandModel.fromSnapshot(doc)).toList();
// //     } catch (e) {
// //       print('Error fetching brands: $e');
// //       throw Exception('Failed to fetch brands');
// //     }
// //   }
// //
// //   // Future<void> fetchBrands() async {
// //   //   try {
// //   //     List<BrandModel> brands = await subCategoryRepository.getBrands();
// //   //     sbrands.assignAll(brands);
// //   //   } catch (e) {
// //   //     print('Error fetching subcategories: $e');
// //   //     // Handle error, show message, etc.
// //   //   }
// //   // }
// //   //
// //   // void selectBrandByName(String brandName) {
// //   //   // Find the subcategory by name from your list of subcategories
// //   //   BrandModel? brand = sbrands.firstWhere(
// //   //         (brand) => brand.name == brandName,
// //   //     orElse: () => BrandModel.empty(),
// //   //   );
// //   //   selectedBrand.value= brand;
// //   // }
// //   void getSubCategories() {
// //     subCategoryRepository.getSubCategories().listen((updatedSubCategories) {
// //       subCategories.value = updatedSubCategories;
// //     });
// //   }
// //   void selectCategoryByName(String categoryName) {
// //     // Find the category by name from your list of categories
// //     CategoryModel? category = categories.firstWhere(
// //           (cat) => cat.name == categoryName,
// //       orElse: () => CategoryModel.empty(),
// //     );
// //     selectedCategory.value = category;
// //   }
// //
// //   void selectSubcategoryByName(String subcategoryName) {
// //     // Find the subcategory by name from your list of subcategories
// //     SubCategoryModel? subcategory = subcategories.firstWhere(
// //           (subcat) => subcat.name == subcategoryName,
// //       orElse: () => SubCategoryModel.empty(),
// //     );
// //     selectedSubcategory.value = subcategory;
// //   }
// //   Future<void> pickImage() async {
// //     final ImagePicker picker = ImagePicker();
// //     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// //     if (image != null) {
// //       selectedThumbnailImage.value = image;
// //     }
// //   }
// //
// //
// //   Future<String> uploadImage(XFile image) async {
// //     final storageRef = FirebaseStorage.instance.ref();
// //     final imagesRef = storageRef.child('images/${image.name}');
// //     try {
// //       if (kIsWeb) {
// //         // For web, use bytes
// //         final Uint8List imageData = await image.readAsBytes();
// //         await imagesRef.putData(imageData);
// //       } else {
// //         // For mobile, use File
// //         await imagesRef.putFile(File(image.path));
// //       }
// //       final imageUrl = await imagesRef.getDownloadURL();
// //       return imageUrl;
// //     } catch (e) {
// //       throw Exception('Failed to upload image: $e');
// //     }
// //   }
// //
// //   // pick images :
// //
// //   // Declare the list to hold selected images
// //   final RxList<XFile?> selectedImages = RxList<XFile?>([]);
// //   final RxList<String> uploadedImageUrls = RxList<String>([]);
// //
// // // Function to pick multiple images
// //   Future<void> pickImages() async {
// //     final ImagePicker picker = ImagePicker();
// //     List<XFile>? pickedImages =
// //     await picker.pickMultiImage(); // Use pickMultiImage for multiple images
// //     if (pickedImages != null) {
// //       selectedImages.addAll(pickedImages);
// //     }
// //   }
// //
// // // Function to upload a single image
// //   Future<String> uploadImages(XFile image) async {
// //     final storageRef = FirebaseStorage.instance.ref();
// //     final imagesRef = storageRef.child('images/${image.name}');
// //     try {
// //       if (kIsWeb) {
// //         // For web, use bytes
// //         final Uint8List imageData = await image.readAsBytes();
// //         await imagesRef.putData(imageData);
// //       } else {
// //         // For mobile, use File
// //         await imagesRef.putFile(File(image.path));
// //       }
// //       final imageUrl = await imagesRef.getDownloadURL();
// //       return imageUrl;
// //     } catch (e) {
// //       throw Exception('Failed to upload image: $e');
// //     }
// //   }
// //
// // // Function to upload all selected images and store their URLs
// //   Future<void> uploadAllImages() async {
// //     for (XFile? image in selectedImages) {
// //       if (image != null) {
// //         final String imageUrl = await uploadImage(image);
// //         uploadedImageUrls.add(imageUrl);
// //       }
// //     }
// //   }
// //
// //   void addProduct() async {
// //     if (titleController.text.isNotEmpty &&
// //         priceController.text.isNotEmpty &&
// //         stockController.text.isNotEmpty) {
// //       final newProductId = await _getNextProductId();
// //       // Upload image to Firebase Storage and get the URL
// //       final String imageUrl = await uploadImage(selectedThumbnailImage.value!);
// //
// //       final product = ProductModel(
// //         id: newProductId,
// //         title: titleController.text,
// //         stock: int.parse(stockController.text),
// //         price: double.parse(priceController.text),
// //         salePrice: double.parse(salePriceController.text),
// //         sku: skuController.text,
// //         thumbnail: imageUrl, //thumbnailController.text,
// //         productType: productTypeController.text,
// //         description: descriptionController.text,
// //         categoryId: categoryIdController.text,
// //         images: uploadedImageUrls
// //             .toList(), //imagesController.text.split(',').map((e) => e.trim()).toList(),
// //         isFeatured: isFeatured.value,
// //         brand: NewBrandModel(
// //           id: brandIdController.text,
// //           image: brandImageController.text,
// //           name: brandNameController.text,
// //           productsCount: int.parse(brandProductsCountController.text),
// //           isFeatured: brandIsFeatured.value,
// //         ),
// //         date: DateTime.now(),
// //         productAttributes: productAttributes.toList(),
// //         productVariations: productVariations.toList(),
// //       );
// //
// //       // Save to Firestore and update brand's product count
// //       _firestore
// //           .collection('Products')
// //           .doc(newProductId)
// //           .set(product.toJson())
// //           .then((_) {
// //         _updateBrandProductCount(product.brand!.id);
// //         Get.snackbar('Success', 'Product added successfully');
// //         _clearForm();
// //       }).catchError((error) {
// //         Get.snackbar('Error', 'Failed to add product: $error');
// //       });
// //     }
// //   }
// //
// //   Future<String> _getNextProductId() async {
// //     final counterDoc = _firestore.collection('counters').doc('Products');
// //     final snapshot = await counterDoc.get();
// //
// //     if (snapshot.exists) {
// //       final data = snapshot.data()!;
// //       final currentId = data['lastId'] as int;
// //       final newId = currentId + 1;
// //
// //       await counterDoc.update({'lastId': newId});
// //       return newId
// //           .toString()
// //           .padLeft(3, '0'); // Pads the ID with zeros (e.g., 001, 002, etc.)
// //     } else {
// //       // If the document doesn't exist, initialize it
// //       await counterDoc.set({'lastId': 1});
// //       return '001';
// //     }
// //   }
// //
// //   void _updateBrandProductCount(String brandId) {
// //     _firestore.collection('Brands').doc(brandId).update({
// //       'ProductsCount': FieldValue.increment(1),
// //     });
// //   }
// //
// //   void _clearForm() {
// //     titleController.clear();
// //     stockController.clear();
// //     skuController.clear();
// //     priceController.clear();
// //     salePriceController.clear();
// //     thumbnailController.clear();
// //     selectedThumbnailImage.value = null;
// //     selectedImages.clear();
// //     uploadedImageUrls.clear();
// //     productTypeController.clear();
// //     descriptionController.clear();
// //     categoryIdController.clear();
// //     imagesController.clear();
// //     dateController.clear();
// //     brandIdController.clear();
// //     brandImageController.clear();
// //     brandNameController.clear();
// //     brandProductsCountController.clear();
// //     productAttributes.clear();
// //     productVariations.clear();
// //     isFeatured.value = false;
// //     brandIsFeatured.value = false;
// //   }
// //
// //   @override
// //   void onClose() {
// //     titleController.dispose();
// //     stockController.dispose();
// //     skuController.dispose();
// //     priceController.dispose();
// //     salePriceController.dispose();
// //     thumbnailController.dispose();
// //     selectedThumbnailImage.value = null;
// //     selectedImages.clear();
// //     uploadedImageUrls.clear();
// //     productTypeController.dispose();
// //     descriptionController.dispose();
// //     categoryIdController.dispose();
// //     imagesController.dispose();
// //     dateController.dispose();
// //     brandIdController.dispose();
// //     brandImageController.dispose();
// //     brandNameController.dispose();
// //     brandProductsCountController.dispose();
// //     super.onClose();
// //   }
// // }
//
//
// class AdminPanelController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   final titleController = TextEditingController();
//   final stockController = TextEditingController();
//   final skuController = TextEditingController();
//   final priceController = TextEditingController();
//   final salePriceController = TextEditingController();
//   final thumbnailController = TextEditingController();
//   final productTypeController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final categoryIdController = TextEditingController();
//   final imagesController = TextEditingController();
//   final dateController = TextEditingController();
//   final brandIdController = TextEditingController();
//   final brandImageController = TextEditingController();
//   final brandNameController = TextEditingController();
//   final brandProductsCountController = TextEditingController();
//   final categoryRepository = Get.put(CategoryRepository());
//   final SubCategoryRepository subCategoryRepository = Get.put(SubCategoryRepository());
//   RxList<SubCategoryModel> subcategories = <SubCategoryModel>[].obs;
//   RxList<CategoryModel> categories = <CategoryModel>[].obs;
//   bool isAddingColor = true;
//
//   void toggleAttributeType() {
//     isAddingColor = !isAddingColor;
//   }
//
//   void addAttribute(String name, List<String> values) {
//     productAttributes.add(ProductAttributeModel(name: name, values: values));
//   }
//
//   void addVariation(ProductVariationModel variation) {
//     productVariations.add(variation); // Assuming productVariations is a RxList<ProductVariationModel>
//     print('Added variation: $variation');
//   }
//
//   //   void selectBrandByName(String brandName) {
//   //   // Find the subcategory by name from your list of subcategories
//   //   NewBrandModel? brand = allBrands.firstWhere(
//   //         (brand) => brand.name == brandName,
//   //     orElse: () => NewBrandModel.empty(),
//   //   );
//   //   selectedBrand.value= brand;
//   // }
//
//     Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
//   Rx<SubCategoryModel?> selectedSubcategory = Rx<SubCategoryModel?>(null);
//     // RxList<SubCategoryModel> subcategories = <SubCategoryModel>[].obs;
//
//   // Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
//   void getSubCategories() {
//     subCategoryRepository.getSubCategories().listen((updatedSubCategories) {
//       subcategories.value = updatedSubCategories.cast<SubCategoryModel>();
//     });
//   }
//   void selectCategoryByName(String categoryName) {
//     // Find the category by name from your list of categories
//     CategoryModel? category = categories.firstWhere(
//           (cat) => cat.name == categoryName,
//       orElse: () => CategoryModel.empty(),
//     );
//     selectedCategory.value = category;
//   }
//
//   void selectSubcategoryByName(String subcategoryName) {
//     // Find the subcategory by name from your list of subcategories
//     SubCategoryModel? subcategory = subcategories.firstWhere(
//           (subcat) => subcat.name == subcategoryName,
//       orElse: () => SubCategoryModel.empty(),
//     );
//     selectedSubcategory.value = subcategory;
//   }
//   final isFeatured = false.obs;
//   final brandIsFeatured = false.obs;
//   final Rx<XFile?> selectedThumbnailImage = Rx<XFile?>(null);
//
//   Rx<NewBrandModel?> selectedBrand = Rx<NewBrandModel?>(null);
//   RxList<NewBrandModel> allBrands = <NewBrandModel>[].obs;
//
//   var productAttributes = <ProductAttributeModel>[].obs;
//   var productVariations = <ProductVariationModel>[].obs;
//   final RxList<XFile?> selectedImages = RxList<XFile?>([]);
//   final RxList<String> uploadedImageUrls = RxList<String>([]);
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchAllCategories();
//     fetchSubcategories();
//     fetchBrands();
//   }
//
//   Future<void> fetchAllCategories() async {
//     try {
//       categories.value = await categoryRepository.getAllCategories();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch categories: $e');
//     }
//   }
//
//   Future<void> fetchSubcategories() async {
//     try {
//       List<SubCategoryModel> updatedSubCategories = await subCategoryRepository.getSubCategoriess();
//       subcategories.assignAll(updatedSubCategories);
//     } catch (e) {
//       print('Error fetching subcategories: $e');
//     }
//   }
//
//   Future<void> fetchBrands() async {
//     try {
//       List<NewBrandModel> brands = await getBrands();
//       allBrands.assignAll(brands);
//     } catch (e) {
//       print('Error fetching brands: $e');
//     }
//   }
//
//   Future<List<NewBrandModel>> getBrands() async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('Brands').get();
//       return snapshot.docs.map((doc) => NewBrandModel.fromSnapshot(doc)).toList();
//     } catch (e) {
//       print('Error fetching brands: $e');
//       throw Exception('Failed to fetch brands');
//     }
//   }
//
//   void selectBrandByName(String name) {
//     selectedBrand.value =
//         allBrands.firstWhere((brand) => brand.name == name, orElse: () => NewBrandModel.empty());
//     updateBrandControllers();
//   }
//
//   void updateBrandControllers() {
//     if (selectedBrand.value != null) {
//       brandIdController.text = selectedBrand.value!.id;
//       brandImageController.text = selectedBrand.value!.image;
//       brandNameController.text = selectedBrand.value!.name;
//       brandProductsCountController.text = selectedBrand.value!.productsCount.toString();
//       brandIsFeatured.value = selectedBrand.value!.isFeatured ?? false;
//     } else {
//       brandIdController.clear();
//       brandImageController.clear();
//       brandNameController.clear();
//       brandProductsCountController.clear();
//       brandIsFeatured.value = false;
//     }
//   }
//
//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       selectedThumbnailImage.value = image;
//     }
//   }
//
//   Future<void> pickImages() async {
//     final ImagePicker picker = ImagePicker();
//     List<XFile>? pickedImages = await picker.pickMultiImage();
//     if (pickedImages != null) {
//       selectedImages.addAll(pickedImages);
//     }
//   }
//
//   Future<String> uploadImage(XFile image) async {
//     final storageRef = FirebaseStorage.instance.ref();
//     final imagesRef = storageRef.child('images/${image.name}');
//     try {
//       if (kIsWeb) {
//         final Uint8List imageData = await image.readAsBytes();
//         await imagesRef.putData(imageData);
//       } else {
//         await imagesRef.putFile(File(image.path));
//       }
//       final imageUrl = await imagesRef.getDownloadURL();
//       return imageUrl;
//     } catch (e) {
//       throw Exception('Failed to upload image: $e');
//     }
//   }
//
//   Future<void> uploadAllImages() async {
//     for (XFile? image in selectedImages) {
//       if (image != null) {
//         final String imageUrl = await uploadImage(image);
//         uploadedImageUrls.add(imageUrl);
//       }
//     }
//   }
//
//   void addProduct() async {
//     if (titleController.text.isNotEmpty &&
//         priceController.text.isNotEmpty &&
//         stockController.text.isNotEmpty &&
//         selectedThumbnailImage.value != null &&
//         selectedBrand.value != null) {
//       try {
//         final newProductId = await _getNextProductId();
//         final String imageUrl = await uploadImage(selectedThumbnailImage.value!);
//
//         final product = ProductModel(
//           id: newProductId,
//           title: titleController.text,
//           stock: int.parse(stockController.text),
//           price: double.parse(priceController.text),
//           salePrice: double.parse(salePriceController.text),
//           sku: skuController.text,
//           thumbnail: imageUrl,
//           productType: productTypeController.text,
//           description: descriptionController.text,
//           categoryId: categoryIdController.text,
//           images: uploadedImageUrls.toList(),
//           isFeatured: isFeatured.value,
//           brand: NewBrandModel(
//             id: brandIdController.text,
//             image: brandImageController.text,
//             name: brandNameController.text,
//             productsCount: int.parse(brandProductsCountController.text),
//             isFeatured: brandIsFeatured.value,
//           ),
//           date: DateTime.now(),
//           productAttributes: productAttributes.toList(),
//           productVariations: productVariations.toList(),
//         );
//
//         await _firestore.collection('Products').doc(newProductId).set(product.toJson());
//
//         _updateBrandProductCount(product.brand!.id);
//         Get.snackbar('Success', 'Product added successfully');
//         _clearForm();
//       } catch (e) {
//         Get.snackbar('Error', 'Failed to add product: $e');
//       }
//     } else {
//       Get.snackbar('Error', 'Please fill in all required fields');
//     }
//   }
//
//   Future<String> _getNextProductId() async {
//     final counterDoc = _firestore.collection('counters').doc('Products');
//     final snapshot = await counterDoc.get();
//
//     if (snapshot.exists) {
//       final data = snapshot.data()!;
//       final currentId = data['lastId'] as int;
//       final newId = currentId + 1;
//
//       await counterDoc.update({'lastId': newId});
//       return newId.toString().padLeft(3, '0');
//     } else {
//       await counterDoc.set({'lastId': 1});
//       return '001';
//     }
//   }
//
//   void _updateBrandProductCount(String brandId) {
//     _firestore.collection('Brands').doc(brandId).update({
//       'ProductsCount': FieldValue.increment(1),
//     });
//   }
//
//   void _clearForm() {
//     titleController.clear();
//     stockController.clear();
//     skuController.clear();
//     priceController.clear();
//     salePriceController.clear();
//     thumbnailController.clear();
//     selectedThumbnailImage.value = null;
//     selectedImages.clear();
//     uploadedImageUrls.clear();
//     productTypeController.clear();
//     descriptionController.clear();
//     categoryIdController.clear();
//     imagesController.clear();
//     dateController.clear();
//     brandIdController.clear();
//     brandImageController.clear();
//     brandNameController.clear();
//     brandProductsCountController.clear();
//     productAttributes.clear();
//     productVariations.clear();
//     isFeatured.value = false;
//     brandIsFeatured.value = false;
//   }
//
//   @override
//   void onClose() {
//     titleController.dispose();
//     stockController.dispose();
//     skuController.dispose();
//     priceController.dispose();
//     salePriceController.dispose();
//     thumbnailController.dispose();
//     selectedThumbnailImage.value = null;
//     selectedImages.clear();
//     uploadedImageUrls.clear();
//     productTypeController.dispose();
//     descriptionController.dispose();
//     categoryIdController.dispose();
//     imagesController.dispose();
//     dateController.dispose();
//     brandIdController.dispose();
//     brandImageController.dispose();
//     brandNameController.dispose();
//     brandProductsCountController.dispose();
//     super.onClose();
//   }
// }
//
//
//
// // -------------------------------
//
//
//
// class AddAttributeDialog extends StatelessWidget {
//   final Function(String, List<String>) onSubmit;
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController valuesController = TextEditingController();
//
//   AddAttributeDialog({Key? key, required this.onSubmit});
//
//   @override
//   Widget build(BuildContext context) {
//     String selectedAttributeType = 'Color'; // Default to Color
//
//     return AlertDialog(
//       title: const Text('Add Attribute'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           DropdownButtonFormField<String>(
//             value: selectedAttributeType,
//             items: ['Color', 'Size'].map((String attributeType) {
//               return DropdownMenuItem<String>(
//                 value: attributeType,
//                 child: Text(attributeType),
//               );
//             }).toList(),
//             onChanged: (String? newValue) {
//               if (newValue != null) {
//                 // Update the type of attribute being added
//                 selectedAttributeType = newValue;
//                 // Automatically set nameController based on selected type
//                 nameController.text = newValue;
//               }
//             },
//           ),
//           TextField(
//             controller: nameController,
//             decoration: const InputDecoration(labelText: 'Attribute Name'),
//           ),
//           TextField(
//             controller: valuesController,
//             decoration: const InputDecoration(labelText: 'Values (comma separated)'),
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Get.back();
//           },
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             final values = valuesController.text.split(',').map((e) => e.trim()).toList();
//             onSubmit(nameController.text, values);
//             Get.back();
//           },
//           child: const Text('Add Attribute'),
//         ),
//       ],
//     );
//   }
// }
//
// // -------------------------------
//
// class AddVariationDialog extends StatelessWidget {
//   final Function(ProductVariationModel) onSubmit;
//   final idController = TextEditingController();
//   final stockController = TextEditingController();
//   final priceController = TextEditingController();
//   final salePriceController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final attributesController = TextEditingController();
//
//   final Rx<XFile?> selectedImage = Rx<XFile?>(null);
//   final RxString uploadedImageUrl = RxString('');
//   final RxString attributeType = RxString('Color'); // Default attribute type
//
//   AddVariationDialog({Key? key, required this.onSubmit}) : super(key: key);
//
//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       selectedImage.value = image;
//     }
//   }
//
//   Future<void> uploadImage() async {
//     if (selectedImage.value == null) return;
//     final storageRef = FirebaseStorage.instance.ref();
//     final imagesRef = storageRef.child('images/${selectedImage.value!.name}');
//     try {
//       if (kIsWeb) {
//         // For web, use bytes
//         final Uint8List imageData = await selectedImage.value!.readAsBytes();
//         await imagesRef.putData(imageData);
//       } else {
//         // For mobile, use File
//         await imagesRef.putFile(File(selectedImage.value!.path));
//       }
//       final imageUrl = await imagesRef.getDownloadURL();
//       uploadedImageUrl.value = imageUrl;
//     } catch (e) {
//       throw Exception('Failed to upload image: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Add Variation'),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: idController,
//               decoration: const InputDecoration(labelText: 'ID'),
//             ),
//             TextField(
//               controller: stockController,
//               decoration: const InputDecoration(labelText: 'Stock'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: priceController,
//               decoration: const InputDecoration(labelText: 'Price'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: salePriceController,
//               decoration: const InputDecoration(labelText: 'Sale Price'),
//               keyboardType: TextInputType.number,
//             ),
//             Obx(() {
//               return selectedImage.value == null
//                   ? ElevatedButton(
//                 onPressed: pickImage,
//                 child: const Text('Pick Image'),
//               )
//                   : Column(
//                 children: [
//                   kIsWeb
//                       ? Image.network(selectedImage.value!.path)
//                       : Image.file(File(selectedImage.value!.path)),
//                   ElevatedButton(
//                     onPressed: uploadImage,
//                     child: const Text('Upload Image'),
//                   ),
//                   if (uploadedImageUrl.isNotEmpty)
//                     Text('Uploaded URL: ${uploadedImageUrl.value}'),
//                 ],
//               );
//             }),
//             TextField(
//               controller: descriptionController,
//               decoration: const InputDecoration(labelText: 'Description'),
//             ),
//             DropdownButtonFormField<String>(
//               value: attributeType.value,
//               onChanged: (newValue) {
//                 attributeType.value = newValue!;
//               },
//               items: ['Color', 'Size']
//                   .map((type) => DropdownMenuItem(
//                 value: type,
//                 child: Text(type),
//               ))
//                   .toList(),
//               decoration: const InputDecoration(
//                 labelText: 'Attribute Type',
//               ),
//             ),
//             TextField(
//               controller: attributesController,
//               decoration: const InputDecoration(
//                   labelText:
//                   'Attribute Values (key:value pairs separated by commas)'),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Get.back();
//           },
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             final attributeValues = attributesController.text
//                 .split(',')
//                 .fold<Map<String, String>>({}, (map, pair) {
//               final parts = pair.split(':');
//               if (parts.length == 2) {
//                 map[parts[0].trim()] = parts[1].trim();
//               }
//               return map;
//             });
//
//             onSubmit(ProductVariationModel(
//               id: idController.text,
//               stock: int.parse(stockController.text),
//               price: double.parse(priceController.text),
//               salePrice: double.parse(salePriceController.text),
//               image: uploadedImageUrl.value,
//               description: descriptionController.text,
//               attributeValues: attributeValues,
//             ));
//             Get.back();
//           },
//           child: const Text('Add Variation'),
//         ),
//       ],
//     );
//   }
// }
//
//




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../features/shop/models/product_attribute_model.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../features/shop/models/product_variation_model.dart';

// class AdminPanelController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   final titleController = TextEditingController();
//   final stockController = TextEditingController();
//   final skuController = TextEditingController();
//   final priceController = TextEditingController();
//   final salePriceController = TextEditingController();
//   final thumbnailController = TextEditingController();
//   final productTypeController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final categoryIdController = TextEditingController();
//   final imagesController = TextEditingController();
//   final dateController = TextEditingController();
//   final brandIdController = TextEditingController();
//   final brandImageController = TextEditingController();
//   final brandNameController = TextEditingController();
//   final brandProductsCountController = TextEditingController();
//
//   final isFeatured = false.obs;
//   final brandIsFeatured = false.obs;
//
//   var productAttributes = <ProductAttributeModel>[].obs;
//   var productVariations = <ProductVariationModel>[].obs;
//
//   void addProduct() async {
//     if (titleController.text.isNotEmpty &&
//         priceController.text.isNotEmpty &&
//         stockController.text.isNotEmpty) {
//       final newProductId = await _getNextProductId();
//
//       final product = ProductModel(
//         id: newProductId,
//         title: titleController.text,
//         stock: int.parse(stockController.text),
//         price: double.parse(priceController.text),
//         salePrice: double.parse(salePriceController.text),
//         sku: skuController.text,
//         thumbnail: thumbnailController.text,
//         productType: productTypeController.text,
//         description: descriptionController.text,
//         categoryId: categoryIdController.text,
//         images: imagesController.text.split(',').map((e) => e.trim()).toList(),
//         isFeatured: isFeatured.value,
//         brand: NewBrandModel(
//           id: brandIdController.text,
//           image: brandImageController.text,
//           name: brandNameController.text,
//           productsCount: int.parse(brandProductsCountController.text),
//           isFeatured: brandIsFeatured.value,
//         ),
//         date: DateTime.now(),
//         productAttributes: productAttributes.toList(),
//         productVariations: productVariations.toList(),
//       );
//
//       // Save to Firestore and update brand's product count
//       _firestore
//           .collection('Products')
//           .doc(newProductId)
//           .set(product.toJson())
//           .then((_) {
//         _updateBrandProductCount(product.brand!.id);
//         Get.snackbar('Success', 'Product added successfully');
//         _clearForm();
//       }).catchError((error) {
//         Get.snackbar('Error', 'Failed to add product: $error');
//       });
//     }
//   }
//
//   Future<String> _getNextProductId() async {
//     final counterDoc = _firestore.collection('counters').doc('Products');
//     final snapshot = await counterDoc.get();
//
//     if (snapshot.exists) {
//       final data = snapshot.data()!;
//       final currentId = data['lastId'] as int;
//       final newId = currentId + 1;
//
//       await counterDoc.update({'lastId': newId});
//       return newId
//           .toString()
//           .padLeft(3, '0'); // Pads the ID with zeros (e.g., 001, 002, etc.)
//     } else {
//       // If the document doesn't exist, initialize it
//       await counterDoc.set({'lastId': 1});
//       return '001';
//     }
//   }
//
//   void _updateBrandProductCount(String brandId) {
//     _firestore.collection('Brands').doc(brandId).update({
//       'ProductsCount': FieldValue.increment(1),
//     });
//   }
//
//   void _clearForm() {
//     titleController.clear();
//     stockController.clear();
//     skuController.clear();
//     priceController.clear();
//     salePriceController.clear();
//     thumbnailController.clear();
//     productTypeController.clear();
//     descriptionController.clear();
//     categoryIdController.clear();
//     imagesController.clear();
//     dateController.clear();
//     brandIdController.clear();
//     brandImageController.clear();
//     brandNameController.clear();
//     brandProductsCountController.clear();
//     productAttributes.clear();
//     productVariations.clear();
//     isFeatured.value = false;
//     brandIsFeatured.value = false;
//   }
//
//   @override
//   void onClose() {
//     titleController.dispose();
//     stockController.dispose();
//     skuController.dispose();
//     priceController.dispose();
//     salePriceController.dispose();
//     thumbnailController.dispose();
//     productTypeController.dispose();
//     descriptionController.dispose();
//     categoryIdController.dispose();
//     imagesController.dispose();
//     dateController.dispose();
//     brandIdController.dispose();
//     brandImageController.dispose();
//     brandNameController.dispose();
//     brandProductsCountController.dispose();
//     super.onClose();
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
// Import your model classes here
// import 'path_to_your_models/product_model.dart';
// import 'path_to_your_models/brand_model.dart';
// import 'path_to_your_models/product_attribute_model.dart';
// import 'path_to_your_models/product_variation_model.dart';

// Great

// class AdminPanelController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   // Text editing controllers
//   final titleController = TextEditingController();
//   final stockController = TextEditingController();
//   final skuController = TextEditingController();
//   final priceController = TextEditingController();
//   final salePriceController = TextEditingController();
//   final productTypeController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final categoryIdController = TextEditingController();
//   final brandIdController = TextEditingController();
//   final brandImageController = TextEditingController();
//   final brandNameController = TextEditingController();
//   final brandProductsCountController = TextEditingController();
// // Rx variables for images
//   Rx<File?> thumbnail = Rx<File?>(null);
//   Rx<File?> brandImage = Rx<File?>(null);
//   Rx<File?> variationImage = Rx<File?>(null);
//   // Observable variables
//   final isFeatured = false.obs;
//   final brandIsFeatured = false.obs;
//   var productAttributes = <ProductAttributeModel>[].obs;
//   var productVariations = <ProductVariationModel>[].obs;
//   RxList<dynamic> selectedImages = RxList<dynamic>([]);
//   final ImagePicker _picker = ImagePicker();
//
//   Rx<File?> selectedImage = Rx<File?>(null);
//   Rx<String?> uploadedImageUrl = Rx<String?>(null);
//
//
//   // new ----------------------
//
//  // Rx<File?> selectedImage = Rx<File?>(null);
//   RxString uploadedImageUrls = RxString('');
//
//   Future<void> pickSingleImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       selectedImage.value = File(image.path);
//       await uploadImageToFirebase();
//     }
//   }
//
//   Future<void> uploadImageToFirebase() async {
//     if (selectedImage.value == null) return;
//
//     try {
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       Reference ref = _storage.ref().child('images').child(fileName);
//
//       UploadTask uploadTask = ref.putFile(selectedImage.value!);
//       TaskSnapshot snapshot = await uploadTask;
//       String downloadUrl = await snapshot.ref.getDownloadURL();
//
//       uploadedImageUrl.value = downloadUrl;
//     } catch (e) {
//       print('Error uploading image to Firebase: $e');
//     }
//   }
//
//   void removeImage() {
//     if (selectedImage.value != null) {
//       selectedImage.value = null;
//       uploadedImageUrl.value = '';
//       // Optionally, delete image from Firebase storage
//       // Uncomment the following line to delete image from Firebase storage
//       // deleteImageFromFirebase();
//     }
//   }
//
//   ///Uncomment this method to delete image from Firebase storage
//   Future<void> deleteImageFromFirebase() async {
//     try {
//       await _storage.refFromURL(uploadedImageUrls.value).delete();
//       uploadedImageUrl.value = '';
//     } catch (e) {
//       print('Error deleting image from Firebase: $e');
//     }
//   }
//   // void pickSingleImage() async {
//   //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//   //   if (image != null) {
//   //     selectedImage.value = File(image.path);
//   //   }
//   // }
//   //
//   // void removeImage() {
//   //   selectedImage.value = null;
//   //   uploadedImageUrl.value = null;
//   // }
//   //
//   // Future<void> uploadImageToFirebase() async {
//   //   try {
//   //     if (selectedImage.value == null) {
//   //       throw ('No image selected.');
//   //     }
//   //
//   //     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//   //     Reference ref = _storage.ref().child('images').child(fileName);
//   //
//   //     final uploadTask = ref.putFile(selectedImage.value!);
//   //     final TaskSnapshot snapshot = await uploadTask;
//   //
//   //     final downloadUrl = await snapshot.ref.getDownloadURL();
//   //     uploadedImageUrl.value = downloadUrl;
//   //
//   //     Get.snackbar('Success', 'Image uploaded successfully');
//   //   } catch (e) {
//   //     Get.snackbar('Error', 'Failed to upload image: $e');
//   //   }
//   // }
//
//
//   void pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       if (kIsWeb) {
//         selectedImages.add(image);
//       } else {
//         selectedImages.add(File(image.path));
//       }
//     }
//   }
//
//   void removeImages(int index) {
//     if (index >= 0 && index < selectedImages.length) {
//       selectedImages.removeAt(index);
//     }
//   }
//
//   Future<List<String>> uploadImagesToFirebase(List<dynamic> images) async {
//     List<String> downloadUrls = [];
//
//     for (int i = 0; i < images.length; i++) {
//       dynamic image = images[i];
//       try {
//         String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '_$i';
//         Reference ref = _storage.ref().child('images').child(fileName);
//
//         UploadTask uploadTask;
//         if (kIsWeb) {
//           uploadTask = ref.putData(await image.readAsBytes());
//         } else {
//           uploadTask = ref.putFile(image);
//         }
//
//         TaskSnapshot snapshot = await uploadTask;
//         String downloadUrl = await snapshot.ref.getDownloadURL();
//         downloadUrls.add(downloadUrl);
//       } catch (e) {
//         print('Error uploading image $i: $e');
//       }
//     }
//
//     return downloadUrls;
//   }
//   void addProduct() async {
//     if (!_validateProduct()) {
//       Get.snackbar('Error', 'Please fill all required fields');
//       return;
//     }
//
//     List<String> imageUrls = await uploadImagesToFirebase(selectedImages);
//
//     final newProductId = await _getNextProductId();
//
//     final product = ProductModel(
//       id: newProductId,
//       title: titleController.text,
//       stock: int.parse(stockController.text),
//       price: double.parse(priceController.text),
//       salePrice: double.parse(salePriceController.text),
//       sku: skuController.text,
//       thumbnail: imageUrls.isNotEmpty ? imageUrls[0] : '',
//       productType: productTypeController.text,
//       description: descriptionController.text,
//       categoryId: categoryIdController.text,
//       images: imageUrls,
//       isFeatured: isFeatured.value,
//       brand: NewBrandModel(
//         id: brandIdController.text,
//         image: brandImageController.text,
//         name: brandNameController.text,
//         productsCount: int.parse(brandProductsCountController.text),
//         isFeatured: brandIsFeatured.value,
//       ),
//       date: DateTime.now(),
//       productAttributes: productAttributes.toList(),
//       productVariations: productVariations.toList(),
//     );
//
//     try {
//       await _firestore
//           .collection('Products')
//           .doc(newProductId)
//           .set(product.toJson());
//
//       await _updateBrandProductCount(product.brand!.id);
//
//       Get.snackbar('Success', 'Product added successfully');
//       _clearForm();
//     } catch (error) {
//       Get.snackbar('Error', 'Failed to add product: $error');
//     }
//   }
//
//   bool _validateProduct() {
//     return titleController.text.isNotEmpty &&
//         priceController.text.isNotEmpty &&
//         stockController.text.isNotEmpty &&
//         selectedImages.isNotEmpty;
//   }
//
//   Future<String> _getNextProductId() async {
//     final counterDoc = _firestore.collection('counters').doc('Products');
//     final snapshot = await counterDoc.get();
//
//     if (snapshot.exists) {
//       final data = snapshot.data()!;
//       final currentId = data['lastId'] as int;
//       final newId = currentId + 1;
//
//       await counterDoc.update({'lastId': newId});
//       return newId.toString().padLeft(3, '0'); // Pads the ID with zeros (e.g., 001, 002, etc.)
//     } else {
//       // If the document doesn't exist, initialize it
//       await counterDoc.set({'lastId': 1});
//       return '001';
//     }
//   }
//
//   Future<void> _updateBrandProductCount(String brandId) async {
//     await _firestore.collection('Brands').doc(brandId).update({
//       'ProductsCount': FieldValue.increment(1),
//     });
//   }
//
//   void _clearForm() {
//     titleController.clear();
//     stockController.clear();
//     skuController.clear();
//     priceController.clear();
//     salePriceController.clear();
//     productTypeController.clear();
//     descriptionController.clear();
//     categoryIdController.clear();
//     brandIdController.clear();
//     brandImageController.clear();
//     brandNameController.clear();
//     brandProductsCountController.clear();
//     productAttributes.clear();
//     productVariations.clear();
//     isFeatured.value = false;
//     brandIsFeatured.value = false;
//     selectedImages.clear();
//   }
//
//   void addAttribute(ProductAttributeModel attribute) {
//     productAttributes.add(attribute);
//   }
//
//   void removeAttribute(int index) {
//     productAttributes.removeAt(index);
//   }
//
//   void addVariation(ProductVariationModel variation) {
//     productVariations.add(variation);
//   }
//
//   void removeVariation(int index) {
//     productVariations.removeAt(index);
//   }
//
//   @override
//   void onClose() {
//     titleController.dispose();
//     stockController.dispose();
//     skuController.dispose();
//     priceController.dispose();
//     salePriceController.dispose();
//     productTypeController.dispose();
//     descriptionController.dispose();
//     categoryIdController.dispose();
//     brandIdController.dispose();
//     brandImageController.dispose();
//     brandNameController.dispose();
//     brandProductsCountController.dispose();
//     super.onClose();
//   }
// }


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../utils/constants/enums.dart';

class AdminPanelController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;



  // Text editing controllers
  final titleController = TextEditingController();
  final stockController = TextEditingController();
  final skuController = TextEditingController();
  final priceController = TextEditingController();
  final salePriceController = TextEditingController();
  final productTypeController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryIdController = TextEditingController();
  final brandIdController = TextEditingController();
  final brandImageController = TextEditingController();
  final brandNameController = TextEditingController();
  final brandProductsCountController = TextEditingController();
// Brands list
  RxList<NewBrandModel> brands = RxList<NewBrandModel>([]);
  // Rx variables for images
  Rx<File?> thumbnail = Rx<File?>(null);
  Rx<File?> brandImage = Rx<File?>(null);
  Rx<File?> variationImage = Rx<File?>(null);

  // Uploaded image URLs
  RxString thumbnailUrl = ''.obs;
  RxString brandImageUrl = ''.obs;
  RxString variationImageUrl = ''.obs;

  // Observable variables
  final isFeatured = false.obs;
  final brandIsFeatured = false.obs;
  var productAttributes = <ProductAttributeModel>[].obs;
  var productVariations = <ProductVariationModel>[].obs;
  RxList<dynamic> selectedImages = RxList<dynamic>([]);
  final ImagePicker _picker = ImagePicker();

  Rx<File?> selectedImage = Rx<File?>(null);
  Rx<String?> uploadedImageUrl = Rx<String?>(null);

  Rx<NewBrandModel?> selectedBrand = Rx<NewBrandModel?>(null);
  var sbrands = <NewBrandModel>[].obs;
  // new
  RxList<NewBrandModel> filteredBrands = RxList<NewBrandModel>([]);
  Rx<NewBrandModel?> selectedBrands = Rx<NewBrandModel?>(null);
  var brandss = <NewBrandModel>[].obs;
  RxList<NewBrandModel> filteredBrandss = RxList<NewBrandModel>([]);
  Rx<ProductType> productType = ProductType.single.obs;


  @override
  void onInit() {
    super.onInit();
    fetchBrands();
  }



// ------------------new

  void filterBrands(String query) {
    if (query.isEmpty) {
      filteredBrands.assignAll(brands);
    } else {
      filteredBrands.assignAll(brands.where(
              (brand) => brand.name.toLowerCase().contains(query.toLowerCase())
      ));
    }
  }

  void selectBrand(NewBrandModel brand) {
    selectedBrand.value = brand;
    print('Selected brand updated to: ${selectedBrand.value?.name}');
    if (selectedBrand.value != null) {
      brandIdController.text = brand.id;
      brandImageController.text = brand.image;
      brandNameController.text = brand.name;
      brandProductsCountController.text = brand.productsCount.toString();
      brandIsFeatured.value = brand.isFeatured ?? false;
    } else {
      _clearBrandFields();
    }
  }

  void _clearBrandFields() {
    brandIdController.clear();
    brandImageController.clear();
    brandNameController.clear();
    brandProductsCountController.clear();
    brandIsFeatured.value = false;
  }

  Future<void> fetchBrands() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('Brands').get();
      List<NewBrandModel> fetchedBrands = snapshot.docs.map((doc) => NewBrandModel.fromSnapshot(doc)).toList();
      brands.assignAll(fetchedBrands);
      filteredBrands.assignAll(fetchedBrands);
    } catch (e) {
      print('Error fetching brands: $e');
      Get.snackbar('Error', 'Failed to fetch brands');
    }
  }

  void selectBrandByName(String name) {
    selectedBrand.value = brands.firstWhere(
            (brand) => brand.name == name,
        orElse: () => NewBrandModel.empty()
    );
    print('Selected brand updated to: ${selectedBrand.value?.name}');
    if (selectedBrand.value != null && selectedBrand.value?.id.isNotEmpty == true) {
      brandIdController.text = selectedBrand.value!.id;
      brandImageController.text = selectedBrand.value!.image;
      brandNameController.text = selectedBrand.value!.name;
      brandProductsCountController.text = selectedBrand.value!.productsCount.toString();
      brandIsFeatured.value = selectedBrand.value!.isFeatured ?? false;
    } else {
      _clearBrandFields();
    }
  }

  Future<void> addProduct() async {
    if (!_validateProduct()) {
      Get.snackbar('Error', 'Please fill all required fields');
      return;
    }

    List<String> imageUrls = await uploadImagesToFirebase(selectedImages);

    final newProductId = await _getNextProductId();

    if (selectedBrand.value == null || selectedBrand.value?.id.isEmpty == true) {
      Get.snackbar('Error', 'Please select a valid brand');
      return;
    }

    final product = ProductModel(
      id: newProductId,
      title: titleController.text,
      stock: int.tryParse(stockController.text) ?? 0,
      price: double.tryParse(priceController.text) ?? 0.0,
      salePrice: double.tryParse(salePriceController.text) ?? 0.0,
      sku: skuController.text,
      thumbnail: imageUrls.isNotEmpty ? imageUrls[0] : '',
      productType: productType.value,
      description: descriptionController.text,
      categoryId: categoryIdController.text,
      images: imageUrls,
      isFeatured: isFeatured.value,
      brand: selectedBrand.value,
      date: DateTime.now(),
      productAttributes: productAttributes.toList(),
      productVariations: productVariations.toList(),
    );

    try {
      await _firestore
          .collection('Products')
          .doc(newProductId)
          .set(product.toJson());

      await _updateBrandProductCount(product.brand!.id);

      Get.snackbar('Success', 'Product added successfully');
      _clearForm();
    } catch (error) {
      Get.snackbar('Error', 'Failed to add product: $error');
    }
  }

  bool _validateProduct() {
    return titleController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        stockController.text.isNotEmpty &&
        thumbnailUrl.value.isNotEmpty &&
        selectedBrand.value != null &&
        selectedBrand.value?.id.isNotEmpty == true;
  }
  // ------------------new
  // Future<void> fetchBrands() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> snapshot =
  //     await _firestore.collection('Brands').get();
  //     List<NewBrandModel> brands =
  //     snapshot.docs.map((doc) => NewBrandModel.fromSnapshot(doc)).toList();
  //     this.brands.assignAll(brands);
  //   } catch (e) {
  //     print('Error fetching brands: $e');
  //     Get.snackbar('Error', 'Failed to fetch brands');
  //   }
  // }
  //
  // // Method to select a brand by name
  // void selectBrandByName(String name) {
  //   selectedBrand.value = brands.firstWhere(
  //         (brand) => brand.name.toLowerCase() == name.toLowerCase(),
  //     orElse: () => NewBrandModel.empty(),
  //   );
  //
  //   if (selectedBrand.value != null) {
  //     // Update UI or fields related to brand selection
  //     brandIdController.text = selectedBrand.value!.id;
  //     brandImageController.text = selectedBrand.value!.image;
  //     brandNameController.text = selectedBrand.value!.name;
  //     brandProductsCountController.text =
  //         selectedBrand.value!.productsCount.toString();
  //     brandIsFeatured.value = selectedBrand.value!.isFeatured!;
  //   } else {
  //     // Clear UI or fields if brand is not found
  //     brandIdController.clear();
  //     brandImageController.clear();
  //     brandNameController.clear();
  //     brandProductsCountController.clear();
  //     brandIsFeatured.value = false;
  //   }
  // }

  // void filterBrands(String query) {
  //   if (query.isEmpty) {
  //     filteredBrands.assignAll(sbrands);
  //   } else {
  //     filteredBrands.assignAll(sbrands.where(
  //             (brand) => brand.name.toLowerCase().contains(query.toLowerCase())
  //     ));
  //   }
  // }
  //
  // void selectBrand(NewBrandModel brand) {
  //   selectedBrand.value = brand;
  //   print('Selected brand updated to: ${selectedBrand.value?.name}');
  //   if (selectedBrand.value != null) {
  //     brandIdController.text = brand.id;
  //     brandImageController.text = brand.image;
  //     brandNameController.text = brand.name;
  //     brandProductsCountController.text = brand.productsCount.toString();
  //     brandIsFeatured.value = brand.isFeatured!;
  //   } else {
  //     brandIdController.clear();
  //     brandImageController.clear();
  //     brandNameController.clear();
  //     brandProductsCountController.clear();
  //     brandIsFeatured.value = false;
  //   }
  // }
  // Future<void> fetchBrands() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('Brands').get();
  //     List<NewBrandModel> brands = snapshot.docs.map((doc) => NewBrandModel.fromSnapshot(doc)).toList();
  //     sbrands.assignAll(brands);
  //     filteredBrands.assignAll(brands);
  //   } catch (e) {
  //     print('Error fetching brands: $e');
  //     Get.snackbar('Error', 'Failed to fetch brands');
  //   }
  // }
  // // Update the selectBrandByName method
  // void selectBrandByName(String name) {
  //   selectedBrand.value = sbrands.firstWhere((brand) => brand.name == name, orElse: () => NewBrandModel.empty());
  //   print('Selected brand updated to: ${selectedBrand.value?.name}');
  //   if (selectedBrand.value != null) {
  //     brandIdController.text = selectedBrand.value!.id;
  //     brandImageController.text = selectedBrand.value!.image;
  //     brandNameController.text = selectedBrand.value!.name;
  //     brandProductsCountController.text = selectedBrand.value!.productsCount.toString();
  //     brandIsFeatured.value = selectedBrand.value!.isFeatured!;
  //   } else {
  //     brandIdController.clear();
  //     brandImageController.clear();
  //     brandNameController.clear();
  //     brandProductsCountController.clear();
  //     brandIsFeatured.value = false;
  //   }
  // }
  // Future<void> fetchBrands() async {
  //   try {
  //     List<NewBrandModel> brands = await getBrands();
  //     sbrands.assignAll(brands);
  //   } catch (e) {
  //     print('Error fetching brands: $e');
  //     // Handle error, show message, etc.
  //   }
  // }
  Future<List<NewBrandModel>> getBrands() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('Brands').get();
      return snapshot.docs.map((doc) => NewBrandModel.fromSnapshot(doc)).toList();
    } catch (e) {
      print('Error fetching brands: $e');
      throw Exception('Failed to fetch brands');
    }
  }


  Future<void> pickSingleImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
      await uploadImageToFirebase();
    }
  }

  Future<void> uploadImageToFirebase() async {
    if (selectedImage.value == null) return;

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('images').child(fileName);

      UploadTask uploadTask = ref.putFile(selectedImage.value!);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      uploadedImageUrl.value = downloadUrl;
    } catch (e) {
      print('Error uploading image to Firebase: $e');
    }
  }

  void removeImage() {
    if (selectedImage.value != null) {
      selectedImage.value = null;
      uploadedImageUrl.value = null;
      // Optionally, delete image from Firebase storage
      // Uncomment the following line to delete image from Firebase storage
      // deleteImageFromFirebase();
    }
  }

  Future<void> deleteImageFromFirebase(img) async {
    try {
      if (uploadedImageUrl.value != null) {
        await _storage.refFromURL(uploadedImageUrl.value!).delete();
        uploadedImageUrl.value = null;
      }
    } catch (e) {
      print('Error deleting image from Firebase: $e');
    }
  }

  void pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (kIsWeb) {
        selectedImages.add(image);
      } else {
        selectedImages.add(File(image.path));
      }
    }
  }

  void removeImages(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }

  Future<List<String>> uploadImagesToFirebase(List<dynamic> images) async {
    List<String> downloadUrls = [];

    for (int i = 0; i < images.length; i++) {
      dynamic image = images[i];
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '_$i';
        Reference ref = _storage.ref().child('images').child(fileName);

        UploadTask uploadTask;
        if (kIsWeb) {
          uploadTask = ref.putData(await image.readAsBytes());
        } else {
          uploadTask = ref.putFile(image);
        }

        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      } catch (e) {
        print('Error uploading image $i: $e');
      }
    }

    return downloadUrls;
  }

  // Future<void> addProduct() async {
  //   if (!_validateProduct()) {
  //     Get.snackbar('Error', 'Please fill all required fields');
  //     return;
  //   }
  //
  //   List<String> imageUrls = await uploadImagesToFirebase(selectedImages);
  //
  //   final newProductId = await _getNextProductId();
  //   // Find selected brand by name
  //   NewBrandModel? selectedBrand = brands.firstWhere(
  //         (brand) => brand.name == brandNameController.text,
  //     orElse: () => NewBrandModel.empty(), // Handle if brand is not found
  //   );
  //
  //   if (selectedBrand == null) {
  //     Get.snackbar('Error', 'Selected brand not found');
  //     return;
  //   }
  //   final product = ProductModel(
  //     id: newProductId,
  //     title: titleController.text,
  //     stock: int.parse(stockController.text),
  //     price: double.parse(priceController.text),
  //     salePrice: double.parse(salePriceController.text),
  //     sku: skuController.text,
  //     thumbnail: imageUrls.isNotEmpty ? imageUrls[0] : '',
  //     productType: productTypeController.text,
  //     description: descriptionController.text,
  //     categoryId: categoryIdController.text,
  //     images: imageUrls,
  //     isFeatured: isFeatured.value,
  //     // brand: NewBrandModel(
  //     //    id: selectedBrand.id,
  //     //    image: selectedBrand.image,
  //     //    name: selectedBrand.name, //brandNameController.text,
  //     //    productsCount: int.parse(brandProductsCountController.text),
  //     //    isFeatured: brandIsFeatured.value,
  //     //  ),
  //     brand: selectedBrand,
  //     // NewBrandModel(
  //     //   id: selectedBrand.id,
  //     //   image: selectedBrand.image,
  //     //   name: selectedBrand.name,
  //     //   productsCount: selectedBrand.productsCount,
  //     //   isFeatured: selectedBrand.isFeatured,
  //     // ),
  //     date: DateTime.now(),
  //     productAttributes: productAttributes.toList(),
  //     productVariations: productVariations.toList(),
  //   );
  //
  //   try {
  //     await _firestore
  //         .collection('Products')
  //         .doc(newProductId)
  //         .set(product.toJson());
  //
  //     await _updateBrandProductCount(product.brand!.id);
  //
  //     Get.snackbar('Success', 'Product added successfully');
  //     _clearForm();
  //   } catch (error) {
  //     Get.snackbar('Error', 'Failed to add product: $error');
  //   }
  // }
  // Future<void> addProduct() async {
  //   if (!_validateProduct()) {
  //     Get.snackbar('Error', 'Please fill all required fields');
  //     return;
  //   }
  //
  //   List<String> imageUrls = await uploadImagesToFirebase(selectedImages);
  //
  //   final newProductId = await _getNextProductId();
  //
  //   final product = ProductModel(
  //     id: newProductId,
  //     title: titleController.text,
  //     stock: int.parse(stockController.text),
  //     price: double.parse(priceController.text),
  //     salePrice: double.parse(salePriceController.text),
  //     sku: skuController.text,
  //     thumbnail: imageUrls.isNotEmpty ? imageUrls[0] : '',
  //     productType: productTypeController.text,
  //     description: descriptionController.text,
  //     categoryId: categoryIdController.text,
  //     images: imageUrls,
  //     isFeatured: isFeatured.value,
  //     brand: selectedBrand.value, // Use selectedBrand directly
  //     date: DateTime.now(),
  //     productAttributes: productAttributes.toList(),
  //     productVariations: productVariations.toList(),
  //   );
  //
  //   try {
  //     await _firestore.collection('Products').doc(newProductId).set(product.toJson());
  //
  //     await _updateBrandProductCount(product.brand!.id);
  //
  //     Get.snackbar('Success', 'Product added successfully');
  //     _clearForm();
  //   } catch (error) {
  //     Get.snackbar('Error', 'Failed to add product: $error');
  //   }
  // }
  //
  //
  // bool _validateProduct() {
  //   return titleController.text.isNotEmpty &&
  //       priceController.text.isNotEmpty &&
  //       stockController.text.isNotEmpty &&
  //       thumbnailUrl.value.isNotEmpty &&
  //       selectedBrand.value != null; // Make sure a brand is selected
  // }

  Future<String> _getNextProductId() async {
    final counterDoc = _firestore.collection('counters').doc('Products');
    final snapshot = await counterDoc.get();

    if (snapshot.exists) {
      final data = snapshot.data()!;
      final currentId = data['lastId'] as int;
      final newId = currentId + 1;

      await counterDoc.update({'lastId': newId});
      return newId.toString().padLeft(3, '0'); // Pads the ID with zeros (e.g., 001, 002, etc.)
    } else {
      // If the document doesn't exist, initialize it
      await counterDoc.set({'lastId': 1});
      return '001';
    }
  }

  Future<void> _updateBrandProductCount(String brandId) async {
    await _firestore.collection('Brands').doc(brandId).update({
      'ProductsCount': FieldValue.increment(1),
    });
  }

  void _clearForm() {
    titleController.clear();
    stockController.clear();
    skuController.clear();
    priceController.clear();
    salePriceController.clear();
    productTypeController.clear();
    descriptionController.clear();
    categoryIdController.clear();
    brandIdController.clear();
    brandImageController.clear();
    brandNameController.clear();
    brandProductsCountController.clear();
    productAttributes.clear();
    productVariations.clear();
    isFeatured.value = false;
    brandIsFeatured.value = false;
    selectedImages.clear();
    selectedImage.value = null;
    uploadedImageUrl.value = null;
    thumbnail.value = null;
    thumbnailUrl.value = '';
    brandImage.value = null;
    brandImageUrl.value = '';
    variationImage.value = null;
    variationImageUrl.value = '';
    selectedBrand.value = null;
    _clearBrandFields();
  }

  void addAttribute(ProductAttributeModel attribute) {
    productAttributes.add(attribute);
  }

  void removeAttribute(int index) {
    productAttributes.removeAt(index);
  }

  void addVariation(ProductVariationModel variation) {
    productVariations.add(variation);
  }

  void removeVariation(int index) {
    productVariations.removeAt(index);
  }

  // Methods for picking images
  Future<void> pickThumbnail() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      thumbnail.value = File(image.path);
      await _uploadImageToFirebase(thumbnail, thumbnailUrl);
    }
  }

  Future<void> pickBrandImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      brandImage.value = File(image.path);
      await _uploadImageToFirebase(brandImage, brandImageUrl);
    }
  }

  Future<void> pickVariationImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      variationImage.value = File(image.path);
      await _uploadImageToFirebase(variationImage, variationImageUrl);
    }
  }

  // Method for uploading images to Firebase
  Future<void> _uploadImageToFirebase(Rx<File?> imageFile, RxString imageUrl) async {
    if (imageFile.value == null) return;

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('images').child(fileName);

      UploadTask uploadTask = ref.putFile(imageFile.value!);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      imageUrl.value = downloadUrl;
    } catch (e) {
      print('Error uploading image to Firebase: $e');
    }
  }

  // Methods for removing images
  void removeThumbnail() {
    if (thumbnail.value != null) {
      thumbnail.value = null;
      thumbnailUrl.value = '';
      deleteImageFromFirebase(thumbnailUrl.value);
    }
  }

  void removeBrandImage() {
    if (brandImage.value != null) {
      brandImage.value = null;
      brandImageUrl.value = '';
      deleteImageFromFirebase(brandImageUrl.value);
    }
  }

  void removeVariationImage() {
    if (variationImage.value != null) {
      variationImage.value = null;
      variationImageUrl.value = '';
      deleteImageFromFirebase(variationImageUrl.value);
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    stockController.dispose();
    skuController.dispose();
    priceController.dispose();
    salePriceController.dispose();
    productTypeController.dispose();
    descriptionController.dispose();
    categoryIdController.dispose();
    brandIdController.dispose();
    brandImageController.dispose();
    brandNameController.dispose();
    brandProductsCountController.dispose();
    super.onClose();
  }
}
class AddAttributeDialog extends StatelessWidget {
  final Function(ProductAttributeModel) onSubmit;
  final nameController = TextEditingController();
  final valuesController = TextEditingController();

  AddAttributeDialog({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Attribute'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Attribute Name'),
          ),
          TextField(
            controller: valuesController,
            decoration: const InputDecoration(labelText: 'Values (comma separated)'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final values =
            valuesController.text.split(',').map((e) => e.trim()).toList();
            onSubmit(ProductAttributeModel(
                name: nameController.text, values: values));
            Get.back();
          },
          child: const Text('Add Attribute'),
        ),
      ],
    );
  }
}

class AddVariationDialog extends StatelessWidget {
  final Function(ProductVariationModel) onSubmit;
  final idController = TextEditingController();
  final stockController = TextEditingController();
  final priceController = TextEditingController();
  final salePriceController = TextEditingController();
  final imageController = TextEditingController();
  final descriptionController = TextEditingController();
  final attributesController = TextEditingController();

  AddVariationDialog({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Variation'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: idController,
            decoration: const InputDecoration(labelText: 'ID'),
          ),
          TextField(
            controller: stockController,
            decoration: const InputDecoration(labelText: 'Stock'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: salePriceController,
            decoration: const InputDecoration(labelText: 'Sale Price'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: imageController,
            decoration: const InputDecoration(labelText: 'Image URL'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: attributesController,
            decoration: const InputDecoration(
                labelText: 'Attributes (key:value pairs separated by commas)'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final attributeValues = attributesController.text.split(',').fold<Map<String, String>>({}, (map, pair) {
              final parts = pair.split(':');
              if (parts.length == 2) {
                map[parts[0].trim()] = parts[1].trim();
              }
              return map;
            });

            onSubmit(ProductVariationModel(
              id: idController.text,
              stock: int.parse(stockController.text),
              price: double.parse(priceController.text),
              salePrice: double.parse(salePriceController.text),
              image: imageController.text,
              description: descriptionController.text,
              attributeValues: attributeValues,
            ));
            Get.back();
          },
          child: const Text('Add Variation'),
        ),
      ],
    );
  }
}



// class SingleImageDisplay extends StatelessWidget {
//   final AdminPanelController controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final selectedImage = controller.selectedImage.value;
//
//       if (selectedImage != null) {
//         return kIsWeb
//             ? Image.network(selectedImage.path ?? '', fit: BoxFit.cover)
//             : Image.file(selectedImage, fit: BoxFit.cover);
//       } else {
//         return Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(Icons.add_photo_alternate, size: 50),
//         ); // Placeholder widget when no image is selected
//       }
//     });
//   }
// }


// class SingleImageDisplay extends StatelessWidget {
//   final AdminPanelController _controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Obx(() {
//           final selectedImage = _controller.selectedImage.value;
//
//           if (selectedImage != null) {
//             return kIsWeb
//                 ? Image.network(selectedImage.path ?? '', fit: BoxFit.cover)
//                 : Image.file(selectedImage, fit: BoxFit.cover);
//           } else {
//             return GestureDetector(
//               onTap: _controller.pickSingleImage,
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(Icons.add_photo_alternate, size: 50),
//               ),
//             ); // Placeholder widget when no image is selected
//           }
//         }),
//         ElevatedButton(
//           onPressed: _controller.removeImage,
//           child: Text('Remove Image'),
//         ),
//         Obx(() => _controller.uploadedImageUrl.value != null && _controller.uploadedImageUrl.value!.isNotEmpty
//             ? Text('Uploaded Image URL: ${_controller.uploadedImageUrl.value}')
//             : Container()), // Display uploaded image URL if available
//       ],
//     );
//   }
// }
class SingleImageDisplay extends StatelessWidget {
  final AdminPanelController _controller = Get.find();

  final Rx<File?> image;
  final RxString imageUrl;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;

  SingleImageDisplay({
    Key? key,
    required this.image,
    required this.imageUrl,
    required this.onPickImage,
    required this.onRemoveImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          final selectedImage = image.value;

          if (selectedImage != null) {
            return kIsWeb
                ? Image.network(selectedImage.path, fit: BoxFit.cover)
                : Image.file(selectedImage, fit: BoxFit.cover);
          } else {
            return GestureDetector(
              onTap: onPickImage,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.add_photo_alternate, size: 50),
              ),
            ); // Placeholder widget when no image is selected
          }
        }),
        Obx(() => imageUrl.value.isNotEmpty
            ? Column(
          children: [
            Text('Uploaded Image URL: ${imageUrl.value}'),
            ElevatedButton(
              onPressed: onRemoveImage,
              child: Text('Remove Image'),
            ),
          ],
        )
            : Container()), // Display uploaded image URL if available
      ],
    );
  }
}
class MultiImageDisplay extends StatelessWidget {
  final AdminPanelController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: controller.selectedImages.length + 1, // +1 for the add button
      itemBuilder: (context, index) {
        if (index == controller.selectedImages.length) {
          return GestureDetector(
            onTap: controller.pickImage,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.add_photo_alternate, size: 50),
            ),
          );
        }

        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _buildImageWidget(controller.selectedImages[index]!),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () => controller.removeImages(index),
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, size: 20, color: Colors.red),
                ),
              ),
            ),
          ],
        );
      },
    ));
  }

  Widget _buildImageWidget(dynamic image) {
    if (kIsWeb) {
      if (image is String) {
        // For web, when the image is already uploaded and we have a URL
        return Image.network(image, fit: BoxFit.cover);
      } else {
        // For web, when we have just picked the image and it's still a File
        return Image.network(image.path, fit: BoxFit.cover);
      }
    } else {
      // For mobile platforms
      return Image.file(image, fit: BoxFit.cover);
    }
  }
}


class ThumbnailDisplay extends StatelessWidget {
  final AdminPanelController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleImageDisplay(
      image: _controller.thumbnail,
      imageUrl: _controller.thumbnailUrl,
      onPickImage: _controller.pickThumbnail,
      onRemoveImage: _controller.removeThumbnail,
    );
  }
}

class BrandImageDisplay extends StatelessWidget {
  final AdminPanelController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleImageDisplay(
      image: _controller.brandImage,
      imageUrl: _controller.brandImageUrl,
      onPickImage: _controller.pickBrandImage,
      onRemoveImage: _controller.removeBrandImage,
    );
  }
}

class VariationImageDisplay extends StatelessWidget {
  final AdminPanelController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleImageDisplay(
      image: _controller.variationImage,
      imageUrl: _controller.variationImageUrl,
      onPickImage: _controller.pickVariationImage,
      onRemoveImage: _controller.removeVariationImage,
    );
  }
}




// class SearchableBrandDropdown extends StatelessWidget {
//   final AdminPanelController controller;
//
//   SearchableBrandDropdown({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           onChanged: controller.filterBrands,
//           decoration: InputDecoration(
//             labelText: 'Search Brands',
//             prefixIcon: Icon(Icons.search),
//           ),
//         ),
//         SizedBox(height: 10),
//         Container(
//           height: 200,
//           child: Obx(() => ListView.builder(
//             itemCount: controller.filteredBrands.length,
//             itemBuilder: (context, index) {
//               final brand = controller.filteredBrands[index];
//               return ListTile(
//                 title: Text(brand.name),
//                 subtitle: Text('Products: ${brand.productsCount}'),
//                 onTap: () {
//                   controller.selectBrand(brand);
//                   Navigator.of(context).pop();
//                 },
//               );
//             },
//           )),
//         ),
//       ],
//     );
//   }
// }

// class SearchableBrandDropdown extends StatelessWidget {
//   final AdminPanelController controller;
//
//   SearchableBrandDropdown({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 300, // Adjust this value as needed
//       height: 400, // Adjust this value as needed
//       child: Column(
//         children: [
//           TextField(
//             onChanged: controller.filteredBrands,
//             decoration: InputDecoration(
//               labelText: 'Search Brands',
//               prefixIcon: Icon(Icons.search),
//             ),
//           ),
//           SizedBox(height: 10),
//           Expanded(
//             child: Obx(() => ListView.builder(
//               itemCount: controller.filteredBrands.length,
//               itemBuilder: (context, index) {
//                 final brand = controller.filteredBrands[index];
//                 return ListTile(
//                   title: Text(brand.name),
//                   subtitle: Text('Products: ${brand.productsCount}'),
//                   onTap: () {
//                     controller.selectedBrand(brand);
//                     Navigator.of(context).pop();
//                   },
//                 );
//               },
//             )),
//           ),
//         ],
//       ),
//     );
//   }
// }