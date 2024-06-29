// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // import '../../features/shop/models/brand_model.dart';
// // import '../../features/shop/models/product_attribute_model.dart';
// // import '../../features/shop/models/product_variation_model.dart';
// // import 'controller/admin_product_controller.dart';

// // class AdminProductScreen extends StatelessWidget {
// //   final AdminProductController controller = Get.put(AdminProductController());

// //   AdminProductScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Add Product'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               TextField(
// //                 controller: controller.titleController,
// //                 decoration: InputDecoration(labelText: 'Title'),
// //               ),
// //               TextField(
// //                 controller: controller.descriptionController,
// //                 decoration: InputDecoration(labelText: 'Description'),
// //               ),
// //               TextField(
// //                 controller: controller.priceController,
// //                 decoration: InputDecoration(labelText: 'Price'),
// //                 keyboardType: TextInputType.number,
// //               ),
// //               TextField(
// //                 controller: controller.salePriceController,
// //                 decoration: InputDecoration(labelText: 'Sale Price'),
// //                 keyboardType: TextInputType.number,
// //               ),
// //               TextField(
// //                 controller: controller.stockController,
// //                 decoration: InputDecoration(labelText: 'Stock'),
// //                 keyboardType: TextInputType.number,
// //               ),
// //               TextField(
// //                 controller: controller.skuController,
// //                 decoration: InputDecoration(labelText: 'SKU'),
// //               ),
// //               TextField(
// //                 controller: controller.categoryIdController,
// //                 decoration: InputDecoration(labelText: 'Category ID'),
// //               ),
// //               TextField(
// //                 controller: controller.productTypeController,
// //                 decoration: InputDecoration(labelText: 'Product Type'),
// //               ),
// //               Obx(
// //                 () => CheckboxListTile(
// //                   title: Text('Featured'),
// //                   value: controller.isFeatured.value,
// //                   onChanged: (bool? value) {
// //                     controller.isFeatured.value = value ?? false;
// //                   },
// //                 ),
// //               ),
// //               Obx(
// //                 () => controller.thumbnailUrl.value.isEmpty
// //                     ? ElevatedButton(
// //                         onPressed: controller.pickThumbnail,
// //                         child: Text('Pick Thumbnail'),
// //                       )
// //                     : Image.network(controller.thumbnailUrl.value),
// //               ),
// //               ElevatedButton(
// //                 onPressed: controller.pickImages,
// //                 child: Text('Pick Images'),
// //               ),
// //               Obx(
// //                 () => Wrap(
// //                   children: controller.images
// //                       .map((url) => Image.network(
// //                             url,
// //                             width: 100,
// //                             height: 100,
// //                           ))
// //                       .toList(),
// //                 ),
// //               ),
// //               SizedBox(height: 20),
// //               DynamicProductAttributes(controller: controller),
// //               SizedBox(height: 20),
// //               DynamicProductVariations(controller: controller),
// //               SizedBox(height: 20),
// //               // StreamBuilder<QuerySnapshot>(
// //               //   stream:
// //               //       FirebaseFirestore.instance.collection('Brands').snapshots(),
// //               //   builder: (context, snapshot) {
// //               //     if (!snapshot.hasData) {
// //               //       return CircularProgressIndicator();
// //               //     }
// //               //     final brands = snapshot.data!.docs
// //               //         .map((doc) => BrandModel.fromQuerySnapshot(doc))
// //               //         .toList();
// //               //     return DropdownButtonFormField<String>(
// //               //       value: controller.selectedBrandId.value,
// //               //       items: brands.map((brand) {
// //               //         return DropdownMenuItem<String>(
// //               //           value: brand.id,
// //               //           child: Text(brand.name),
// //               //         );
// //               //       }).toList(),
// //               //       onChanged: (String? newValue) {
// //               //         controller.selectedBrandId.value = newValue!;
// //               //       },
// //               //       decoration: InputDecoration(labelText: 'Brand'),
// //               //     );
// //               //   },
// //               // ),
// //               StreamBuilder<QuerySnapshot>(
// //                 stream:
// //                     FirebaseFirestore.instance.collection('Brands').snapshots(),
// //                 builder: (context, snapshot) {
// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return CircularProgressIndicator();
// //                   }
// //                   if (snapshot.hasError) {
// //                     return Text('Error: ${snapshot.error}');
// //                   }
// //                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //                     return Text('No data available');
// //                   }

// //                   final brands = snapshot.data!.docs
// //                       .map((doc) => BrandModel.fromQuerySnapshot(doc))
// //                       .toList();

