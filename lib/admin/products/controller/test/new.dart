// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../../../features/shop/models/brand_model.dart';
// import '../../../../features/shop/models/product_attribute_model.dart';
// import '../../../../features/shop/models/product_model.dart';
// import '../../../../features/shop/models/product_variation_model.dart';
//
// class NewAdminPanelController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Controllers for text fields
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController stockController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController salePriceController = TextEditingController();
//   final TextEditingController skuController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController categoryIdController = TextEditingController();
//   final TextEditingController attributeValueController = TextEditingController();
//   final TextEditingController variationStockController = TextEditingController();
//   final TextEditingController variationPriceController = TextEditingController();
//   final TextEditingController variationSalePriceController = TextEditingController();
//   final TextEditingController variationDescriptionController = TextEditingController();
//
//   // Observables for reactive state management
//   final RxString thumbnailUrl = ''.obs;
//   final Rx<NewBrandModel?> selectedBrand = Rx<NewBrandModel?>(null);
//   final Rx<ProductType> selectedProductType = ProductType.single.obs;
//   final RxBool isFeatured = false.obs;
//
//   // For product attributes and variations
//   final RxList<ProductAttributeModel> productAttributes = <ProductAttributeModel>[].obs;
//   final RxList<ProductVariationModel> productVariations = <ProductVariationModel>[].obs;
//
//   // For managing selected attribute name and values
//   final RxString selectedAttributeName = ''.obs;
//   final RxMap<String, List<String>> attributeValues = <String, List<String>>{}.obs;
//
//   // For managing selected variation attributes
//   final RxMap<String, String> selectedVariationAttributes = <String, String>{}.obs;
//
//   // Method to add an attribute value
//   void addAttributeValue() {
//     final attributeName = selectedAttributeName.value;
//     final attributeValue = attributeValueController.text.trim();
//
//     if (attributeName.isNotEmpty && attributeValue.isNotEmpty) {
//       if (attributeValues.containsKey(attributeName)) {
//         attributeValues[attributeName]!.add(attributeValue);
//       } else {
//         attributeValues[attributeName] = [attributeValue];
//       }
//       attributeValueController.clear();
//     }
//   }
//
//   // Method to add a product attribute
//   void addProductAttribute() {
//     final attributeName = selectedAttributeName.value;
//     if (attributeName.isNotEmpty && attributeValues.containsKey(attributeName)) {
//       final attribute = ProductAttributeModel(
//         name: attributeName,
//         values: attributeValues[attributeName]!,
//       );
//       productAttributes.add(attribute);
//       selectedAttributeName.value = '';
//       attributeValues[attributeName] = [];
//     }
//   }
//
//   // Method to remove an attribute value
//   void removeAttributeValue(String attributeName, String attributeValue) {
//     if (attributeValues.containsKey(attributeName)) {
//       attributeValues[attributeName]!.remove(attributeValue);
//       if (attributeValues[attributeName]!.isEmpty) {
//         attributeValues.remove(attributeName);
//       }
//     }
//   }
//
//   // Method to add a product variation
//   void addProductVariation() {
//     final stock = int.tryParse(variationStockController.text.trim()) ?? 0;
//     final price = double.tryParse(variationPriceController.text.trim()) ?? 0.0;
//     final salePrice = double.tryParse(variationSalePriceController.text.trim()) ?? 0.0;
//     final description = variationDescriptionController.text.trim();
//
//     if (selectedVariationAttributes.isNotEmpty && stock > 0 && price > 0.0) {
//       final variation = ProductVariationModel(
//         id: (productVariations.length + 1).toString(),
//         attributeValues: Map<String, String>.from(selectedVariationAttributes),
//         stock: stock,
//         price: price,
//         salePrice: salePrice,
//         description: description,
//       );
//       productVariations.add(variation);
//       variationStockController.clear();
//       variationPriceController.clear();
//       variationSalePriceController.clear();
//       variationDescriptionController.clear();
//       selectedVariationAttributes.clear();
//     }
//   }
//
//   // Method to add a product
//   Future<void> addProduct() async {
//     try {
//       final productId = _firestore.collection('products').doc().id;
//       final productData = {
//         'title': titleController.text.trim(),
//         'stock': int.tryParse(stockController.text.trim()) ?? 0,
//         'price': double.tryParse(priceController.text.trim()) ?? 0.0,
//         'salePrice': double.tryParse(salePriceController.text.trim()) ?? 0.0,
//         'sku': skuController.text.trim(),
//         'description': descriptionController.text.trim(),
//         'categoryId': categoryIdController.text.trim(),
//         'thumbnailUrl': thumbnailUrl.value,
//         'brandId': selectedBrand.value?.id,
//         'productType': selectedProductType.value == ProductType.single ? 'single' : 'variable',
//         'isFeatured': isFeatured.value,
//         'attributes': productAttributes.map((attr) => attr.toJson()).toList(),
//         'variations': productVariations.map((variation) => variation.toJson()).toList(),
//       };
//
//       // Add check for required fields before sending data to Firestore
//       await _firestore.collection('products').doc(productId).set(productData);
//       _updateBrandProductCount(selectedBrand.value!.id);
//       _clearForm();
//       {
//         throw Exception('Please fill in all required fields');
//       }
//
//
//     } catch (e) {
//       print('Error adding product: $e');
//     }
//   }
//
//   // Method to update the product count for a brand
//   Future<void> _updateBrandProductCount(String brandId) async {
//     try {
//       final brandDoc = _firestore.collection('Brands').doc(brandId);
//       await _firestore.runTransaction((transaction) async {
//         final snapshot = await transaction.get(brandDoc);
//         if (!snapshot.exists) {
//           throw Exception('Brand does not exist!');
//         }
//         final newCount = snapshot.get('productCount') + 1;
//         transaction.update(brandDoc, {'productCount': newCount});
//       });
//     } catch (e) {
//       print('Error updating brand product count: $e');
//     }
//   }
//
//   // Method to clear the form
//   void _clearForm() {
//     titleController.clear();
//     stockController.clear();
//     priceController.clear();
//     salePriceController.clear();
//     skuController.clear();
//     descriptionController.clear();
//     categoryIdController.clear();
//     thumbnailUrl.value = '';
//     selectedBrand.value = null;
//     selectedProductType.value = ProductType.single;
//     isFeatured.value = false;
//     productAttributes.clear();
//     productVariations.clear();
//     attributeValues.clear();
//     selectedVariationAttributes.clear();
//   }
//
//   // Method to select a brand
//   void selectBrand(NewBrandModel brand) {
//     selectedBrand.value = brand;
//   }
//
//   // Method to select a thumbnail image
//   void selectThumbnailImage() async {
//     // Implement your image picking logic here
//     // For example, using image_picker package
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       thumbnailUrl.value = pickedFile.path; // Or upload to Firebase Storage and get URL
//     }
//   }
//
//   // Method to get filtered brands
//   List<NewBrandModel> get filteredBrands {
//     // Implement your logic to get a list of brands
//     return [];
//   }
// }
//
//
//
// // ui ---------------------
//
// class AddProductForms extends StatelessWidget {
//   final NewAdminPanelController controller = Get.put(NewAdminPanelController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Product'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Product details section
//               TextField(
//                 controller: controller.titleController,
//                 decoration: InputDecoration(labelText: 'Title'),
//               ),
//               TextField(
//                 controller: controller.stockController,
//                 decoration: InputDecoration(labelText: 'Stock'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 controller: controller.priceController,
//                 decoration: InputDecoration(labelText: 'Price'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 controller: controller.salePriceController,
//                 decoration: InputDecoration(labelText: 'Sale Price'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 controller: controller.skuController,
//                 decoration: InputDecoration(labelText: 'SKU'),
//               ),
//               TextField(
//                 controller: controller.descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//                 maxLines: 3,
//               ),
//               TextField(
//                 controller: controller.categoryIdController,
//                 decoration: InputDecoration(labelText: 'Category ID'),
//               ),
//               Obx(
//                     () => DropdownButton<NewBrandModel>(
//                   value: controller.selectedBrand.value,
//                   hint: Text('Select Brand'),
//                   onChanged: (NewBrandModel? newValue) {
//                     if (newValue != null) {
//                       controller.selectBrand(newValue);
//                     }
//                   },
//                   items: controller.filteredBrands
//                       .map((brand) => DropdownMenuItem(
//                     value: brand,
//                     child: Text(brand.name),
//                   ))
//                       .toList(),
//                 ),
//               ),
//               Obx(
//                     () => DropdownButton<ProductType>(
//                   value: controller.selectedProductType.value,
//                   hint: Text('Select Product Type'),
//                   onChanged: (ProductType? newValue) {
//                     if (newValue != null) {
//                       controller.selectedProductType.value = newValue;
//                     }
//                   },
//                   items: ProductType.values
//                       .map((type) => DropdownMenuItem(
//                     value: type,
//                     child: Text(type.toString().split('.').last),
//                   ))
//                       .toList(),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Obx(
//                     () => CheckboxListTile(
//                   title: Text('Featured'),
//                   value: controller.isFeatured.value,
//                   onChanged: (bool? newValue) {
//                     if (newValue != null) {
//                       controller.isFeatured.value = newValue;
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: controller.selectThumbnailImage,
//                 child: Text('Select Thumbnail Image'),
//               ),
//               Obx(
//                     () => controller.thumbnailUrl.value.isNotEmpty
//                     ? Image.network(controller.thumbnailUrl.value)
//                     : SizedBox.shrink(),
//               ),
//               SizedBox(height: 16.0),
//
//               // Attributes section
//               TextField(
//                 decoration: InputDecoration(labelText: 'Attribute Name'),
//                 onChanged: (value) {
//                   controller.selectedAttributeName.value = value;
//                 },
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: controller.attributeValueController,
//                       decoration: InputDecoration(labelText: 'Attribute Value'),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.add),
//                     onPressed: controller.addAttributeValue,
//                   ),
//                 ],
//               ),
//               Obx(
//                     () => Wrap(
//                   children: controller.attributeValues.entries
//                       .expand((entry) => entry.value.map((value) => Chip(
//                     label: Text('${entry.key}: $value'),
//                     onDeleted: () => controller.removeAttributeValue(entry.key, value),
//                   )))
//                       .toList(),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: controller.addProductAttribute,
//                 child: Text('Add Attribute'),
//               ),
//               SizedBox(height: 16.0),
//               Obx(
//                     () => ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: controller.productAttributes.length,
//                   itemBuilder: (context, index) {
//                     final attribute = controller.productAttributes[index];
//                     return ListTile(
//                       title: Text(attribute.name!),
//                       subtitle: Text(attribute.values!.join(', ')),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 16.0),
//
//               // Variations section
//               Obx(
//                     () => DropdownButton<String>(
//                   value: controller.selectedAttributeName.value.isEmpty
//                       ? null
//                       : controller.selectedAttributeName.value,
//                   hint: Text('Select Attribute for Variation'),
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       controller.selectedAttributeName.value = newValue;
//                     }
//                   },
//                   items: controller.productAttributes
//                       .map((attr) => DropdownMenuItem(
//                     value: attr.name,
//                     child: Text(attr.name!),
//                   ))
//                       .toList(),
//                 ),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: controller.variationStockController,
//                       decoration: InputDecoration(labelText: 'Stock'),
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: controller.variationPriceController,
//                       decoration: InputDecoration(labelText: 'Price'),
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: controller.variationSalePriceController,
//                       decoration: InputDecoration(labelText: 'Sale Price'),
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                 ],
//               ),
//               TextField(
//                 controller: controller.variationDescriptionController,
//                 decoration: InputDecoration(labelText: 'Variation Description'),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: controller.addProductVariation,
//                 child: Text('Add Variation'),
//               ),
//               Obx(
//                     () => ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: controller.productVariations.length,
//                   itemBuilder: (context, index) {
//                     final variation = controller.productVariations[index];
//                     return ListTile(
//                       title: Text('Variation ${variation.id}'),
//                       subtitle: Text(
//                           'Stock: ${variation.stock}, Price: ${variation.price}, Sale Price: ${variation.salePrice}'),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: controller.addProduct,
//                 child: Text('Add Product'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//




