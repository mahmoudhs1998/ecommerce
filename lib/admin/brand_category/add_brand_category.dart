import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/admin_add_brand_category.dart';

class AddBrandCategoryPage extends StatelessWidget {
  final BrandCategoryController _controller = Get.put(BrandCategoryController());

   AddBrandCategoryPage({super.key});

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
              controller: _controller.brandIdController,
              decoration: InputDecoration(
                labelText: 'Brand ID',
                errorText: _controller.brandIdError.value.isEmpty ? null : _controller.brandIdError.value,
              ),
            ),
            TextField(
              controller: _controller.categoryIdController,
              decoration: InputDecoration(
                labelText: 'Category ID',
                errorText: _controller.categoryIdError.value.isEmpty ? null : _controller.categoryIdError.value,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _controller.addBrandCategory();
              },
              child: const Text('Add Brand Category'),
            ),
          ],
        ),
      ),
    );
  }
}