// //                   return DropdownButtonFormField<String>(
// //                     value: controller.selectedBrandId.value,
// //                     items: brands.map((brand) {
// //                       return DropdownMenuItem<String>(
// //                         value: brand.id,
// //                         child: Text(brand.name),
// //                       );
// //                     }).toList(),
// //                     onChanged: (String? newValue) {
// //                       controller.selectedBrandId.value = newValue!;
// //                     },
// //                     decoration: InputDecoration(labelText: 'Brand'),
// //                   );
// //                 },
// //               ),

// //               SizedBox(height: 20),
// //               ElevatedButton(
// //                 onPressed: controller.addProduct,
// //                 child: Text('Add Product'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // //---------------------------------------------------

// // class DynamicProductAttributes extends StatelessWidget {
// //   final AdminProductController controller;

// //   DynamicProductAttributes({required this.controller});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Obx(
// //       () => Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text('Product Attributes',
// //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// //           ListView.builder(
// //             shrinkWrap: true,
// //             itemCount: controller.productAttributes.length,
// //             itemBuilder: (context, index) {
// //               final attribute = controller.productAttributes[index];
// //               return AttributeItem(
// //                 attribute: attribute,
// //                 onRemove: () {
// //                   controller.productAttributes.removeAt(index);
// //                 },
// //                 onUpdate: (name, values) {
// //                   controller.productAttributes[index] =
// //                       ProductAttributeModel(name: name, values: values);
// //                 },
// //               );
// //             },
// //           ),
// //           ElevatedButton(
// //             onPressed: () {
// //               controller.productAttributes
// //                   .add(ProductAttributeModel(name: '', values: []));
// //             },
// //             child: Text('Add Attribute'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class AttributeItem extends StatelessWidget {
// //   final ProductAttributeModel attribute;
// //   final VoidCallback onRemove;
// //   final Function(String name, List<String> values) onUpdate;

// //   AttributeItem(
// //       {super.key,
// //       required this.attribute,
// //       required this.onRemove,
// //       required this.onUpdate});

// //   final TextEditingController nameController = TextEditingController();
// //   final TextEditingController valueController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     nameController.text = attribute.name!;
// //     return Column(
// //       children: [
// //         Row(
// //           children: [
// //             Expanded(
// //               child: TextField(
// //                 controller: nameController,
// //                 decoration: InputDecoration(labelText: 'Attribute Name'),
// //                 onChanged: (value) {
// //                   onUpdate(nameController.text, attribute.values!);
// //                 },
// //               ),
// //             ),
// //             IconButton(
// //               icon: Icon(Icons.delete),
// //               onPressed: onRemove,
// //             ),
// //           ],
// //         ),
// //         Column(
// //           children: attribute.values!.map((value) {
// //             final valueController = TextEditingController(text: value);
// //             return Row(
// //               children: [
// //                 Expanded(
// //                   child: TextField(
// //                     controller: valueController,
// //                     decoration: InputDecoration(labelText: 'Value'),
// //                     onChanged: (newValue) {
// //                       final index = attribute.values!.indexOf(value);
// //                       attribute.values![index] = newValue;
// //                       onUpdate(nameController.text, attribute.values!);
// //                     },
// //                   ),
// //                 ),
// //                 IconButton(
// //                   icon: Icon(Icons.delete),
// //                   onPressed: () {
// //                     attribute.values!.remove(value);
// //                     onUpdate(nameController.text, attribute.values!);
// //                   },
// //                 ),
// //               ],
// //             );
// //           }).toList(),
// //         ),
// //         ElevatedButton(
// //           onPressed: () {
// //             attribute.values!.add('');
// //             onUpdate(nameController.text, attribute.values!);
// //           },
// //           child: Text('Add Value'),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // //---------------------------------------------------

// // class DynamicProductVariations extends StatelessWidget {
// //   final AdminProductController controller;

// //   const DynamicProductVariations({super.key, required this.controller});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Obx(
// //       () => Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text('Product Variations',
// //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// //           ListView.builder(
// //             shrinkWrap: true,
// //             itemCount: controller.productVariations.length,
// //             itemBuilder: (context, index) {
// //               final variation = controller.productVariations[index];
// //               return VariationItem(
// //                 variation: variation,
// //                 onRemove: () {
// //                   controller.productVariations.removeAt(index);
// //                 },
// //                 onUpdate: (updatedVariation) {
// //                   controller.productVariations[index] = updatedVariation;
// //                 },
// //               );
// //             },
// //           ),
// //           ElevatedButton(
// //             onPressed: () {
// //               controller.productVariations.add(ProductVariationModel(
// //                 id: '',
// //                 stock: 0,
// //                 price: 0.0,
// //                 salePrice: 0.0,
// //                 image: '',
// //                 description: '',
// //                 attributeValues: {},
// //               ));
// //             },
// //             child: Text('Add Variation'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class VariationItem extends StatelessWidget {
// //   final ProductVariationModel variation;
// //   final VoidCallback onRemove;
// //   final Function(ProductVariationModel updatedVariation) onUpdate;