// UI code (to be used in your widget build method)

// Very Good example
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../../../order/test.dart';
// class ProductAttributeForm extends GetView<AdminPanelController> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: controller.attributeNameController,
//
//           decoration: InputDecoration(labelText: 'Attribute Name'),
//         ),
//         TextField(
//           controller: controller.attributeValueController,
//           decoration: InputDecoration(labelText: 'Attribute Value'),
//         ),
//         ElevatedButton(
//           onPressed: controller.addProductAttribute,
//           child: Text('Add Attribute'),
//         ),
//         Obx(() => ListView.builder(
//           shrinkWrap: true,
//           itemCount: controller.productAttributes.length,
//           itemBuilder: (context, index) {
//             var attribute = controller.productAttributes[index];
//             return ExpansionTile(
//               title: Text(attribute.name!),
//               children: [
//                 ...attribute.values!.map((value) => ListTile(title: Text(value))),
//                 TextButton(
//                   onPressed: () => controller.removeProductAttribute(attribute),
//                   child: Text('Remove Attribute'),
//                 ),
//               ],
//             );
//           },
//         )),
//       ],
//     );
//   }
// }
//
// class ProductVariationForm extends GetView<AdminPanelController> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: controller.variationIdController,
//           decoration: InputDecoration(labelText: 'Variation ID (optional)'),
//         ),
//         TextField(
//           controller: controller.variationStockController,
//           decoration: InputDecoration(labelText: 'Stock'),
//           keyboardType: TextInputType.number,
//         ),
//         TextField(
//           controller: controller.variationPriceController,
//           decoration: InputDecoration(labelText: 'Price'),
//           keyboardType: TextInputType.numberWithOptions(decimal: true),
//         ),
//         TextField(
//           controller: controller.variationSalePriceController,
//           decoration: InputDecoration(labelText: 'Sale Price'),
//           keyboardType: TextInputType.numberWithOptions(decimal: true),
//         ),
//         TextField(
//           controller: controller.variationDescriptionController,
//           decoration: InputDecoration(labelText: 'Description'),
//         ),
//         TextField(
//           controller: controller.variationSkuController,
//           decoration: InputDecoration(labelText: 'SKU'),
//         ),
//         ElevatedButton(
//           onPressed: controller.addProductVariation,
//           child: Text('Add Variation'),
//         ),
//         Obx(() => ListView.builder(
//           shrinkWrap: true,
//           itemCount: controller.productVariations.length,
//           itemBuilder: (context, index) {
//             var variation = controller.productVariations[index];
//             return ExpansionTile(
//               title: Text('Variation ${index + 1}'),
//               children: [
//                 ...variation.attributeValues.entries.map((entry) {
//                   return DropdownButton<String>(
//                     value: entry.value,
//                     items: controller.productAttributes
//                         .firstWhere((attr) => attr.name == entry.key)
//                         .values!
//                         .map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       if (newValue != null) {
//                         controller.updateVariationAttributeValue(
//                           variation,
//                           entry.key,
//                           newValue,
//                         );
//                       }
//                     },
//                   );
//                 }).toList(),
//                 Text('Stock: ${variation.stock}'),
//                 Text('Price: ${variation.price}'),
//                 Text('Sale Price: ${variation.salePrice}'),
//                 Text('Description: ${variation.description}'),
//                 Text('SKU: ${variation.sku ?? "N/A"}'),
//                 TextButton(
//                   onPressed: () => controller.removeProductVariation(variation),
//                   child: Text('Remove Variation'),
//                 ),
//               ],
//             );
//           },
//         )),
//       ],
//     );
//   }
// }

