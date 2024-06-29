import 'dart:io';

// class AdminCategoryScreen extends StatelessWidget {
//   AdminCategoryScreen({super.key});

//   final controller = Get.put(AdminCategoryController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Category')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: controller.nameController,
//               decoration: const InputDecoration(labelText: 'Category Name'),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: controller.imageController,
//               decoration: const InputDecoration(labelText: 'Image URL'),
//             ),
//             const SizedBox(height: 16),
//             Obx(() => CheckboxListTile(
//                   title: const Text('Featured'),
//                   value: controller.isFeaturedController.value,
//                   onChanged: (value) =>
//                       controller.isFeaturedController.value = value!,
//                 )),
//             const SizedBox(height: 16),
//             TextField(
//               controller: controller.parentIdController,
//               decoration:
//                   const InputDecoration(labelText: 'Parent ID (Optional)'),
//             ),
//             const SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: controller.addCategory,
//               child: const Text('Add Category'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart'; // Import the foundation library
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/admin_category_controller.dart';

class AdminCategoryScreen extends StatelessWidget {
  AdminCategoryScreen({Key? key}) : super(key: key);

  final controller = Get.put(AdminCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Category')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller.nameController,
                decoration: const InputDecoration(labelText: 'Category Name'),
              ),
              const SizedBox(height: 16),
              Obx(() {
                if (controller.selectedImage.value == null) {
                  return ElevatedButton(
                    onPressed: controller.pickImage,
                    child: const Text('Pick Image'),
                  );
                } else {
                  return kIsWeb
                      ? CachedNetworkImage(
                          imageUrl: controller.selectedImage.value!.path,
                          placeholder: (context, url) =>
                              // ignore: prefer_const_constructors
                              Center(child: const CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : Image.file(File(controller.selectedImage.value!.path));
                }
              }),
              const SizedBox(height: 16),
              Obx(() => CheckboxListTile(
                    title: const Text('Featured'),
                    value: controller.isFeaturedController.value,
                    onChanged: (value) =>
                        controller.isFeaturedController.value = value!,
                  )),
              const SizedBox(height: 16),
              TextField(
                controller: controller.parentIdController,
                decoration:
                    const InputDecoration(labelText: 'Parent ID (Optional)'),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: controller.addCategory,
                child: const Text('Add Category'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
