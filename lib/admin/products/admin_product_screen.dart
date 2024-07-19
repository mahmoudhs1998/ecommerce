// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ecommerce/admin/products/controller/clean_admin_product_controller.dart';
// import 'package:ecommerce/features/shop/models/brand_model.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../features/shop/models/category_model.dart';
// import 'controller/test/logic.dart';
//
// class AdminPanelPage extends StatelessWidget {
//   final AdminPanelController _controller = Get.put(AdminPanelController());
//   final AdminSelectBrandController _controllers = Get.put(AdminSelectBrandController());
//
//
//   AdminPanelPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Admin Panel'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _controller.titleController,
//                 decoration: const InputDecoration(labelText: 'Title'),
//               ),
//               TextField(
//                 controller: _controller.stockController,
//                 decoration: const InputDecoration(labelText: 'Stock'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 controller: _controller.skuController,
//                 decoration: const InputDecoration(labelText: 'SKU'),
//               ),
//               TextField(
//                 controller: _controller.priceController,
//                 decoration: const InputDecoration(labelText: 'Price'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 controller: _controller.salePriceController,
//                 decoration: const InputDecoration(labelText: 'Sale Price'),
//                 keyboardType: TextInputType.number,
//               ),
//               // TextField(
//               //   controller: _controller.thumbnailController,
//               //   decoration: const InputDecoration(labelText: 'Thumbnail URL'),
//               // ),
//               // ThumbnailField
//               Obx(() {
//                 if (_controller.selectedThumbnailImage.value == null) {
//                   return ElevatedButton(
//                     onPressed: _controller.pickImage,
//                     child: const Text('Pick Thumbnail'),
//                   );
//                 } else {
//                   return kIsWeb
//                       ? CachedNetworkImage(
//                     imageUrl:
//                     _controller.selectedThumbnailImage.value!.path,
//                     placeholder: (context, url) =>
//                     // ignore: prefer_const_constructors
//                     Center(child: const CircularProgressIndicator()),
//                     errorWidget: (context, url, error) =>
//                     const Icon(Icons.error),
//                   )
//                       : Image.file(
//                       File(_controller.selectedThumbnailImage.value!.path));
//                 }
//               }),
//               TextField(
//                 controller: _controller.productTypeController,
//                 decoration: const InputDecoration(labelText: 'Product Type'),
//               ),
//               TextField(
//                 controller: _controller.descriptionController,
//                 decoration: const InputDecoration(labelText: 'Description'),
//               ),
//               TextField(
//                 controller: _controller.categoryIdController,
//                 decoration: const InputDecoration(labelText: 'Category ID'),
//               ),
//               // TextField(
//               //   controller: _controller.imagesController,
//               //   decoration: const InputDecoration(
//               //       labelText: 'Images (comma separated)'),
//               // ),
//               // UI to display selected images and upload button
//               Obx(() {
//                 if (_controller.selectedImages.isEmpty) {
//                   return ElevatedButton(
//                     onPressed: _controller.pickImages,
//                     child: const Text('Pick Images'),
//                   );
//                 } else {
//                   return Column(
//                     children: [
//                       Wrap(
//                         spacing: 8.0,
//                         runSpacing: 8.0,
//                         children: _controller.selectedImages.map((image) {
//                           return kIsWeb
//                               ? CachedNetworkImage(
//                             imageUrl: image!.path,
//                             placeholder: (context, url) =>
//                             const Center(
//                                 child: CircularProgressIndicator()),
//                             errorWidget: (context, url, error) =>
//                             const Icon(Icons.error),
//                           )
//                               : Image.file(File(image!.path));
//                         }).toList(),
//                       ),
//                       ElevatedButton(
//                         onPressed: _controller.uploadAllImages,
//                         child: const Text('Upload Images'),
//                       ),
//                     ],
//                   );
//                 }
//               }),
//               Obx(() {
//                 return Wrap(
//                   spacing: 8.0,
//                   runSpacing: 8.0,
//                   children: _controller.uploadedImageUrls.map((imageUrl) {
//                     return kIsWeb
//                         ? CachedNetworkImage(
//                       imageUrl: imageUrl,
//                       placeholder: (context, url) =>
//                       const Center(
//                           child: CircularProgressIndicator()),
//                       errorWidget: (context, url, error) =>
//                       const Icon(Icons.error),
//                     )
//                         : Image.network(
//                         imageUrl); // For mobile, use Image.network
//                   }).toList(),
//                 );
//               }),
//
//               TextField(
//                 controller: _controllers.brandIdController,
//                 decoration: const InputDecoration(labelText: 'Brand ID'),
//               ),
//               TextField(
//                 controller: _controllers.brandImageController,
//                 decoration: const InputDecoration(labelText: 'Brand Image URL'),
//               ),
//               TextField(
//                 controller: _controllers.brandNameController,
//                 decoration: const InputDecoration(labelText: 'Brand Name'),
//               ),
//               TextField(
//                 controller: _controller.brandProductsCountController,
//                 decoration:
//                 const InputDecoration(labelText: 'Brand Products Count'),
//                 keyboardType: TextInputType.number,
//               ),
//               Obx(() =>
//                   SwitchListTile(
//                     title: const Text('Is Featured'),
//                     value: _controller.isFeatured.value,
//                     onChanged: (value) {
//                       _controller.isFeatured.value = value;
//                     },
//                   )),
//               Obx(() =>
//                   SwitchListTile(
//                     title: const Text('Brand Is Featured'),
//                     value: _controller.brandIsFeatured.value,
//                     onChanged: (value) {
//                       _controller.brandIsFeatured.value = value;
//                     },
//                   )),
//               // ElevatedButton(
//               //   onPressed: () {
//               //     Get.dialog(AddAttributeDialog(onSubmit: (attribute) {
//               //       _controller.productAttributes.add(attribute);
//               //     }));
//               //   },
//               //   child: const Text('Add Attribute'),
//               // ),
//               ElevatedButton(
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AddAttributeDialog(
//                       onSubmit: (name, values) {
//                         Get.find<AdminPanelController>().addAttribute(name, values);
//                       },
//                     ),
//                   );
//                 },
//                 child: const Text('Add Attribute'),
//               ),
//
//               Obx(() =>
//                   ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: _controller.productAttributes.length,
//                     itemBuilder: (context, index) {
//                       final attribute = _controller.productAttributes[index];
//                       return ListTile(
//                         title: Text(attribute.name!),
//                         subtitle: Text(attribute.values!.join(', ')),
//                       );
//                     },
//                   )),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.dialog(
//                     AddVariationDialog(
//                       onSubmit: (variation) {
//                         Get.find<AdminPanelController>().addVariation(variation);
//                       },
//                     ),
//                   );
//                 },
//                 child: const Text('Add Variation'),
//               ),
//
//               // ElevatedButton(
//               //   onPressed: () {
//               //     Get.dialog(AddVariationDialog(onSubmit: (variation) {
//               //       _controller.productVariations.add(variation);
//               //     }));
//               //   },
//               //   child: const Text('Add Variation'),
//               // ),
//               Obx(() =>
//                   ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: _controller.productVariations.length,
//                     itemBuilder: (context, index) {
//                       final variation = _controller.productVariations[index];
//                       return ListTile(
//                         title: Text(variation.id),
//                         subtitle: Text(
//                             'Stock: ${variation.stock}, Price: ${variation
//                                 .price}'),
//                       );
//                     },
//                   )),
//               const SizedBox(height: 20),
//               // Dropdown for selecting category
//               // Dropdown for selecting category
//               Obx(() {
//                 return DropdownButtonFormField<String>(
//                   value: _controller.selectedCategory.value?.name,
//                   items: _controller.categories.map((CategoryModel category) {
//                     return DropdownMenuItem<String>(
//                       value: category.name,
//                       child: Text(category.name),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       _controller.selectCategoryByName(newValue);
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Category',
//                   ),
//                 );
//               }),
//
//               SizedBox(height: 20),
//
//               // Dropdown for selecting subcategory
//               Obx(() {
//                 return DropdownButtonFormField<String>(
//                   value: _controller.selectedSubcategory.value?.name,
//                   items: _controller.subcategories.map((
//                       SubCategoryModel subcategory) {
//                     return DropdownMenuItem<String>(
//                       value: subcategory.name,
//                       child: Text(subcategory.name),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       _controller.selectSubcategoryByName(newValue);
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Subcategory',
//                   ),
//                 );
//               }),
//               SizedBox(height: 20),
//
//               // Dropdown for selecting Brands
//               Obx(() {
//                 return
//                   DropdownButtonFormField<String>(
//                     value: _controllers.selectedBrand.value?.name,
//                     items: _controllers.sbrands.map((NewBrandModel brand) {
//                       return DropdownMenuItem<String>(
//                         value: brand.name,
//                         child: Text(brand.name),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       if (newValue != null) {
//                         _controllers.selectBrandByName(newValue);
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Brands',
//                     ),
//                   )
//                 ;
//               }),
//               Column(
//                 children: [
//                   Obx(
//                         () {
//                       String? selectedBrandName = _controllers.selectedBrand.value?.name;
//
//                       print('Selected Brand Name: $selectedBrandName');
//                       _controllers.sbrands.forEach((brand) => print('Brand in list: ${brand.name}'));
//
//                       return DropdownButtonFormField<String>(
//                         value: selectedBrandName != '' ? selectedBrandName : null,
//                         items: _controllers.sbrands.map((NewBrandModel brand) {
//                           return DropdownMenuItem<String>(
//                             value: brand.name,
//                             child: Text(brand.name),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           print('Selected new brand: $newValue');
//                           if (newValue != null) {
//                             _controllers.selectBrandByName(newValue);
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'new Brands',
//                         ),
//                       );
//                     },
//                   ),
//                   TextField(
//                     enabled: false,
//                     controller: _controllers.brandIdController,
//                     decoration: const InputDecoration(labelText: 'Brand ID'),
//                   ),
//                   TextField(
//                     controller: _controllers.brandImageController,
//                     decoration: const InputDecoration(labelText: 'Brand Image URL'),
//                   ),
//                   TextField(
//                     controller: _controllers.brandNameController,
//                     decoration: const InputDecoration(labelText: 'Brand Name'),
//                   ),
//                 ],
//               ),
//
//               Obx(
//                     () {
//                   String? selectedBrandName = _controller.selectedBrand.value?.name;
//
//                   print('Selected Brand Name: $selectedBrandName');
//                   _controller.allBrands.forEach((brand) => print('Brand in list: ${brand.name}'));
//
//                   return DropdownButtonFormField<String>(
//                     value: selectedBrandName != '' ? selectedBrandName : null,
//                     items: _controller.allBrands.map((NewBrandModel brand) {
//                       return DropdownMenuItem<String>(
//                         value: brand.name,
//                         child: Text(brand.name),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       print('Selected brand: $newValue');
//                       if (newValue != null) {
//                         _controller.selectBrandByName(newValue);
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Brands',
//                     ),
//                   );
//                 },
//               )
//
//
// ,
//               Obx(() {
//                 return
//
//                   DropdownButtonFormField<String>(
//                     value: _controller.selectedBrand.value?.name ?? '', // Ensure it's not null
//                     items: _controller.allBrands.map((NewBrandModel brand) {
//                       return DropdownMenuItem<String>(
//                         value: brand.name,
//                         child: Text(brand.name),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       if (newValue != null) {
//                         _controller.selectBrandByName(newValue);
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Brands',
//                     ),
//                   );
//
//               }),
//
//               ElevatedButton(
//                 onPressed: _controller.addProduct,
//                 child: const Text('Add Product'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
