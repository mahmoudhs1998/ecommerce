// // import 'dart:io';

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';

// // import '../../../features/shop/models/brand_model.dart';
// // import '../../../features/shop/models/product_attribute_model.dart';
// // import '../../../features/shop/models/product_model.dart';
// // import '../../../features/shop/models/product_variation_model.dart';

// // class AdminProductController extends GetxController {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final FirebaseStorage _storage = FirebaseStorage.instance;
// //   final ImagePicker _picker = ImagePicker();

// //   final TextEditingController titleController = TextEditingController();
// //   final TextEditingController descriptionController = TextEditingController();
// //   final TextEditingController priceController = TextEditingController();
// //   final TextEditingController salePriceController = TextEditingController();
// //   final TextEditingController stockController = TextEditingController();
// //   final TextEditingController skuController = TextEditingController();
// //   final TextEditingController categoryIdController = TextEditingController();
// //   final TextEditingController productTypeController = TextEditingController();
// //   final RxBool isFeatured = false.obs;
// //   final RxString thumbnailUrl = ''.obs;
// //   final RxList<String> images = <String>[].obs;
// //   final RxList<ProductAttributeModel> productAttributes = <ProductAttributeModel>[].obs;
// //   final RxList<ProductVariationModel> productVariations = <ProductVariationModel>[].obs;
// //   final RxString selectedBrandId = ''.obs;

// //   // Methods for picking images
// //   Future<void> pickThumbnail() async {
// //     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
// //     if (pickedFile != null) {
// //       String downloadUrl = await uploadImage(File(pickedFile.path), 'thumbnail_${DateTime.now().millisecondsSinceEpoch}.jpg');
// //       thumbnailUrl.value = downloadUrl;
// //     }
// //   }

// //   Future<void> pickImages() async {
// //     final pickedFiles = await _picker.pickMultiImage();
// //     if (pickedFiles != null) {
// //       for (var pickedFile in pickedFiles) {
// //         String downloadUrl = await uploadImage(File(pickedFile.path), 'image_${DateTime.now().millisecondsSinceEpoch}.jpg');
// //         images.add(downloadUrl);
// //       }
// //     }
// //   }

// //   Future<void> addProduct() async {
// //     try {
// //       final productId = DateTime.now().millisecondsSinceEpoch.toString();
// //       final brandDoc = await _firestore.collection('Brands').doc(selectedBrandId.value).get();

// //       if (!brandDoc.exists) {
// //         throw Exception('Selected brand does not exist');
// //       }

// //       final brand = BrandModel.fromSnapshot(brandDoc);

// //       final product = ProductModel(
// //         id: productId,
// //         title: titleController.text,
// //         stock: int.parse(stockController.text),
// //         price: double.parse(priceController.text),
// //         isFeatured: isFeatured.value,
// //         thumbnail: thumbnailUrl.value,
// //         description: descriptionController.text,
// //         brand: brand,
// //         images: images.toList(),
// //         salePrice: double.parse(salePriceController.text),
// //         sku: skuController.text,
// //         categoryId: categoryIdController.text,
// //         productAttributes: productAttributes.toList(),
// //         productVariations: productVariations.toList(),
// //         productType: productTypeController.text,
// //       );

// //       await _firestore.collection('Products').doc(productId).set(product.toJson());

// //       // Increment the productsCount for the brand
// //       await _firestore.collection('Brands').doc(selectedBrandId.value).update({
// //         'productsCount': FieldValue.increment(1),
// //       });

// //       Get.snackbar('Success', 'Product added successfully');
// //     } catch (e) {
// //       Get.snackbar('Error', e.toString());
// //     }
// //   }

// //   Future<String> uploadImage(File image, String fileName) async {
// //     final ref = _storage.ref().child('product_images').child(fileName);
// //     final uploadTask = ref.putFile(image);
// //     final taskSnapshot = await uploadTask;
// //     final downloadUrl = await taskSnapshot.ref.getDownloadURL();
// //     return downloadUrl;
// //   }

// //   @override
// //   void onClose() {
// //     titleController.dispose();
// //     descriptionController.dispose();
// //     priceController.dispose();
// //     salePriceController.dispose();
// //     stockController.dispose();
// //     skuController.dispose();
// //     categoryIdController.dispose();
// //     productTypeController.dispose();
// //     super.onClose();
// //   }
// // }


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../features/shop/models/brand_model.dart';
// import '../../../features/shop/models/product_attribute_model.dart';
// import '../../../features/shop/models/product_model.dart';
// import '../../../features/shop/models/product_variation_model.dart';