// Goood ----------------------------------------------------------
// class ProductAttributeForm extends GetView<AdminPanelController> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AdminPanelController>(
//       builder: (controller) {
//         return Column(
//           children: [
//             DropdownButtonFormField<String>(
//               value: controller.attributeNameController.text.isNotEmpty
//                   ? controller.attributeNameController.text
//                   : null,
//               hint: Text('Select attribute type'),
//               onChanged: (selectedAttribute) {
//                 if (selectedAttribute != null) {
//                   controller.attributeNameController.text = selectedAttribute;
//                   controller.update(); // Trigger rebuild
//                 }
//               },
//               items: ['Color', 'Size'].map((attribute) {
//                 return DropdownMenuItem<String>(
//                   value: attribute,
//                   child: Text(attribute),
//                 );
//               }).toList(),
//             ),
//             TextField(
//               controller: controller.attributeValueController,
//               decoration: InputDecoration(labelText: 'Attribute Value'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 controller.addProductAttribute();
//                 controller.update(); // Trigger rebuild after adding attribute
//               },
//               child: Text('Add Attribute'),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: controller.productAttributes.length,
//               itemBuilder: (context, index) {
//                 var attribute = controller.productAttributes[index];
//                 return ExpansionTile(
//                   title: Text(attribute.name!),
//                   children: [
//                     ...attribute.values!.map((value) => ListTile(title: Text(value))),
//                     TextButton(
//                       onPressed: () {
//                         controller.removeProductAttribute(attribute);
//                         controller.update(); // Trigger rebuild after removing attribute
//                       },
//                       child: Text('Remove Attribute'),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
// class ProductVariationForm extends GetView<AdminPanelController> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: controller.variationIdController,
//           decoration: InputDecoration(labelText: 'Variation ID (optional)'),
//         ),
//         TextField(
//           controller: controller.variationStockController,
//           decoration: InputDecoration(labelText: 'Stock'),
//           keyboardType: TextInputType.number,
//         ),
//         TextField(
//           controller: controller.variationPriceController,
//           decoration: InputDecoration(labelText: 'Price'),
//           keyboardType: TextInputType.numberWithOptions(decimal: true),
//         ),
//         TextField(
//           controller: controller.variationSalePriceController,
//           decoration: InputDecoration(labelText: 'Sale Price'),
//           keyboardType: TextInputType.numberWithOptions(decimal: true),
//         ),
//         TextField(
//           controller: controller.variationDescriptionController,
//           decoration: InputDecoration(labelText: 'Description'),
//         ),
//         TextField(
//           controller: controller.variationSkuController,
//           decoration: InputDecoration(labelText: 'SKU'),
//         ),
//         ElevatedButton(
//           onPressed: controller.addProductVariation,
//           child: Text('Add Variation'),
//         ),
//         Obx(() => ListView.builder(
//           shrinkWrap: true,
//           itemCount: controller.productVariations.length,
//           itemBuilder: (context, index) {
//             var variation = controller.productVariations[index];
//             return ExpansionTile(
//               title: Text('Variation ${index + 1}'),
//               children: [
//                 DropdownButtonFormField<String>(
//                   value: variation.attributeValues['Color'],
//                   hint: Text('Select Color'),
//                   items: controller.productAttributes
//                       .firstWhereOrNull((attr) => attr.name == 'Color')
//                       ?.values
//                       ?.map((value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       controller.updateVariationAttributeValue(
//                         variation,
//                         'Color',
//                         newValue,
//                       );
//                     }
//                   },
//                 ),
//                 DropdownButtonFormField<String>(
//                   value: variation.attributeValues['Size'],
//                   hint: Text('Select Size'),
//                   items: controller.productAttributes
//                       .firstWhereOrNull((attr) => attr.name == 'Size')
//                       ?.values
//                       ?.map((value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       controller.updateVariationAttributeValue(
//                         variation,
//                         'Size',
//                         newValue,
//                       );
//                     }
//                   },
//                 ),
//                 Text('Stock: ${variation.stock}'),
//                 Text('Price: ${variation.price}'),
//                 Text('Sale Price: ${variation.salePrice}'),
//                 Text('Description: ${variation.description ?? "N/A"}'),
//                 Text('SKU: ${variation.sku ?? "N/A"}'),
//                 TextButton(
//                   onPressed: () => controller.removeProductVariation(variation),
//                   child: Text('Remove Variation'),
//                 ),
//               ],
//             );
//           },
//         )),
//       ],
//     );
//   }
// }







