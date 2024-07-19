import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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