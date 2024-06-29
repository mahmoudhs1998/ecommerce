import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/admin_brand_controller.dart';

class AdminBrandScreen extends StatelessWidget {
  final AdminBrandController _controller = Get.put(AdminBrandController());

  AdminBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Brand'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller.nameController,
              decoration: InputDecoration(
                labelText: 'Brand Name',
                errorText: _controller.nameError.value.isNotEmpty
                    ? _controller.nameError.value
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              return _controller.imageUrl.value.isEmpty
                  ? IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: _controller.pickImage,
                    )
                  : Image.network(_controller.imageUrl.value);
            }),
            const SizedBox(height: 16),
            Obx(() {
              return SwitchListTile(
                title: const Text('Is Featured'),
                value: _controller.isFeatured.value,
                onChanged: (value) {
                  _controller.isFeatured.value = value;
                },
              );
            }),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _controller.addBrand,
              child: const Text('Add Brand'),
            ),
          ],
        ),
      ),
    );
  }
}