/// New Test ------------------------------
///
///
///


class ColorOption {
  final String name;
  final Color color;

  ColorOption(this.name, this.color);
}

class ColorManagementSystem extends GetxController {
  var availableColors = <ColorOption>[].obs;

  void addColor(String name, Color color) {
    availableColors.add(ColorOption(name, color));
  }

  void removeColor(ColorOption colorOption) {
    availableColors.remove(colorOption);
  }
}




class ProductAttributeForm extends GetView<AdminPanelController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminPanelController>(
      builder: (controller) {
        return Column(
          children: [
            DropdownButtonFormField<String>(
              value: controller.attributeNameController.text.isNotEmpty
                  ? controller.attributeNameController.text
                  : null,
              hint: Text('Select attribute type'),
              onChanged: (selectedAttribute) {
                if (selectedAttribute != null) {
                  controller.attributeNameController.text = selectedAttribute;
                  controller.update();
                }
              },
              items: ['Color', 'Size'].map((attribute) {
                return DropdownMenuItem<String>(
                  value: attribute,
                  child: Text(attribute),
                );
              }).toList(),
            ),
            TextField(
              controller: controller.attributeValueController,
              decoration: InputDecoration(labelText: 'Attribute Value'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.addProductAttribute();
              },
              child: Text('Add Attribute'),
            ),
            Obx(() => ListView.builder(
              shrinkWrap: true,
              itemCount: controller.productAttributes.length,
              itemBuilder: (context, index) {
                var attribute = controller.productAttributes[index];
                return ExpansionTile(
                  title: Text(attribute.name!),
                  children: [
                    ...attribute.values!.map((value) => ListTile(title: Text(value))),
                    TextButton(
                      onPressed: () {
                        controller.removeProductAttribute(attribute);
                      },
                      child: Text('Remove Attribute'),
                    ),
                  ],
                );
              },
            )),
          ],
        );
      },
    );
  }
}


