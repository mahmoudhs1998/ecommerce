// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'dart:typed_data';
//
// import '../../../../features/shop/models/brand_model.dart';
// import '../../../../features/shop/models/category_model.dart';
// import '../../../../features/shop/models/product_attribute_model.dart';
// import '../../../../features/shop/models/product_model.dart';
// import '../../../../features/shop/models/product_variation_model.dart';
//
// class ProductRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   Future<String> uploadImage(XFile image) async {
//     final storageRef = _storage.ref();
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
//   Future<void> addProduct(ProductModel product) async {
//     try {
//       await _firestore.collection('Products').doc(product.id).set(product.toJson());
//     } catch (e) {
//       rethrow; // Propagate the error to the caller
//     }
//   }
//
//   Future<void> updateProduct(ProductModel product) async {
//     try {
//       await _firestore.collection('Products').doc(product.id).update(product.toJson());
//     } catch (e) {
//       rethrow; // Propagate the error to the caller
//     }
//   }
//
//   Future<void> deleteProduct(String productId) async {
//     try {
//       await _firestore.collection('Products').doc(productId).delete();
//     } catch (e) {
//       rethrow; // Propagate the error to the caller
//     }
//   }
//
//   Future<List<ProductModel>> fetchProducts() async {
//     try {
//       final querySnapshot = await _firestore.collection('Products').get();
//       return querySnapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
//     } catch (e) {
//       throw Exception('Failed to fetch products: $e');
//     }
//   }
//
//   Future<List<CategoryModel>> fetchCategories() async {
//     try {
//       final querySnapshot = await _firestore.collection('Categories').get();
//       return querySnapshot.docs.map((doc) => CategoryModel(
//         id: doc.id,
//         name: doc['name'] as String, image: '', isFeatured: false,
//       )).toList();
//     } catch (e) {
//       throw Exception('Failed to fetch categories: $e');
//     }
//   }
//
//   Future<List<SubCategoryModel>> fetchSubcategories() async {
//     try {
//       final querySnapshot = await _firestore.collection('Subcategories').get();
//       return querySnapshot.docs.map((doc) => SubCategoryModel(
//         id: doc.id,
//         name: doc['name'] as String,
//         parentId: doc['parentId'] as String, image: '',
//       )).toList();
//     } catch (e) {
//       throw Exception('Failed to fetch subcategories: $e');
//     }
//   }
//
//   Future<List<BrandModel>> fetchBrands() async {
//     try {
//       final querySnapshot = await _firestore.collection('Brands').get();
//       return querySnapshot.docs.map((doc) => BrandModel(
//         id: doc.id,
//         name: doc['name'] as String,
//         image: doc['image'] as String,
//         productsCount: doc['productsCount'] as int,
//         isFeatured: doc['isFeatured'] as bool,
//       )).toList();
//     } catch (e) {
//       throw Exception('Failed to fetch brands: $e');
//     }
//   }
//
//   Future<void> updateBrandProductCount(String brandId) async {
//     try {
//       await _firestore.collection('Brands').doc(brandId).update({
//         'productsCount': FieldValue.increment(1),
//       });
//     } catch (e) {
//       throw Exception('Failed to update brand product count: $e');
//     }
//   }
//
//   Future<String> getNextProductId() async {
//     final counterDoc = _firestore.collection('counters').doc('Products');
//     try {
//       final snapshot = await counterDoc.get();
//
//       if (snapshot.exists) {
//         final data = snapshot.data()!;
//         final currentId = data['lastId'] as int;
//         final newId = currentId + 1;
//
//         await counterDoc.update({'lastId': newId});
//         return newId.toString().padLeft(3, '0');
//       } else {
//         await counterDoc.set({'lastId': 1});
//         return '001';
//       }
//     } catch (e) {
//       throw Exception('Failed to get next product ID: $e');
//     }
//   }
// }
//
//
//
// class AdminPanelController extends GetxController {
//   final ProductRepository _repository = ProductRepository();
//
//   // Controllers for text fields
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController stockController = TextEditingController();
//   final TextEditingController skuController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController salePriceController = TextEditingController();
//   final TextEditingController thumbnailController = TextEditingController();
//   final TextEditingController productTypeController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController imagesController = TextEditingController();
//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController brandIdController = TextEditingController();
//   final TextEditingController brandImageController = TextEditingController();
//   final TextEditingController brandNameController = TextEditingController();
//   final TextEditingController brandProductsCountController = TextEditingController();
//
//   // Observables
//   final isFeatured = false.obs;
//   final brandIsFeatured = false.obs;
//   final Rx<XFile?> selectedThumbnailImage = Rx<XFile?>(null);
//   final RxList<XFile?> selectedImages = RxList<XFile?>([]);
//   final RxList<String> uploadedImageUrls = RxList<String>([]);
//   final RxList<ProductModel> products = RxList<ProductModel>([]);
//   final RxList<CategoryModel> categories = RxList<CategoryModel>([]);
//   final RxList<SubCategoryModel> subcategories = RxList<SubCategoryModel>([]);
//   final RxList<BrandModel> brands = RxList<BrandModel>([]);
// final TextEditingController categoryIdController = TextEditingController();
//   var productAttributes = <ProductAttributeModel>[].obs;
//   var productVariations = <ProductVariationModel>[].obs;
//
//
//   var addProductFormKey = GlobalKey<FormState>();
// // Observables for Dropdowns
//   var selectedCategory = Rxn<CategoryModel>();
//   var selectedSubCategory = Rxn<SubCategoryModel>();
//   var selectedBrand = Rxn<BrandModel>();
//   //var selectedVariantType = Rxn<VariantTypeModel>();
//   // var selectedVariants = <VariantModel>[].obs;
// // List of categories, subCategories, brands, variants and variant types
//   //var categories = <CategoryModel>[].obs;
//   var subCategories = <SubCategoryModel>[].obs;
//   //var brands = <BrandModel>[].obs;
//   @override
//   void onInit() {
//     fetchCategories();
//     fetchSubcategories();
//     fetchBrands();
//     fetchProducts();
//     super.onInit();
//   }
//
//   void fetchCategories() async {
//     try {
//       categories.assignAll(await _repository.fetchCategories());
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch categories: $e');
//     }
//   }
//
//   void fetchSubcategories() async {
//     try {
//       subcategories.assignAll(await _repository.fetchSubcategories());
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch subcategories: $e');
//     }
//   }
//
//   void fetchBrands() async {
//     try {
//       brands.assignAll(await _repository.fetchBrands());
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch brands: $e');
//     }
//   }
//
//   void fetchProducts() async {
//     try {
//       products.assignAll(await _repository.fetchProducts());
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch products: $e');
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
//   Future<void> uploadAllImages() async {
//     for (XFile? image in selectedImages) {
//       if (image != null) {
//         final String imageUrl = await _repository.uploadImage(image);
//         uploadedImageUrls.add(imageUrl);
//       }
//     }
//   }
//
//   void addProduct() async {
//     if (titleController.text.isNotEmpty &&
//         priceController.text.isNotEmpty &&
//         stockController.text.isNotEmpty &&
//         categoryIdController.text.isNotEmpty &&
//         brandIdController.text.isNotEmpty) {
//       final newProductId = await _repository.getNextProductId();
//
//       final product = ProductModel(
//         id: newProductId,
//         title: titleController.text,
//         stock: int.parse(stockController.text),
//         price: double.parse(priceController.text),
//         salePrice: double.parse(salePriceController.text),
//         sku: skuController.text,
//         thumbnail: await _repository.uploadImage(selectedThumbnailImage.value!),
//         productType: productTypeController.text,
//         description: descriptionController.text,
//         categoryId: categoryIdController.text,
//         images: uploadedImageUrls.toList(),
//         isFeatured: isFeatured.value,
//         brand: BrandModel(
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
//       try {
//         await _repository.addProduct(product);
//         _repository.updateBrandProductCount(product.brand!.id);
//         Get.snackbar('Success', 'Product added successfully');
//         clearForm();
//       } catch (e) {
//         Get.snackbar('Error', 'Failed to add product: $e');
//       }
//     } else {
//       Get.snackbar('Error', 'Please fill in all required fields');
//     }
//   }
//
//   void updateProduct(ProductModel product) async {
//     try {
//       await _repository.updateProduct(product);
//       Get.snackbar('Success', 'Product updated successfully');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update product: $e');
//     }
//   }
//
//   void deleteProduct(String productId) async {
//     try {
//       await _repository.deleteProduct(productId);
//       Get.snackbar('Success', 'Product deleted successfully');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to delete product: $e');
//     }
//   }
//
//   void clearForm() {
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
//     // Dispose controllers
//     titleController.dispose();
//     stockController.dispose();
//     skuController.dispose();
//     priceController.dispose();
//     salePriceController.dispose();
//     thumbnailController.dispose();
//     productTypeController.dispose();
//     descriptionController.dispose();
//     imagesController.dispose();
//     dateController.dispose();
//     brandIdController.dispose();
//     brandImageController.dispose();
//     brandNameController.dispose();
//     brandProductsCountController.dispose();
//     super.onClose();
//   }
// }
// class AddAttributeDialog extends StatelessWidget {
//   final Function(ProductAttributeModel) onSubmit;
//   final nameController = TextEditingController();
//   final valuesController = TextEditingController();
//
//   AddAttributeDialog({super.key, required this.onSubmit});
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Add Attribute'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: nameController,
//             decoration: const InputDecoration(labelText: 'Attribute Name'),
//           ),
//           TextField(
//             controller: valuesController,
//             decoration:
//             const InputDecoration(labelText: 'Values (comma separated)'),
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
//             final values =
//             valuesController.text.split(',').map((e) => e.trim()).toList();
//             onSubmit(ProductAttributeModel(
//                 name: nameController.text, values: values));
//             Get.back();
//           },
//           child: const Text('Add Attribute'),
//         ),
//       ],
//     );
//   }
// }
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
//             TextField(
//               controller: attributesController,
//               decoration: const InputDecoration(
//                   labelText:
//                   'Attributes (key:value pairs separated by commas)'),
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../features/shop/models/category_model.dart';