// class AdminPanelController extends GetxController {
//   final formKey = GlobalKey<FormState>();

//   // Controllers for form fields
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
//   var isFeatured = false.obs;
//   var brandIsFeatured = false.obs;
//   final attributesController = TextEditingController();
//   final variationsController = TextEditingController();

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   void addProduct() {
//     if (formKey.currentState!.validate()) {
//       // Parse images
//       List<String> images = imagesController.text.isNotEmpty
//           ? imagesController.text.split(',').map((e) => e.trim()).toList()
//           : [];

//       // Parse date
//       DateTime? date;
//       if (dateController.text.isNotEmpty) {
//         date = DateTime.tryParse(dateController.text);
//       }

//       // Parse attributes
//       List<ProductAttributeModel> attributes = attributesController.text.isNotEmpty
//           ? attributesController.text.split(',').map((e) => ProductAttributeModel(name: e.trim(), values: [])).toList()
//           : [];

//       // Parse variations
//       List<ProductVariationModel> variations = variationsController.text.isNotEmpty
//           ? variationsController.text.split(',').map((e) => ProductVariationModel(id: '', stock: 0, price: 0, salePrice: 0, image: '', description: '', attributeValues: {})).toList()
//           : [];

//       // Create a new product model
//       final product = ProductModel(
//         id: _firestore.collection('Products').doc().id, // Generate a new ID
//         title: titleController.text,
//         stock: int.parse(stockController.text),
//         price: double.parse(priceController.text),
//         salePrice: salePriceController.text.isNotEmpty ? double.parse(salePriceController.text) : 0.0,
//         thumbnail: thumbnailController.text,
//         productType: productTypeController.text,
//         sku: skuController.text,
//         date: date,
//         isFeatured: isFeatured.value,
//         description: descriptionController.text,
//         categoryId: categoryIdController.text,
//         images: images,
//         brand: BrandModel(
//           id: brandIdController.text,
//           image: brandImageController.text,
//           name: brandNameController.text,
//           productsCount: int.parse(brandProductsCountController.text),
//           isFeatured: brandIsFeatured.value,
//         ),
//         productAttributes: attributes,
//         productVariations: variations,
//       );

//       // Save to Firestore
//       _firestore.collection('Products').doc(product.id).set(product.toJson()).then((_) {
//         Get.snackbar('Success', 'Product added successfully');
//         _clearForm();
//       }).catchError((error) {
//         Get.snackbar('Error', 'Failed to add product: $error');
//       });
//     }
//   }

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
//     attributesController.clear();
//     variationsController.clear();
//     isFeatured.value = false;
//     brandIsFeatured.value = false;
//   }

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
//     attributesController.dispose();
//     variationsController.dispose();
//     super.onClose();
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/shop/models/brand_model.dart';
import '../../../features/shop/models/product_attribute_model.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../features/shop/models/product_variation_model.dart';


class AdminPanelController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final titleController = TextEditingController();
  final stockController = TextEditingController();
  final skuController = TextEditingController();
  final priceController = TextEditingController();
  final salePriceController = TextEditingController();
  final thumbnailController = TextEditingController();
  final productTypeController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryIdController = TextEditingController();
  final imagesController = TextEditingController();
  final dateController = TextEditingController();
  final brandIdController = TextEditingController();
  final brandImageController = TextEditingController();
  final brandNameController = TextEditingController();
  final brandProductsCountController = TextEditingController();
  var isFeatured = false.obs;
  var brandIsFeatured = false.obs;
  var productAttributes = <ProductAttributeModel>[].obs;
  var productVariations = <ProductVariationModel>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addAttributeField() {
    // Logic to add a new attribute field
    Get.defaultDialog(
      title: 'Add Attribute',
      content: AddAttributeDialog(onSubmit: (name, values) {
        productAttributes.add(ProductAttributeModel(name: name, values: values));
      }),
    );
  }

  void removeAttribute(ProductAttributeModel attribute) {
    productAttributes.remove(attribute);
  }

  void addVariationField() {
    // Logic to add a new variation field
    Get.defaultDialog(
      title: 'Add Variation',
      content: AddVariationDialog(onSubmit: (variation) {
        productVariations.add(variation);
      }),
    );
  }

  void removeVariation(ProductVariationModel variation) {
    productVariations.remove(variation);
  }

  void addProduct() {
    if (formKey.currentState!.validate()) {
      // Parse images
      List<String> images = imagesController.text.isNotEmpty
          ? imagesController.text.split(',').map((e) => e.trim()).toList()
          : [];

      // Parse date
      DateTime? date;
      if (dateController.text.isNotEmpty) {
        date = DateTime.tryParse(dateController.text);
      }

      // Create a new product model
      final product = ProductModel(
        id: _firestore.collection('Products').doc().id, // Generate a new ID
        title: titleController.text,
        stock: int.parse(stockController.text),
        price: double.parse(priceController.text),
        salePrice: salePriceController.text.isNotEmpty ? double.parse(salePriceController.text) : 0.0,
        thumbnail: thumbnailController.text,
        productType: productTypeController.text,
        sku: skuController.text,
        date: date,
        isFeatured: isFeatured.value,
        description: descriptionController.text,
        categoryId: categoryIdController.text,
        images: images,
        brand: BrandModel(
          id: brandIdController.text,
          image: brandImageController.text,
          name: brandNameController.text,
          productsCount: int.parse(brandProductsCountController.text),
          isFeatured: brandIsFeatured.value,
        ),
        productAttributes: productAttributes.toList(),
        productVariations: productVariations.toList(),
      );

      // Save to Firestore and update brand's product count
      _firestore.collection('Products').doc(product.id).set(product.toJson()).then((_) {
        _updateBrandProductCount(product.brand!.id);
        Get.snackbar('Success', 'Product added successfully');
        _clearForm();
      }).catchError((error) {
        Get.snackbar('Error', 'Failed to add product: $error');
      });
    }
  }

  void _updateBrandProductCount(String brandId) {
    _firestore.collection('Brands').doc(brandId).update({
      'productsCount': FieldValue.increment(1),
    });
  }

  void _clearForm() {
    titleController.clear();
    stockController.clear();
    skuController.clear();
    priceController.clear();
    salePriceController.clear();
    thumbnailController.clear();
    productTypeController.clear();
    descriptionController.clear();
    categoryIdController.clear();
    imagesController.clear();
    dateController.clear();
    brandIdController.clear();
    brandImageController.clear();
    brandNameController.clear();
    brandProductsCountController.clear();
    productAttributes.clear();
    productVariations.clear();
    isFeatured.value = false;
    brandIsFeatured.value = false;
  }

  @override
  void onClose() {
    titleController.dispose();
    stockController.dispose();
    skuController.dispose();
    priceController.dispose();
    salePriceController.dispose();
    thumbnailController.dispose();
    productTypeController.dispose();
    descriptionController.dispose();
    categoryIdController.dispose();
    imagesController.dispose();
    dateController.dispose();
    brandIdController.dispose();
    brandImageController.dispose();
    brandNameController.dispose();
    brandProductsCountController.dispose();
    super.onClose();
  }
}

class AddAttributeDialog extends StatelessWidget {
  final Function(String, List<String>) onSubmit;
  final nameController = TextEditingController();
  final valuesController = TextEditingController();

  AddAttributeDialog({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Attribute Name'),
        ),
        TextField(
          controller: valuesController,
          decoration: InputDecoration(labelText: 'Values (comma separated)'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            onSubmit(nameController.text, valuesController.text.split(',').map((e) => e.trim()).toList());
            Get.back();
          },
          child: Text('Add Attribute'),
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

  AddVariationDialog({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: idController,
          decoration: InputDecoration(labelText: 'ID'),
        ),
        TextField(
          controller: stockController,
          decoration: InputDecoration(labelText: 'Stock'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: priceController,
          decoration: InputDecoration(labelText: 'Price'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: salePriceController,
          decoration: InputDecoration(labelText: 'Sale Price'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: imageController,
          decoration: InputDecoration(labelText: 'Image URL'),
        ),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(labelText: 'Description'),
        ),
        TextField(
          controller: attributesController,
          decoration: InputDecoration(labelText: 'Attributes (key:value pairs separated by commas)'),
        ),
        SizedBox(height: 20),
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
          child: Text('Add Variation'),
        ),
      ],
    );
  }
}
