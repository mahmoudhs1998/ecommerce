import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;
import 'package:get/get.dart';

import 'new_controller.dart';


class ImageDisplay extends StatelessWidget {
  final dynamic imageData;

  const ImageDisplay({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageData == null) {
      return Icon(Icons.camera_alt);
    }

    if (kIsWeb) {
      if (imageData is Uint8List) {
        return Image.memory(imageData);
      }
    } else {
      if (imageData is File) {
        return Image.file(imageData);
      }
    }

    return Icon(Icons.error); // Icon(Icons.camera_alt);
  }
}











///######################################################

class ImagePickerWidget extends StatelessWidget {
  final NewAdminPanelController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Thumbnail Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Obx(() {
            return GestureDetector(
              onTap: () async {
                await controller.selectThumbnailImageurl();
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: controller.thumbnailImage.value != null
                    ? Image.memory(controller.thumbnailImage.value!, fit: BoxFit.cover)
                    : Icon(Icons.add_a_photo, color: Colors.grey),
              ),
            );
          }),
          SizedBox(height: 16),
          Text('Product Images', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Obx(() {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...controller.productImages.entries.map((entry) {
                  return Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.memory(entry.value, fit: BoxFit.cover),
                      ),
                      Positioned(
                        right: 4,
                        top: 4,
                        child: GestureDetector(
                          onTap: () {
                            controller.productImages.remove(entry.key);
                          },
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.red,
                            child: Icon(Icons.close, color: Colors.white, size: 16),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
                GestureDetector(
                  onTap: () async {
                    await controller.selectProductImages();
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.add_a_photo, color: Colors.grey),
                  ),
                ),
              ],
            );
          }),

        ],
      ),
    );
  }
}

///######################################################


class ImagePickerWidgets extends StatelessWidget {
  final NewAdminPanelController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Thumbnail Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Obx(() {
            return ProductImageCard(
              labelText: 'Thumbnail',
              imageFile: controller.thumbnailImage.value != null
                  ? File.fromRawPath(controller.thumbnailImage.value!)
                  : null,
              imageUint8List: controller.thumbnailImage.value,
              onTap: () async {
                await controller.selectThumbnailImageurl();
              },
              onRemoveImage: controller.thumbnailImage.value != null
                  ? () {
                controller.thumbnailImage.value = null;
              }
                  : null,
            );
          }),
          SizedBox(height: 16),
          Text('Product Images', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Obx(() {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...controller.productImages.entries.map((entry) {
                  return ProductImageCard(
                    labelText: 'Product Image',
                    imageFile: File.fromRawPath(entry.value),
                    imageUint8List: entry.value,
                    onTap: () {
                      // Handle tap on existing product image if needed
                    },
                    onRemoveImage: () {
                      controller.productImages.remove(entry.key);
                    },
                  );
                }).toList(),
                ProductImageCard(
                  labelText: 'Add Product Image',
                  onTap: () async {
                    await controller.selectProductImages();
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class ProductImageCard extends StatelessWidget {
  final String labelText;
  final String? imageUrlForUpdateImage;
  final File? imageFile;
  final Uint8List? imageUint8List;
  final VoidCallback onTap;
  final VoidCallback? onRemoveImage;

  const ProductImageCard({
    Key? key,
    required this.labelText,
    this.imageFile,
    this.imageUint8List,
    required this.onTap,
    this.imageUrlForUpdateImage,
    this.onRemoveImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Card(
          child: Container(
            height: 130,
            width: size.width * 0.12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (imageUint8List != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        imageUint8List!,
                        width: double.infinity,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    )
                  else if (imageFile != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? Image.network(
                        imageFile?.path ?? '',
                        width: double.infinity,
                        height: 80,
                        fit: BoxFit.cover,
                      )
                          : Image.file(
                        imageFile!,
                        width: double.infinity,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    )
                  else if (imageUrlForUpdateImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrlForUpdateImage ?? '',
                          width: double.infinity,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Icon(Icons.camera_alt, size: 50, color: Colors.grey[600]),
                  SizedBox(height: 8),
                  Text(
                    textAlign: TextAlign.center,
                    labelText,

                    style: TextStyle(

                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if ((imageUint8List != null || imageFile != null) && onRemoveImage != null)
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: onRemoveImage,
            ),
          ),
      ],
    );
  }
}