class SubCategoryModel {
  String id;
  String name;
  String parentId;
  String image;
  bool isFeatured;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.parentId,
    required this.image,
    this.isFeatured = false,
  });

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      id: map['Id'],
      name: map['Name'],
      parentId: map['ParentId'],
      image: map['Image'],
      isFeatured: map['IsFeatured'] ?? false,
    );
  }

  factory SubCategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return SubCategoryModel(
      id: snapshot.id,
      name: data['Name'],
      parentId: data['ParentId'],
      image: data['Image'],
      isFeatured: data['IsFeatured'] ?? false,
    );
  }

  static SubCategoryModel empty() {
    return SubCategoryModel(
      id: '',
      name: '',
      parentId: '',
      image: '',
      isFeatured: false,
    );
  }
}


class SubCategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String _categoriesPath = 'Categories';
  final String _collectionPath = 'subCategories';
  final _db = FirebaseFirestore.instance;

  Future<int> _getDocumentCount() async {
    QuerySnapshot querySnapshot = await _firestore.collection(_collectionPath).get();
    return querySnapshot.size;
  }


  // Future<void> addSubCategory(CategoryModel subCategory) async {
  //   // await getNextCategoryId();
  //   // await _firestore.collection(_collectionPath).add(subCategory.toJson());
  //   try {
  //
  //     final nextId = await getNextCategoryId();
  //     final newsubCategory = CategoryModel(
  //       id: nextId,
  //       name: subCategory.name,
  //       image: subCategory.image,
  //       isFeatured: subCategory.isFeatured,
  //       parentId: subCategory.parentId,
  //     );
  //     await _firestore.collection(_collectionPath).add(newsubCategory.toJson());
  //   }catch (e) {}
  // }

  // Get all subcategories
  Future<List<SubCategoryModel>> getSubCategoriess() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('subCategories').get();
      return snapshot.docs.map((doc) => SubCategoryModel.fromSnapshot(doc)).toList();
    } catch (e) {
      print('Error fetching subcategories: $e');
      throw Exception('Failed to fetch subcategories');
    }
  }
  /// Brand
  ///
  ///
  Future<List<BrandModel>> getBrands() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('Brands').get();
      return snapshot.docs.map((doc) => BrandModel.fromQuerySnapshot(doc)).toList();
    } catch (e) {
      print('Error fetching Brands: $e');
      throw Exception('Failed to fetch Brands');
    }
  }
  Future<String> getNextCategoryId() async {
    try {
      final querySnapshot = await _firestore.collection(_collectionPath)
          .orderBy('Id', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final lastId = int.parse(querySnapshot.docs.first['Id']);
        return (lastId + 1).toString();
      } else {
        return '1';
      }
    } catch (e) {
      print('Error getting next category ID: $e');
      throw e;
    }
  }

  Future<void> addSubCategory(CategoryModel subCategory) async {
    try {
      await _firestore.collection(_collectionPath).doc(subCategory.id).set(subCategory.toJson());
    } catch (e) {
      print('Error adding subcategory: $e');
      throw e;
    }
  }



  Future<void> updateSubCategory(CategoryModel subCategory) async {
    await _firestore.collection(_collectionPath).doc(subCategory.id).update(subCategory.toJson());
  }

  Future<void> deleteSubCategory(String id) async {
    await _firestore.collection(_collectionPath).doc(id).delete();
  }

  Stream<List<CategoryModel>> getAllCategories() {
    return _firestore.collection(_categoriesPath).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<CategoryModel>> getSubCategories() {
    return _firestore.collection(_collectionPath).where('ParentId', isNotEqualTo: '').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<CategoryModel>> getMainCategories() {
    return _firestore.collection(_categoriesPath)
        .where('ParentId', isEqualTo: '')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
    });
  }


  Future<String> uploadImage(XFile image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef = _storage.ref().child('category_images/$fileName');
    UploadTask uploadTask = storageRef.putData(await image.readAsBytes());
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }
}




