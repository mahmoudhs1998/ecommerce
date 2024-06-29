

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
//               // Dynamic fields for ProductAttributeModel
//               Obx(() => Column(
//                     children: [
//                       for (var attribute in controller.productAttributes)
//                         ListTile(
//                           title: Text(
//                               '${attribute.name}: ${attribute.values!.join(', ')}'),
//                           trailing: IconButton(
//                             icon: Icon(Icons.delete),
//                             onPressed: () =>
//                                 controller.removeAttribute(attribute),
//                           ),
//                         ),
//                       TextButton(
//                         onPressed: controller.addAttributeField,
//                         child: Text('Add Attribute'),
//                       ),
//                     ],
//                   )),
//               // Dynamic fields for ProductVariationModel
//               Obx(() => Column(
//                     children: [
//                       for (var variation in controller.productVariations)
//                         ListTile(
//                           title: Text(
//                               '${variation.id}: ${variation.attributeValues}'),
//                           trailing: IconButton(
//                             icon: Icon(Icons.delete),
//                             onPressed: () =>
//                                 controller.removeVariation(variation),
//                           ),
//                         ),
//                       TextButton(
//                         onPressed: controller.addVariationField,
//                         child: Text('Add Variation'),
//                       ),
//                     ],
//                   )),
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

class AdminPanelPage extends StatelessWidget {
  final AdminPanelController _controller = Get.put(AdminPanelController());

   AdminPanelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _controller.titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _controller.stockController,
                decoration: const InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _controller.skuController,
                decoration: const InputDecoration(labelText: 'SKU'),
              ),
              TextField(
                controller: _controller.priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _controller.salePriceController,
                decoration: const InputDecoration(labelText: 'Sale Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _controller.thumbnailController,
                decoration: const InputDecoration(labelText: 'Thumbnail URL'),
              ),
              TextField(
                controller: _controller.productTypeController,
                decoration: const InputDecoration(labelText: 'Product Type'),
              ),
              TextField(
                controller: _controller.descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _controller.categoryIdController,
                decoration: const InputDecoration(labelText: 'Category ID'),
              ),
              TextField(
                controller: _controller.imagesController,
                decoration:
                    const InputDecoration(labelText: 'Images (comma separated)'),
              ),
              TextField(
                controller: _controller.brandIdController,
                decoration: const InputDecoration(labelText: 'Brand ID'),
              ),
              TextField(
                controller: _controller.brandImageController,
                decoration: const InputDecoration(labelText: 'Brand Image URL'),
              ),
              TextField(
                controller: _controller.brandNameController,
                decoration: const InputDecoration(labelText: 'Brand Name'),
              ),
              TextField(
                controller: _controller.brandProductsCountController,
                decoration: const InputDecoration(labelText: 'Brand Products Count'),
                keyboardType: TextInputType.number,
              ),
              Obx(() => SwitchListTile(
                    title: const Text('Is Featured'),
                    value: _controller.isFeatured.value,
                    onChanged: (value) {
                      _controller.isFeatured.value = value;
                    },
                  )),
              Obx(() => SwitchListTile(
                    title: const Text('Brand Is Featured'),
                    value: _controller.brandIsFeatured.value,
                    onChanged: (value) {
                      _controller.brandIsFeatured.value = value;
                    },
                  )),
              ElevatedButton(
                onPressed: () {
                  Get.dialog(AddAttributeDialog(onSubmit: (attribute) {
                    _controller.productAttributes.add(attribute);
                  }));
                },
                child: const Text('Add Attribute'),
              ),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    itemCount: _controller.productAttributes.length,
                    itemBuilder: (context, index) {
                      final attribute = _controller.productAttributes[index];
                      return ListTile(
                        title: Text(attribute.name!),
                        subtitle: Text(attribute.values!.join(', ')),
                      );
                    },
                  )),
              ElevatedButton(
                onPressed: () {
                  Get.dialog(AddVariationDialog(onSubmit: (variation) {
                    _controller.productVariations.add(variation);
                  }));
                },
                child: const Text('Add Variation'),
              ),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    itemCount: _controller.productVariations.length,
                    itemBuilder: (context, index) {
                      final variation = _controller.productVariations[index];
                      return ListTile(
                        title: Text(variation.id),
                        subtitle: Text(
                            'Stock: ${variation.stock}, Price: ${variation.price}'),
                      );
                    },
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _controller.addProduct,
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
