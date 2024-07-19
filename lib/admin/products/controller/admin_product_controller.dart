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
//
//   final isFeatured = false.obs;
//   final brandIsFeatured = false.obs;
//
//   var productAttributes = <ProductAttributeModel>[].obs;
//   var productVariations = <ProductVariationModel>[].obs;
//   final Rx<XFile?> selectedThumbnailImage = Rx<XFile?>(null);
//
//
//   // Assuming you have a list of categories and subcategories
//   Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
//   Rx<SubCategoryModel?> selectedSubcategory = Rx<SubCategoryModel?>(null);
//   RxList<CategoryModel> categories = <CategoryModel>[].obs;
//   RxList<SubCategoryModel> subcategories = <SubCategoryModel>[].obs;
//   Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
//
//   RxList<BrandModel> sbrands = <BrandModel>[].obs;
//   RxList<CategoryModel> subCategories = <CategoryModel>[].obs;
//
//   final SubCategoryRepository subCategoryRepository = Get.put(SubCategoryRepository());
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
//   @override
//   void onInit() {
//     super.onInit();
//     getSubCategories();
//     fetchAllCategories();
//
//     fetchSubcategories();
//     fetchBrands();
//   }
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
//       // Handle error, show message, etc.
//     }
//   }
//   // Fetch Brands
//
//   Future<void> fetchBrands() async {
//     try {
//       List<BrandModel> brands = await subCategoryRepository.getBrands();
//       sbrands.assignAll(brands);
//     } catch (e) {
//       print('Error fetching subcategories: $e');
//       // Handle error, show message, etc.
//     }
//   }
//
//   void selectBrandByName(String brandName) {
//     // Find the subcategory by name from your list of subcategories
//     BrandModel? brand = sbrands.firstWhere(
//           (brand) => brand.name == brandName,
//       orElse: () => BrandModel.empty(),
//     );
//     selectedBrand.value= brand;
//   }
//   void getSubCategories() {
//     subCategoryRepository.getSubCategories().listen((updatedSubCategories) {
//       subCategories.value = updatedSubCategories;
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
//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       selectedThumbnailImage.value = image;
//     }
//   }
//
//
//   Future<String> uploadImage(XFile image) async {
//     final storageRef = FirebaseStorage.instance.ref();
//     final imagesRef = storageRef.child('images/${image.name}');
//     try {
//       if (kIsWeb) {
//         // For web, use bytes
//         final Uint8List imageData = await image.readAsBytes();
//         await imagesRef.putData(imageData);
//       } else {
//         // For mobile, use File
//         await imagesRef.putFile(File(image.path));
//       }
//       final imageUrl = await imagesRef.getDownloadURL();
//       return imageUrl;
//     } catch (e) {
//       throw Exception('Failed to upload image: $e');
//     }
//   }
//
//   // pick images :
//
//   // Declare the list to hold selected images
//   final RxList<XFile?> selectedImages = RxList<XFile?>([]);
//   final RxList<String> uploadedImageUrls = RxList<String>([]);
//
// // Function to pick multiple images
//   Future<void> pickImages() async {
//     final ImagePicker picker = ImagePicker();
//     List<XFile>? pickedImages =
//         await picker.pickMultiImage(); // Use pickMultiImage for multiple images
//     if (pickedImages != null) {
//       selectedImages.addAll(pickedImages);
//     }
//   }
//
// // Function to upload a single image
//   Future<String> uploadImages(XFile image) async {
//     final storageRef = FirebaseStorage.instance.ref();
//     final imagesRef = storageRef.child('images/${image.name}');
//     try {
//       if (kIsWeb) {
//         // For web, use bytes
//         final Uint8List imageData = await image.readAsBytes();
//         await imagesRef.putData(imageData);
//       } else {
//         // For mobile, use File
//         await imagesRef.putFile(File(image.path));
//       }
//       final imageUrl = await imagesRef.getDownloadURL();
//       return imageUrl;
//     } catch (e) {
//       throw Exception('Failed to upload image: $e');
//     }
//   }
//
// // Function to upload all selected images and store their URLs
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
//         stockController.text.isNotEmpty) {
//       final newProductId = await _getNextProductId();
//       // Upload image to Firebase Storage and get the URL
//       final String imageUrl = await uploadImage(selectedThumbnailImage.value!);
//
//       // Ensure selectedBrand.value is not null and has the correct details
//       final brand = selectedBrand.value ?? BrandModel.empty();
//
//       final product = ProductModel(
//         id: newProductId,
//         title: titleController.text,
//         stock: int.parse(stockController.text),
//         price: double.parse(priceController.text),
//         salePrice: double.parse(salePriceController.text),
//         sku: skuController.text,
//         thumbnail: imageUrl,
//         productType: productTypeController.text,
//         description: descriptionController.text,
//         categoryId: categoryIdController.text,
//         images: uploadedImageUrls.toList(),
//         isFeatured: isFeatured.value,
//         brand: NewBrandModel(
//           id: brand.id,
//           image: brand.image,
//           name: brandNameController.text, // Ensure brand name is properly set
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
//
//
//   // void addProduct() async {
//   //   if (titleController.text.isNotEmpty &&
//   //       priceController.text.isNotEmpty &&
//   //       stockController.text.isNotEmpty) {
//   //     final newProductId = await _getNextProductId();
//   //     // Upload image to Firebase Storage and get the URL
//   //     final String imageUrl = await uploadImage(selectedThumbnailImage.value!);
//   //
//   //     final product = ProductModel(
//   //       id: newProductId,
//   //       title: titleController.text,
//   //       stock: int.parse(stockController.text),
//   //       price: double.parse(priceController.text),
//   //       salePrice: double.parse(salePriceController.text),
//   //       sku: skuController.text,
//   //       thumbnail: imageUrl, //thumbnailController.text,
//   //       productType: productTypeController.text,
//   //       description: descriptionController.text,
//   //       categoryId: categoryIdController.text,
//   //       images: uploadedImageUrls
//   //           .toList(), //imagesController.text.split(',').map((e) => e.trim()).toList(),
//   //       isFeatured: isFeatured.value,
//   //       brand: NewBrandModel(
//   //         id: brandIdController.text,
//   //         image: brandImageController.text,
//   //         name: brandNameController.text,
//   //         productsCount: int.parse(brandProductsCountController.text),
//   //         isFeatured: brandIsFeatured.value,
//   //       ),
//   //       date: DateTime.now(),
//   //       productAttributes: productAttributes.toList(),
//   //       productVariations: productVariations.toList(),
//   //     );
//   //
//   //     // Save to Firestore and update brand's product count
//   //     _firestore
//   //         .collection('Products')
//   //         .doc(newProductId)
//   //         .set(product.toJson())
//   //         .then((_) {
//   //       _updateBrandProductCount(product.brand!.id);
//   //       Get.snackbar('Success', 'Product added successfully');
//   //       _clearForm();
//   //     }).catchError((error) {
//   //       Get.snackbar('Error', 'Failed to add product: $error');
//   //     });
//   //   }
//   // }
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
// // class AddAttributeDialog extends StatelessWidget {
// //   final Function(ProductAttributeModel) onSubmit;
// //   final nameController = TextEditingController();
// //   final valuesController = TextEditingController();
// //
// //   AddAttributeDialog({super.key, required this.onSubmit});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return AlertDialog(
// //       title: const Text('Add Attribute'),
// //       content: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           TextField(
// //             controller: nameController,
// //             decoration: const InputDecoration(labelText: 'Attribute Name'),
// //           ),
// //           TextField(
// //             controller: valuesController,
// //             decoration:
// //                 const InputDecoration(labelText: 'Values (comma separated)'),
// //           ),
// //         ],
// //       ),
// //       actions: [
// //         TextButton(
// //           onPressed: () {
// //             Get.back();
// //           },
// //           child: const Text('Cancel'),
// //         ),
// //         ElevatedButton(
// //           onPressed: () {
// //             final values =
// //                 valuesController.text.split(',').map((e) => e.trim()).toList();
// //             onSubmit(ProductAttributeModel(
// //                 name: nameController.text, values: values));
// //             Get.back();
// //           },
// //           child: const Text('Add Attribute'),
// //         ),
// //       ],
// //     );
// //   }
// //
// //
// // }
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
//     return AlertDialog(
//       title: const Text('Add Attribute'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           DropdownButtonFormField<String>(
//             value: 'Color', // Default to Color
//             items: ['Color', 'Size'].map((String attributeType) {
//               return DropdownMenuItem<String>(
//                 value: attributeType,
//                 child: Text(attributeType),
//               );
//             }).toList(),
//             onChanged: (String? newValue) {
//               if (newValue != null) {
//                 // Update the type of attribute being added
//                 Get.find<AdminPanelController>().toggleAttributeType();
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
// // class AddVariationDialog extends StatelessWidget {
// //   final Function(ProductVariationModel) onSubmit;
// //   final idController = TextEditingController();
// //   final stockController = TextEditingController();
// //   final priceController = TextEditingController();
// //   final salePriceController = TextEditingController();
// //   final descriptionController = TextEditingController();
// //   final attributesController = TextEditingController();
// //
// //   final Rx<XFile?> selectedImage = Rx<XFile?>(null);
// //   final RxString uploadedImageUrl = RxString('');
// //
// //   AddVariationDialog({Key? key, required this.onSubmit}) : super(key: key);
// //
// //   Future<void> pickImage() async {
// //     final ImagePicker picker = ImagePicker();
// //     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// //     if (image != null) {
// //       selectedImage.value = image;
// //     }
// //   }
// //
// //   Future<void> uploadImage() async {
// //     if (selectedImage.value == null) return;
// //     final storageRef = FirebaseStorage.instance.ref();
// //     final imagesRef = storageRef.child('images/${selectedImage.value!.name}');
// //     try {
// //       if (kIsWeb) {
// //         // For web, use bytes
// //         final Uint8List imageData = await selectedImage.value!.readAsBytes();
// //         await imagesRef.putData(imageData);
// //       } else {
// //         // For mobile, use File
// //         await imagesRef.putFile(File(selectedImage.value!.path));
// //       }
// //       final imageUrl = await imagesRef.getDownloadURL();
// //       uploadedImageUrl.value = imageUrl;
// //     } catch (e) {
// //       throw Exception('Failed to upload image: $e');
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return AlertDialog(
// //       title: const Text('Add Variation'),
// //       content: SingleChildScrollView(
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             TextField(
// //               controller: idController,
// //               decoration: const InputDecoration(labelText: 'ID'),
// //             ),
// //             TextField(
// //               controller: stockController,
// //               decoration: const InputDecoration(labelText: 'Stock'),
// //               keyboardType: TextInputType.number,
// //             ),
// //             TextField(
// //               controller: priceController,
// //               decoration: const InputDecoration(labelText: 'Price'),
// //               keyboardType: TextInputType.number,
// //             ),
// //             TextField(
// //               controller: salePriceController,
// //               decoration: const InputDecoration(labelText: 'Sale Price'),
// //               keyboardType: TextInputType.number,
// //             ),
// //             Obx(() {
// //               return selectedImage.value == null
// //                   ? ElevatedButton(
// //                       onPressed: pickImage,
// //                       child: const Text('Pick Image'),
// //                     )
// //                   : Column(
// //                       children: [
// //                         kIsWeb
// //                             ? Image.network(selectedImage.value!.path)
// //                             : Image.file(File(selectedImage.value!.path)),
// //                         ElevatedButton(
// //                           onPressed: uploadImage,
// //                           child: const Text('Upload Image'),
// //                         ),
// //                         if (uploadedImageUrl.isNotEmpty)
// //                           Text('Uploaded URL: ${uploadedImageUrl.value}'),
// //                       ],
// //                     );
// //             }),
// //             TextField(
// //               controller: descriptionController,
// //               decoration: const InputDecoration(labelText: 'Description'),
// //             ),
// //             TextField(
// //               controller: attributesController,
// //               decoration: const InputDecoration(
// //                   labelText:
// //                       'Attributes (key:value pairs separated by commas)'),
// //             ),
// //           ],
// //         ),
// //       ),
// //       actions: [
// //         TextButton(
// //           onPressed: () {
// //             Get.back();
// //           },
// //           child: const Text('Cancel'),
// //         ),
// //         ElevatedButton(
// //           onPressed: () {
// //             final attributeValues = attributesController.text
// //                 .split(',')
// //                 .fold<Map<String, String>>({}, (map, pair) {
// //               final parts = pair.split(':');
// //               if (parts.length == 2) {
// //                 map[parts[0].trim()] = parts[1].trim();
// //               }
// //               return map;
// //             });
// //
// //             onSubmit(ProductVariationModel(
// //               id: idController.text,
// //               stock: int.parse(stockController.text),
// //               price: double.parse(priceController.text),
// //               salePrice: double.parse(salePriceController.text),
// //               image: uploadedImageUrl.value,
// //               description: descriptionController.text,
// //               attributeValues: attributeValues,
// //             ));
// //             Get.back();
// //           },
// //           child: const Text('Add Variation'),
// //         ),
// //       ],
// //     );
// //   }
// // }