class AdminSelectBrandController extends GetxController {
static  AdminSelectBrandController get instance => Get.find();
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Rx<NewBrandModel?> selectedBrand = Rx<NewBrandModel?>(null);
var sbrands = <NewBrandModel>[].obs;

TextEditingController brandIdController = TextEditingController();
TextEditingController brandImageController = TextEditingController();
TextEditingController brandNameController = TextEditingController();

@override
void onInit() {
  super.onInit();
  fetchBrands();
}

Future<void> fetchBrands() async {
  try {
    List<NewBrandModel> brands = await getBrands();
    sbrands.assignAll(brands);
  } catch (e) {
    print('Error fetching brands: $e');
    // Handle error, show message, etc.
  }
}

void selectBrandByName(String name) {
  selectedBrand.value = sbrands.firstWhere((brand) => brand.name == name, orElse: () => NewBrandModel.empty());
  print('Selected brand updated to: ${selectedBrand.value?.name}');
  if (selectedBrand.value != null) {
    brandIdController.text = selectedBrand.value!.id;
    brandImageController.text = selectedBrand.value!.image;
    brandNameController.text = selectedBrand.value!.name;
  } else {
    brandIdController.clear();
    brandImageController.clear();
    brandNameController.clear();
  }
}

Future<List<NewBrandModel>> getBrands() async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('Brands').get();
    return snapshot.docs.map((doc) => NewBrandModel.fromSnapshot(doc)).toList();
  } catch (e) {
    print('Error fetching brands: $e');
    throw Exception('Failed to fetch brands');
  }
}
}


