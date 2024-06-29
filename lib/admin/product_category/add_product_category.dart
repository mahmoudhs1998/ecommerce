import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/admin_add_product_category.dart';

class AddProductCategoryPage extends StatelessWidget {
  final ProductCategoryController _controller =
      Get.put(ProductCategoryController());

  AddProductCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Brand Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller.productIdController,
              decoration: InputDecoration(
                hintText: '001',
                labelText: 'Product ID',
                errorText: _controller.categoryIdError.value.isEmpty
                    ? null
                    : _controller.productIdError.value,
              ),
            ),
            TextField(
              controller: _controller.categoryIdController,
              decoration: InputDecoration(
                labelText: 'Category ID',
                errorText: _controller.categoryIdError.value.isEmpty
                    ? null
                    : _controller.categoryIdError.value,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _controller.addProductCategory();
              },
              child: const Text('Add Product Category'),
            ),
          ],
        ),
      ),
    );
  }
}