// //   VariationItem(
// //       {required this.variation,
// //       required this.onRemove,
// //       required this.onUpdate});

// //   final TextEditingController stockController = TextEditingController();
// //   final TextEditingController priceController = TextEditingController();
// //   final TextEditingController salePriceController = TextEditingController();
// //   final TextEditingController descriptionController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     stockController.text = variation.stock.toString();
// //     priceController.text = variation.price.toString();
// //     salePriceController.text = variation.salePrice.toString();
// //     descriptionController.text = variation.description!;

// //     return Column(
// //       children: [
// //         Row(
// //           children: [
// //             Expanded(
// //               child: TextField(
// //                 controller: stockController,
// //                 decoration: InputDecoration(labelText: 'Stock'),
// //                 keyboardType: TextInputType.number,
// //                 onChanged: (value) {
// //                   final updatedVariation = variation.copyWith(
// //                       stock: int.parse(stockController.text));
// //                   onUpdate(updatedVariation);
// //                 },
// //               ),
// //             ),
// //             Expanded(
// //               child: TextField(
// //                 controller: priceController,
// //                 decoration: InputDecoration(labelText: 'Price'),
// //                 keyboardType: TextInputType.number,
// //                 onChanged: (value) {
// //                   final updatedVariation = variation.copyWith(
// //                       price: double.parse(priceController.text));
// //                   onUpdate(updatedVariation);
// //                 },
// //               ),
// //             ),
// //             Expanded(
// //               child: TextField(
// //                 controller: salePriceController,
// //                 decoration: InputDecoration(labelText: 'Sale Price'),
// //                 keyboardType: TextInputType.number,
// //                 onChanged: (value) {
// //                   final updatedVariation = variation.copyWith(
// //                       salePrice: double.parse(salePriceController.text));
// //                   onUpdate(updatedVariation);
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //         TextField(
// //           controller: descriptionController,
// //           decoration: InputDecoration(labelText: 'Description'),
// //           onChanged: (value) {
// //             final updatedVariation =
// //                 variation.copyWith(description: descriptionController.text);
// //             onUpdate(updatedVariation);
// //           },
// //         ),
// //         // You can add more fields here as needed
// //         ElevatedButton(
// //           onPressed: onRemove,
// //           child: Text('Remove Variation'),
// //         ),
// //       ],
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'controller/admin_product_controller.dart';

// class AdminPanel extends StatelessWidget {
//   final AdminPanelController controller = Get.put(AdminPanelController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add Product')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: controller.formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: controller.titleController,
//                 decoration: InputDecoration(labelText: 'Title'),
//                 validator: (value) => value!.isEmpty ? 'Enter title' : null,
//               ),
//               TextFormField(
//                 controller: controller.stockController,
//                 decoration: InputDecoration(labelText: 'Stock'),
//                 validator: (value) => value!.isEmpty ? 'Enter stock' : null,
//                 keyboardType: TextInputType.number,
//               ),
//               TextFormField(
//                 controller: controller.skuController,
//                 decoration: InputDecoration(labelText: 'SKU'),
//               ),
//               TextFormField(
//                 controller: controller.priceController,
//                 decoration: InputDecoration(labelText: 'Price'),
//                 validator: (value) => value!.isEmpty ? 'Enter price' : null,
//                 keyboardType: TextInputType.number,
//               ),
//               TextFormField(
//                 controller: controller.salePriceController,
//                 decoration: InputDecoration(labelText: 'Sale Price'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextFormField(
//                 controller: controller.thumbnailController,
//                 decoration: InputDecoration(labelText: 'Thumbnail URL'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Enter thumbnail URL' : null,
//               ),
//               TextFormField(
//                 controller: controller.productTypeController,
//                 decoration: InputDecoration(labelText: 'Product Type'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Enter product type' : null,
//               ),
//               TextFormField(
//                 controller: controller.descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//               ),
//               TextFormField(
//                 controller: controller.categoryIdController,
//                 decoration: InputDecoration(labelText: 'Category ID'),
//               ),
//               TextFormField(
//                 controller: controller.imagesController,
//                 decoration:
//                     InputDecoration(labelText: 'Images (comma separated URLs)'),
//               ),
//               Obx(
//                 () => SwitchListTile(
//                   title: Text('Is Featured'),
//                   value: controller.isFeatured.value,
//                   onChanged: (value) {
//                     controller.isFeatured.value = value;
//                   },
//                 ),
//               ),
//               TextFormField(
//                 controller: controller.dateController,
//                 decoration: InputDecoration(labelText: 'Date'),
//                 keyboardType: TextInputType.datetime,
//               ),
//               // Fields for BrandModel
//               TextFormField(
//                 controller: controller.brandIdController,
//                 decoration: InputDecoration(labelText: 'Brand ID'),
//               ),
//               TextFormField(
//                 controller: controller.brandImageController,
//                 decoration: InputDecoration(labelText: 'Brand Image URL'),
//               ),
//               TextFormField(
//                 controller: controller.brandNameController,
//                 decoration: InputDecoration(labelText: 'Brand Name'),
//               ),
//               TextFormField(
//                 controller: controller.brandProductsCountController,
//                 decoration: InputDecoration(labelText: 'Brand Products Count'),
//                 keyboardType: TextInputType.number,
//               ),
//               Obx(
//                 () => SwitchListTile(
//                   title: Text('Brand Is Featured'),
//                   value: controller.brandIsFeatured.value,
//                   onChanged: (value) {
//                     controller.brandIsFeatured.value = value;
//                   },
//                 ),
//               ),
//               // Fields for ProductAttributeModel
//               TextFormField(
//                 controller: controller.attributesController,
//                 decoration:
//                     InputDecoration(labelText: 'Attributes (comma separated)'),
//               ),
//               // Fields for ProductVariationModel
//               TextFormField(
//                 controller: controller.variationsController,
//                 decoration:
//                     InputDecoration(labelText: 'Variations (comma separated)'),
//               ),
//               SizedBox(height: 20),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/admin_product_controller.dart';