class ProductVariationForm extends GetView<AdminPanelController> {
  final ColorManagementSystem colorSystem = Get.put(ColorManagementSystem());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller.variationIdController,
          decoration: InputDecoration(labelText: 'Variation ID (optional)'),
        ),
        TextField(
          controller: controller.variationStockController,
          decoration: InputDecoration(labelText: 'Stock'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: controller.variationPriceController,
          decoration: InputDecoration(labelText: 'Price'),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        TextField(
          controller: controller.variationSalePriceController,
          decoration: InputDecoration(labelText: 'Sale Price'),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        TextField(
          controller: controller.variationDescriptionController,
          decoration: InputDecoration(labelText: 'Description'),
        ),
        TextField(
          controller: controller.variationSkuController,
          decoration: InputDecoration(labelText: 'SKU'),
        ),
        ElevatedButton(
          onPressed: () => _showColorManagementDialog(context),
          child: Text('Manage Colors'),
        ),
        ElevatedButton(
          onPressed: controller.addProductVariation,
          child: Text('Add Variation'),
        ),
        Obx(() => ListView.builder(
          shrinkWrap: true,
          itemCount: controller.productVariations.length,
          itemBuilder: (context, index) {
            var variation = controller.productVariations[index];
            return ExpansionTile(
              title: Text('Variation ${index + 1}'),
              children: [
                Obx(() => DropdownButtonFormField<String>(
                  value: variation.attributeValues['Color'],
                  hint: Text('Select Color'),
                  items: colorSystem.availableColors.map((colorOption) {
                    return DropdownMenuItem<String>(
                      value: colorOption.name,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: colorOption.color,
                          ),
                          SizedBox(width: 10),
                          Text(colorOption.name),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.updateVariationAttributeValue(
                        variation,
                        'Color',
                        newValue,
                      );
                    }
                  },
                )),
                DropdownButtonFormField<String>(
                  value: variation.attributeValues['Size'],
                  hint: Text('Select Size'),
                  items: controller.productAttributes
                      .firstWhereOrNull((attr) => attr.name == 'Size')
                      ?.values
                      ?.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.updateVariationAttributeValue(
                        variation,
                        'Size',
                        newValue,
                      );
                    }
                  },
                ),
                Text('Stock: ${variation.stock}'),
                Text('Price: ${variation.price}'),
                Text('Sale Price: ${variation.salePrice}'),
                Text('Description: ${variation.description ?? "N/A"}'),
                Text('SKU: ${variation.sku ?? "N/A"}'),
                TextButton(
                  onPressed: () => controller.removeProductVariation(variation),
                  child: Text('Remove Variation'),
                ),
              ],
            );
          },
        )),
      ],
    );
  }

  void _showColorManagementDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Manage Colors'),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => _addNewColor(context),
                  child: Text('Add New Color'),
                ),
                SizedBox(height: 10),
                Flexible(
                  child: Obx(() => ListView.builder(
                    shrinkWrap: true,
                    itemCount: colorSystem.availableColors.length,
                    itemBuilder: (context, index) {
                      final colorOption = colorSystem.availableColors[index];
                      return ListTile(
                        leading: Container(
                          width: 20,
                          height: 20,
                          color: colorOption.color,
                        ),
                        title: Text(colorOption.name),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => colorSystem.removeColor(colorOption),
                        ),
                      );
                    },
                  )),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _addNewColor(BuildContext context) {
    final colorNameController = TextEditingController();
    Color selectedColor = Colors.white;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Color'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: colorNameController,
                decoration: InputDecoration(labelText: 'Color Name'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final Color? pickedColor = await showDialog<Color>(
                    context: context,
                    builder: (context) {
                      Color tempColor = selectedColor;
                      return AlertDialog(
                        title: Text('Pick a color'),
                        content: SingleChildScrollView(
                          child: BlockPicker(
                            pickerColor: tempColor,
                            onColorChanged: (Color color) {
                              tempColor = color;
                            },
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () => Navigator.of(context).pop(tempColor),
                          ),
                        ],
                      );
                    },
                  );

                  if (pickedColor != null) {
                    selectedColor = pickedColor;
                  }
                },
                child: Text('Pick Color'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add Color'),
              onPressed: () {
                if (colorNameController.text.isNotEmpty) {
                  colorSystem.addColor(colorNameController.text, selectedColor);
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
