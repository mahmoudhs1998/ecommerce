// import 'dart:io';
//
// import 'package:ecommerce/features/shop/models/brand_model.dart';
// import 'package:ecommerce/features/shop/models/category_model.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'logic.dart';
//
//
// class AdminPanelPage extends StatelessWidget {
//   final AdminPanelController _controller = Get.put(AdminPanelController());
//
//   AdminPanelPage({Key? key}) : super(key: key);
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
//             crossAxisAlignment: CrossAxisAlignment.start,
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
//               // Thumbnail Image
//               Obx(() {
//                 if (_controller.selectedThumbnailImage.value == null) {
//                   return ElevatedButton(
//                     onPressed: _controller.pickImage,
//                     child: const Text('Pick Thumbnail'),
//                   );
//                 } else {
//                   return kIsWeb
//                       ? Image.network(
//                       _controller.selectedThumbnailImage.value!.path)
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
//               // Category Dropdown
//               Obx(() => DropdownButtonFormField<String>(
//                 value: _controller.selectedCategory.value.toString(),
//                 onChanged: (newValue) {
//                   _controller.selectedCategory.value = newValue! as CategoryModel?;
//                 },
//                 items: _controller.categories.map((category) {
//                   return DropdownMenuItem<String>(
//                     value: category.id,
//                     child: Text(category.name),
//                   );
//                 }).toList(),
//                 decoration:
//                 const InputDecoration(labelText: 'Select Category'),
//               )),
//               // Subcategory Dropdown
//               Obx(() => DropdownButtonFormField<String>(
//                 value: _controller.selectedSubCategory.value!.name,
//                 onChanged: (newValue) {
//                   _controller.selectedSubCategory.value = newValue! as SubCategoryModel?;
//                 },
//                 items: _controller.subcategories.map((subcategory) {
//                   return DropdownMenuItem<String>(
//                     value: subcategory.id,
//                     child: Text(subcategory.name),
//                   );
//                 }).toList(),
//                 decoration: const InputDecoration(
//                     labelText: 'Select Subcategory'),
//               )),
//               // Brand Dropdown
//               Obx(() => DropdownButtonFormField<String>(
//                 value: _controller.selectedBrand.value!.name,
//                 onChanged: (newValue) {
//                   _controller.selectedBrand.value = newValue! as BrandModel?;
//                 },
//                 items: _controller.brands.map((brand) {
//                   return DropdownMenuItem<String>(
//                     value: brand.id,
//                     child: Text(brand.name),
//                   );
//                 }).toList(),
//                 decoration: const InputDecoration(labelText: 'Select Brand'),
//               )),
//               // Selected Images
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
//                               ? Image.network(image!.path)
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
//               // Uploaded Image URLs
//               Obx(() {
//                 return Wrap(
//                   spacing: 8.0,
//                   runSpacing: 8.0,
//                   children: _controller.uploadedImageUrls.map((imageUrl) {
//                     return kIsWeb
//                         ? Image.network(imageUrl)
//                         : Image.network(imageUrl);
//                   }).toList(),
//                 );
//               }),
//               TextField(
//                 controller: _controller.brandIdController,
//                 decoration: const InputDecoration(labelText: 'Brand ID'),
//               ),
//               TextField(
//                 controller: _controller.brandImageController,
//                 decoration: const InputDecoration(labelText: 'Brand Image URL'),
//               ),
//               TextField(
//                 controller: _controller.brandNameController,
//                 decoration: const InputDecoration(labelText: 'Brand Name'),
//               ),
//               TextField(
//                 controller: _controller.brandProductsCountController,
//                 decoration:
//                 const InputDecoration(labelText: 'Brand Products Count'),
//                 keyboardType: TextInputType.number,
//               ),
//               Obx(() => SwitchListTile(
//                 title: const Text('Is Featured'),
//                 value: _controller.isFeatured.value,
//                 onChanged: (value) {
//                   _controller.isFeatured.value = value;
//                 },
//               )),
//               Obx(() => SwitchListTile(
//                 title: const Text('Brand Is Featured'),
//                 value: _controller.brandIsFeatured.value,
//                 onChanged: (value) {
//                   _controller.brandIsFeatured.value = value;
//                 },
//               )),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.dialog(AddAttributeDialog(onSubmit: (attribute) {
//                     _controller.productAttributes.add(attribute);
//                   }));
//                 },
//                 child: const Text('Add Attribute'),
//               ),
//               // Product Attributes List
//               Obx(() => ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: _controller.productAttributes.length,
//                 itemBuilder: (context, index) {
//                   final attribute = _controller.productAttributes[index];
//                   return ListTile(
//                     title: Text(attribute.name!),
//                     subtitle: Text(attribute.values!.join(', ')),
//                   );
//                 },
//               )),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.dialog(AddVariationDialog(onSubmit: (variation) {
//                     _controller.productVariations.add(variation);
//                   }));
//                 },
//                 child: const Text('Add Variation'),
//               ),
//               // Product Variations List
//               Obx(() => ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: _controller.productVariations.length,
//                 itemBuilder: (context, index) {
//                   final variation = _controller.productVariations[index];
//                   return ListTile(
//                     title: Text(variation.id),
//                     subtitle: Text(
//                         'Stock: ${variation.stock}, Price: ${variation.price}'),
//                   );
//                 },
//               )),
//               const SizedBox(height: 20),
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
