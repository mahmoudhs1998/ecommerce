
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
//   var productAttributes = <ProductAttributeModel>[].obs;
//   var productVariations = <ProductVariationModel>[].obs;

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   void addAttributeField() {
//     // Logic to add a new attribute field
//     Get.defaultDialog(
//       title: 'Add Attribute',
//       content: AddAttributeDialog(onSubmit: (name, values) {
//         productAttributes.add(ProductAttributeModel(name: name, values: values));
//       }),
//     );
//   }

//   void removeAttribute(ProductAttributeModel attribute) {
//     productAttributes.remove(attribute);
//   }

//   void addVariationField() {
//     // Logic to add a new variation field
//     Get.defaultDialog(
//       title: 'Add Variation',
//       content: AddVariationDialog(onSubmit: (variation) {
//         productVariations.add(variation);
//       }),
//     );
//   }

//   void removeVariation(ProductVariationModel variation) {
//     productVariations.remove(variation);
//   }

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
//         productAttributes: productAttributes.toList(),
//         productVariations: productVariations.toList(),
//       );

//       // Save to Firestore and update brand's product count
//       _firestore.collection('Products').doc(product.id).set(product.toJson()).then((_) {
//         _updateBrandProductCount(product.brand!.id);
//         Get.snackbar('Success', 'Product added successfully');
//         _clearForm();
//       }).catchError((error) {
//         Get.snackbar('Error', 'Failed to add product: $error');
//       });
//     }
//   }

//   void _updateBrandProductCount(String brandId) {
//     _firestore.collection('Brands').doc(brandId).update({
//       'productsCount': FieldValue.increment(1),
//     });
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
//     productAttributes.clear();
//     productVariations.clear();
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
//     super.onClose();
//   }
// }

// class AddAttributeDialog extends StatelessWidget {
//   final Function(String, List<String>) onSubmit;
//   final nameController = TextEditingController();
//   final valuesController = TextEditingController();

//   AddAttributeDialog({required this.onSubmit});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: nameController,
//           decoration: InputDecoration(labelText: 'Attribute Name'),
//         ),
//         TextField(
//           controller: valuesController,
//           decoration: InputDecoration(labelText: 'Values (comma separated)'),
//         ),
//         SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: () {
//             onSubmit(nameController.text, valuesController.text.split(',').map((e) => e.trim()).toList());
//             Get.back();
//           },
//           child: Text('Add Attribute'),
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
//   final imageController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final attributesController = TextEditingController();

//   AddVariationDialog({required this.onSubmit});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: idController,
//           decoration: InputDecoration(labelText: 'ID'),
//         ),
//         TextField(
//           controller: stockController,
//           decoration: InputDecoration(labelText: 'Stock'),
//           keyboardType: TextInputType.number,
//         ),
//         TextField(
//           controller: priceController,
//           decoration: InputDecoration(labelText: 'Price'),
//           keyboardType: TextInputType.number,
//         ),
//         TextField(
//           controller: salePriceController,
//           decoration: InputDecoration(labelText: 'Sale Price'),
//           keyboardType: TextInputType.number,
//         ),
//         TextField(
//           controller: imageController,
//           decoration: InputDecoration(labelText: 'Image URL'),
//         ),
//         TextField(
//           controller: descriptionController,
//           decoration: InputDecoration(labelText: 'Description'),
//         ),
//         TextField(
//           controller: attributesController,
//           decoration: InputDecoration(labelText: 'Attributes (key:value pairs separated by commas)'),
//         ),
//         SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: () {
//             final attributeValues = attributesController.text.split(',').fold<Map<String, String>>({}, (map, pair) {
//               final parts = pair.split(':');
//               if (parts.length == 2) {
//                 map[parts[0].trim()] = parts[1].trim();
//               }
//               return map;
//             });

//             onSubmit(ProductVariationModel(
//               id: idController.text,
//               stock: int.parse(stockController.text),
//               price: double.parse(priceController.text),
//               salePrice: double.parse(salePriceController.text),
//               image: imageController.text,
//               description: descriptionController.text,
//               attributeValues: attributeValues,
//             ));
//             Get.back();
//           },
//           child: Text('Add Variation'),
//         ),
//       ],
//     );
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  final isFeatured = false.obs;
  final brandIsFeatured = false.obs;

  var productAttributes = <ProductAttributeModel>[].obs;
  var productVariations = <ProductVariationModel>[].obs;

  void addProduct() async {
    if (titleController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        stockController.text.isNotEmpty) {
      final newProductId = await _getNextProductId();

      final product = ProductModel(
        id: newProductId,
        title: titleController.text,
        stock: int.parse(stockController.text),
        price: double.parse(priceController.text),
        salePrice: double.parse(salePriceController.text),
        sku: skuController.text,
        thumbnail: thumbnailController.text,
        productType: productTypeController.text,
        description: descriptionController.text,
        categoryId: categoryIdController.text,
        images: imagesController.text.split(',').map((e) => e.trim()).toList(),
        isFeatured: isFeatured.value,
        brand: BrandModel(
          id: brandIdController.text,
          image: brandImageController.text,
          name: brandNameController.text,
          productsCount: int.parse(brandProductsCountController.text),
          isFeatured: brandIsFeatured.value,
        ),
        date: DateTime.now(),
        productAttributes: productAttributes.toList(),
        productVariations: productVariations.toList(),
      );

      // Save to Firestore and update brand's product count
      _firestore
          .collection('Products')
          .doc(newProductId)
          .set(product.toJson())
          .then((_) {
        _updateBrandProductCount(product.brand!.id);
        Get.snackbar('Success', 'Product added successfully');
        _clearForm();
      }).catchError((error) {
        Get.snackbar('Error', 'Failed to add product: $error');
      });
    }
  }

  Future<String> _getNextProductId() async {
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
      // If the document doesn't exist, initialize it
      await counterDoc.set({'lastId': 1});
      return '001';
    }
  }

  void _updateBrandProductCount(String brandId) {
    _firestore.collection('Brands').doc(brandId).update({
      'ProductsCount': FieldValue.increment(1),
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
