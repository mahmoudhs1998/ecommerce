// // import 'dart:io';
// //
// // import 'package:ecommerce/admin/order/test.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';
// //
// // import '../../features/shop/models/brand_model.dart';
// //
// //
// // import 'dart:io';
// //
// // import 'package:flutter/material.dart';
// //
// // import 'dart:io';
// //
// // import 'package:flutter/material.dart';
// //
// //
// // import '../../features/shop/models/category_model.dart';
// // import '../../features/shop/models/product_model.dart';
// // import '../../utils/constants/enums.dart';
// // import 'image_display.dart';
// // import 'new_controller.dart';
// // import 'new_model&ui.dart';
// //
// // class ProductAdditionForm extends StatelessWidget {
// //   final NewAdminPanelController controller = Get.put(NewAdminPanelController());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     Get.put(ColorManagementSystem());
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Add New Product'),
// //       ),
// //       body: SingleChildScrollView(
// //         padding: EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             TextFormField(
// //               controller: controller.titleController,
// //               decoration: InputDecoration(
// //                 labelText: 'Product Title*',
// //                 hintText: 'Enter product title',
// //               ),
// //             ),
// //             SizedBox(height: 16),
// //             TextFormField(
// //               controller: controller.stockController,
// //               decoration: InputDecoration(
// //                 labelText: 'Stock*',
// //                 hintText: 'Enter stock quantity',
// //               ),
// //               keyboardType: TextInputType.number,
// //             ),
// //             SizedBox(height: 16),
// //             TextFormField(
// //               controller: controller.skuController,
// //               decoration: InputDecoration(
// //                 labelText: 'SKU',
// //                 hintText: 'Enter product SKU',
// //               ),
// //             ),
// //             SizedBox(height: 16),
// //             TextFormField(
// //               controller: controller.priceController,
// //               decoration: InputDecoration(
// //                 labelText: 'Price*',
// //                 hintText: 'Enter product price',
// //               ),
// //               keyboardType: TextInputType.number,
// //             ),
// //             SizedBox(height: 16),
// //             TextFormField(
// //               controller: controller.salePriceController,
// //               decoration: InputDecoration(
// //                 labelText: 'Sale Price',
// //                 hintText: 'Enter sale price if applicable',
// //               ),
// //               keyboardType: TextInputType.number,
// //             ),
// //             SizedBox(height: 16),
// //             // TextFormField(
// //             //   controller: controller.productTypeController,
// //             //   decoration: InputDecoration(
// //             //     labelText: 'Product Type*',
// //             //     hintText: 'Enter product type',
// //             //   ),
// //             // ),
// //             Obx(() {
// //               return DropdownButton<ProductType>(
// //                 value: controller.selectedProductType.value,
// //                 items: ProductType.values.map((ProductType type) {
// //                   return DropdownMenuItem<ProductType>(
// //                     value: type,
// //                     child: Text(type.name),
// //                   );
// //                 }).toList(),
// //                 onChanged: (ProductType? newValue) {
// //                   if (newValue != null) {
// //                     controller.selectedProductType.value = newValue;
// //                   }
// //                 },
// //               );
// //
// //             }),
// //
// //             SizedBox(height: 16),
// //             TextFormField(
// //               controller: controller.descriptionController,
// //               decoration: InputDecoration(
// //                 labelText: 'Description',
// //                 hintText: 'Enter product description',
// //               ),
// //               maxLines: 3,
// //             ),
// //             SizedBox(height: 16),
// //             Obx(() =>
// //                 DropdownButtonFormField<NewBrandModel>(
// //                   value: controller.selectedBrand.value,
// //                   onChanged: (brand) => controller.selectBrand(brand!),
// //                   items: controller.filteredBrands.map((brand) {
// //                     return DropdownMenuItem<NewBrandModel>(
// //                       value: brand,
// //                       child: Text(brand.name),
// //                     );
// //                   }).toList(),
// //                   decoration: InputDecoration(
// //                     labelText: 'Brand*',
// //                     hintText: 'Select brand',
// //                   ),
// //                 )),
// //             SizedBox(height: 12.0),
// //
// //             // Select Category
// //             Obx(() => DropdownButtonFormField<CategoryModel>(
// //               value: controller.selectedCategory.value,
// //               onChanged: (CategoryModel? newValue) {
// //                 controller.selectCategory(newValue!);
// //               },
// //               decoration: InputDecoration(
// //                 labelText: 'Select Category',
// //                 border: OutlineInputBorder(),
// //               ),
// //               items: controller.filteredCategories.map((CategoryModel category) {
// //                 return DropdownMenuItem<CategoryModel>(
// //                   value: category,
// //                   child: Text(category.name),
// //                 );
// //               }).toList(),
// //             )),
// //
// //             SizedBox(height: 16),
// //             TextFormField(
// //               controller: controller.categoryIdController,
// //               decoration: InputDecoration(
// //                 labelText: 'Category ID*',
// //                 hintText: 'Enter category ID',
// //               ),
// //             ),
// //             SizedBox(height: 16),
// //             // TextFormField(
// //             //   controller: controller.thumbnailUrlController,
// //             //   decoration: InputDecoration(
// //             //     labelText: 'Thumbnail URL',
// //             //     hintText: 'Enter thumbnail URL',
// //             //   ),
// //             // ),
// //             ElevatedButton(
// //               onPressed: controller.selectThumbnailImageurl,
// //               child: Text('Select Thumbnail'),
// //             ),
// //             Obx(() => ImageDisplay(imageData: controller.thumbnailImage.value)),
// //             SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: controller.selectProductImages,
// //               child: Text('Add Product Images'),
// //             ),
// //             Obx(() => ListView.builder(
// //               shrinkWrap: true,
// //               itemCount: controller.productImages.length,
// //               itemBuilder: (context, index) {
// //                 return ImageDisplay(imageData: controller.productImages[index]);
// //               },
// //             )),
// //             SizedBox(height: 16),
// //         Obx(() =>
// //                   SwitchListTile(
// //                     title: const Text('Is Featured'),
// //                     value: controller.isFeatured.value,
// //                     onChanged: (value) {
// //                       controller.isFeatured.value = value;
// //                     },
// //                   )),
// //             SizedBox(height: 16),
// //             /// attributes and variations ---------
// //             ///
// //             ///
// //             NewProductAttributeForm(),
// //             NewProductVariationForm(),
// //
// //             ///
// //             /// -----------------------------------------
// //             ElevatedButton(
// //               onPressed: () => controller.addProduct(),
// //               child: Text('Add Product'),
// //             ),
// //             SizedBox(height: 16),
// //             Text('* Required fields', style: TextStyle(color: Colors.red)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// // old is perfect
// // new
// import 'package:ecommerce/features/shop/models/brand_model.dart';
// import 'package:ecommerce/features/shop/models/category_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
//
// import '../../features/shop/models/product_model.dart';
// import 'image_display.dart';
// import 'new_controller.dart';
// import 'new_model&ui.dart';
//
// class ProductAdditionForm extends StatelessWidget {
//   final NewAdminPanelController controller = Get.put(NewAdminPanelController());
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(ColorManagementSystem());
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Product'),
//       ),
//       body: SingleChildScrollView(
//         child: AlertDialog(
//           backgroundColor: Colors.grey[900], // Assuming bgColor is a dark shade
//           title: Center(child: Text('ADD PRODUCT', style: TextStyle(color: Colors.blue))),
//           content: Form(
//             key: controller.addProductFormKey,
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.7,
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildImageSection(),
//                   SizedBox(height: 16.0),
//                   _buildTextFields(),
//                   SizedBox(height: 16.0),
//                   _buildDropdowns(),
//                   SizedBox(height: 16.0),
//                   _buildType(),
//                   SizedBox(height: 16.0),
//                   _buildChoice(),
//                   SizedBox(height: 16.0),
//                   _buildAttributesAndVariations(),
//                   SizedBox(height: 16.0),
//                   _buildSubmitButtons(context),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildType(){
//     return             Obx(() {
//       return DropdownButton<ProductType>(
//         value: controller.selectedProductType.value,
//         items: ProductType.values.map((ProductType type) {
//           return DropdownMenuItem<ProductType>(
//             value: type,
//             child: Text(type.name),
//           );
//         }).toList(),
//         onChanged: (ProductType? newValue) {
//           if (newValue != null) {
//             controller.selectedProductType.value = newValue;
//           }
//         },
//       );
//
//     });
//   }
//
//   Widget _buildChoice(){
//
//     return  Obx(() =>
//                    SwitchListTile(
//                      title: const Text('Is Featured'),
//                      value: controller.isFeatured.value,
//                      onChanged: (value) {
//                        controller.isFeatured.value = value;
//                      },
//                    ));
//
//   }
//
//   // Widget _buildImageSection() {
//   //   return Obx(() {
//   //
//   //     List<Widget> imageWidgets = [
//   //       _buildImageCard('Main Image', controller.thumbnailImage.value, controller.selectThumbnailImageurl),
//   //       SizedBox(width: 8.0),
//   //       ...controller.productImages.asMap().entries.map((entry) {
//   //         int index = entry.key;
//   //         dynamic image = entry.value;
//   //         return _buildImageCard(
//   //             'Image ${index + 1}',
//   //             image,
//   //                 () => controller.selectProductImages()
//   //         );
//   //       }),
//   //       _buildAddImageCard(),
//   //     ];
//   //
//   //     return Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Text('Product Images', style: TextStyle(color: Colors.white)),
//   //         SizedBox(height: 8.0),
//   //         Container(
//   //           height: 150, // Adjust this height as needed
//   //           child: ListView(
//   //             scrollDirection: Axis.horizontal,
//   //             children: imageWidgets,
//   //           ),
//   //         ),
//   //       ],
//   //     );
//   //   });
//   // }
//   Widget _buildImageSection() {
//     return Obx(() {
//       List<Widget> imageWidgets = [
//         _buildImageCard('Main Image', controller.thumbnailImage.value, controller.selectThumbnailImageurl),
//         SizedBox(width: 8.0),
//         ...controller.productImages.asMap().entries.map((entry) {
//           int index = entry.key;
//           dynamic image = entry.value;
//           return _buildImageCard(
//             'Image ${index + 1}',
//             image,
//                 () => controller.selectProductImages(index),
//             onRemove: () => controller.removeProductImage(index),
//             onUpdate: () => controller.selectProductImages(index),
//           );
//         }),
//         _buildAddImageCard(),
//       ];
//
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Product Images', style: TextStyle(color: Colors.white)),
//           SizedBox(height: 8.0),
//           Obx(() {
//             return LinearProgressIndicator(
//               value: controller.scrollProgress.value,
//               backgroundColor: Colors.grey[800],
//               color: Colors.blue,
//             );
//           }),
//           Container(
//             height: 150,
//             child: ListView(
//               controller: controller.scrollController,
//               scrollDirection: Axis.horizontal,
//               children: imageWidgets,
//             ),
//           ),
//         ],
//       );
//     });
//   }
//
//   Widget _buildImageCard(String label, dynamic image, Function() onTap, {Function()? onRemove, Function()? onUpdate}) {
//     return Container(
//       width: 200,
//       margin: EdgeInsets.only(right: 8.0),
//       child: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 InkWell(
//                   onTap: onTap,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey,
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Center(
//                       child: image != null
//                           ? ImageDisplay(imageData: image)
//                           : Icon(Icons.image, color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 if (onRemove != null)
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     child: IconButton(
//                       icon: Icon(Icons.close, color: Colors.red),
//                       onPressed: onRemove,
//                     ),
//                   ),
//                 if (onUpdate != null)
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: IconButton(
//                       icon: Icon(Icons.edit, color: Colors.blue),
//                       onPressed: onUpdate,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           SizedBox(height: 4.0),
//           Text(label, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis),
//         ],
//       ),
//     );
//   }
//
//   // Widget _buildImageCard(String label, dynamic image, Function() onTap, {Function()? onRemove}) {
//   //   return Container(
//   //     width: 100,
//   //     margin: EdgeInsets.only(right: 8.0),
//   //     child: Column(
//   //       children: [
//   //         Expanded(
//   //           child: Stack(
//   //             children: [
//   //               InkWell(
//   //                 onTap: onTap,
//   //                 child: Container(
//   //                   decoration: BoxDecoration(
//   //                     color: Colors.grey,
//   //                     border: Border.all(color: Colors.white),
//   //                     borderRadius: BorderRadius.circular(8.0),
//   //                   ),
//   //                   child: Center(
//   //                     child: image != null
//   //                         ? ImageDisplay(imageData: image)
//   //                         : Icon(Icons.image, color: Colors.white),
//   //                   ),
//   //                 ),
//   //               ),
//   //               if (onRemove != null)
//   //                 Positioned(
//   //                   top: 0,
//   //                   right: 0,
//   //                   child: IconButton(
//   //                     icon: Icon(Icons.close, color: Colors.white),
//   //                     onPressed: onRemove,
//   //                   ),
//   //                 ),
//   //             ],
//   //           ),
//   //         ),
//   //         SizedBox(height: 4.0),
//   //         Text(label, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   Widget _buildAddImageCard() {
//     return Container(
//       width: 100,
//       margin: EdgeInsets.only(right: 8.0),
//       child: Column(
//         children: [
//           Expanded(
//             child: InkWell(
//               onTap: () => controller.selectProductImages(),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   border: Border.all(color: Colors.white),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Center(
//                   child: Icon(Icons.add_a_photo, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 4.0),
//           Text('Add Image', style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis),
//         ],
//       ),
//     );
//   }
//
//
//
//   // Widget _buildImageSection() {
//   //   return Row(
//   //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //     children: [
//   //       _buildImageCard('Main Image', controller.selectThumbnailImageurl),
//   //       _buildImageCard('Second Image', () => controller.selectProductImages()),
//   //       _buildImageCard('Third Image', () => controller.selectProductImages()),
//   //       _buildImageCard('Fourth Image', () => controller.selectProductImages()),
//   //       _buildImageCard('Fifth Image', () => controller.selectProductImages()),
//   //     ],
//   //   );
//   // }
//   //
//   // Widget _buildImageCard(String label, Function() onTap) {
//   //   return Column(
//   //     children: [
//   //       Text(label),
//   //       InkWell(
//   //         onTap: onTap,
//   //         child: Container(
//   //           width: 100,
//   //           height: 100,
//   //           color: Colors.grey,
//   //           child: Icon(Icons.add_a_photo),
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }
//
//   Widget _buildTextFields() {
//     return Column(
//       children: [
//         TextField(
//           controller: controller.titleController,
//           decoration: InputDecoration(labelText: 'Product Name'),
//         ),
//         TextField(
//           controller: controller.descriptionController,
//           decoration: InputDecoration(labelText: 'Product Description'),
//           maxLines: 3,
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: controller.priceController,
//                 decoration: InputDecoration(labelText: 'Price'),
//                 keyboardType: TextInputType.number,
//               ),
//             ),
//             Expanded(
//               child: TextField(
//                 controller: controller.salePriceController,
//                 decoration: InputDecoration(labelText: 'Offer Price'),
//                 keyboardType: TextInputType.number,
//               ),
//             ),
//             Expanded(
//               child: TextField(
//                 controller: controller.stockController,
//                 decoration: InputDecoration(labelText: 'Quantity'),
//                 keyboardType: TextInputType.number,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDropdowns() {
//     return Row(
//       children: [
//         Expanded(
//           child: Obx(() => DropdownButtonFormField<CategoryModel>(
//             value: controller.selectedCategory.value,
//             items: controller.categories.map((category) {
//               return DropdownMenuItem<CategoryModel>(
//                 value: category,
//                 child: Text(category.name),
//               );
//             }).toList(),
//             onChanged: (newValue) {
//               controller.selectCategory(newValue!);
//             },
//             decoration: InputDecoration(labelText: 'Category'),
//           )),
//         ),
//         // Expanded(
//         //   child: Obx(() => DropdownButtonFormField<SubCategory>(
//         //     value: controller.selectedSubCategory.value,
//         //     items: controller.subCategories.map((subCategory) {
//         //       return DropdownMenuItem<SubCategory>(
//         //         value: subCategory,
//         //         child: Text(subCategory.name),
//         //       );
//         //     }).toList(),
//         //     onChanged: (newValue) {
//         //       controller.selectSubCategory(newValue!);
//         //     },
//         //     decoration: InputDecoration(labelText: 'Sub Category'),
//         //   )),
//         // ),
//         Expanded(
//           child: Obx(() => DropdownButtonFormField<NewBrandModel>(
//             value: controller.selectedBrand.value,
//             items: controller.brands.map((brand) {
//               return DropdownMenuItem<NewBrandModel>(
//                 value: brand,
//                 child: Text(brand.name),
//               );
//             }).toList(),
//             onChanged: (newValue) {
//               controller.selectBrand(newValue!);
//             },
//             decoration: InputDecoration(labelText: 'Brand'),
//           )),
//         ),
//          Expanded(
//            child:             Obx(() {
//              return DropdownButtonFormField<ProductType>(
//                value: controller.selectedProductType.value,
//                items: ProductType.values.map((ProductType type) {
//                  return DropdownMenuItem<ProductType>(
//                    value: type,
//                    child: Text(type.name),
//                  );
//                }).toList(),
//                onChanged: (ProductType? newValue) {
//                  if (newValue != null) {
//                    controller.selectedProductType.value = newValue;
//                  }
//                },
//              );
//
//            }),
//          ),
//       ],
//     );
//   }
//
//   Widget _buildAttributesAndVariations() {
//     return Column(
//       children: [
//         NewProductAttributeForm(),
//         NewProductVariationForm(),
//       ],
//     );
//   }
//
//   Widget _buildSubmitButtons(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             foregroundColor: Colors.white,
//             backgroundColor: Colors.grey,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('Cancel'),
//         ),
//         SizedBox(width: 16.0),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             foregroundColor: Colors.white,
//             backgroundColor: Colors.blue,
//           ),
//           onPressed: () {
//             if (controller.addProductFormKey.currentState!.validate()) {
//               controller.addProductFormKey.currentState!.save();
//               controller.addProduct();
//               Navigator.of(context).pop();
//             }
//           },
//           child: Text('Submit'),
//         ),
//       ],
//     );
//   }
// }