class AdminPanel extends StatelessWidget {
  final AdminPanelController controller = Get.put(AdminPanelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: controller.titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Enter title' : null,
              ),
              TextFormField(
                controller: controller.stockController,
                decoration: InputDecoration(labelText: 'Stock'),
                validator: (value) => value!.isEmpty ? 'Enter stock' : null,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: controller.skuController,
                decoration: InputDecoration(labelText: 'SKU'),
              ),
              TextFormField(
                controller: controller.priceController,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) => value!.isEmpty ? 'Enter price' : null,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: controller.salePriceController,
                decoration: InputDecoration(labelText: 'Sale Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: controller.thumbnailController,
                decoration: InputDecoration(labelText: 'Thumbnail URL'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter thumbnail URL' : null,
              ),
              TextFormField(
                controller: controller.productTypeController,
                decoration: InputDecoration(labelText: 'Product Type'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter product type' : null,
              ),
              TextFormField(
                controller: controller.descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: controller.categoryIdController,
                decoration: InputDecoration(labelText: 'Category ID'),
              ),
              TextFormField(
                controller: controller.imagesController,
                decoration:
                    InputDecoration(labelText: 'Images (comma separated URLs)'),
              ),
              Obx(
                () => SwitchListTile(
                  title: Text('Is Featured'),
                  value: controller.isFeatured.value,
                  onChanged: (value) {
                    controller.isFeatured.value = value;
                  },
                ),
              ),
              TextFormField(
                controller: controller.dateController,
                decoration: InputDecoration(labelText: 'Date'),
                keyboardType: TextInputType.datetime,
              ),
              // Fields for BrandModel
              TextFormField(
                controller: controller.brandIdController,
                decoration: InputDecoration(labelText: 'Brand ID'),
              ),
              TextFormField(
                controller: controller.brandImageController,
                decoration: InputDecoration(labelText: 'Brand Image URL'),
              ),
              TextFormField(
                controller: controller.brandNameController,
                decoration: InputDecoration(labelText: 'Brand Name'),
              ),
              TextFormField(
                controller: controller.brandProductsCountController,
                decoration: InputDecoration(labelText: 'Brand Products Count'),
                keyboardType: TextInputType.number,
              ),
              Obx(
                () => SwitchListTile(
                  title: Text('Brand Is Featured'),
                  value: controller.brandIsFeatured.value,
                  onChanged: (value) {
                    controller.brandIsFeatured.value = value;
                  },
                ),
              ),
              // Dynamic fields for ProductAttributeModel
              Obx(() => Column(
                    children: [
                      for (var attribute in controller.productAttributes)
                        ListTile(
                          title: Text(
                              '${attribute.name}: ${attribute.values!.join(', ')}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () =>
                                controller.removeAttribute(attribute),
                          ),
                        ),
                      TextButton(
                        onPressed: controller.addAttributeField,
                        child: Text('Add Attribute'),
                      ),
                    ],
                  )),
              // Dynamic fields for ProductVariationModel
              Obx(() => Column(
                    children: [
                      for (var variation in controller.productVariations)
                        ListTile(
                          title: Text(
                              '${variation.id}: ${variation.attributeValues}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () =>
                                controller.removeVariation(variation),
                          ),
                        ),
                      TextButton(
                        onPressed: controller.addVariationField,
                        child: Text('Add Variation'),
                      ),
                    ],
                  )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.addProduct,
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
