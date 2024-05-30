import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class TFirebaseStorageServices extends GetxController
{
  static TFirebaseStorageServices get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  // -- Upload `w.. ` Assets From IDE
// -- Returns a Unit8List Containing Images Data
Future<Uint8List> getImageDataFromAssets(String path) async{
  try{
    final byteData = await rootBundle.load(path);
    final imageData = byteData.buffer.asUint8List(byteData.offsetInBytes ,byteData.lengthInBytes );
    return imageData;
  }catch(e){
    throw 'Error loading image data';
  }

}

// -- upload image using ImageData on Cloud Firebase Storage
// - -returns the downloaded url of the uploaded image
Future<String> uploadImageData(String path, Uint8List image , String name) async{
  try{
    final ref = _firebaseStorage.ref(path).child(name);
    await ref.putData(image);
    final url = await ref.getDownloadURL();
    return url;
  }catch(e){
    // handle exceptions
    if(e is FirebaseException){
      throw 'Firebase exception ${e.message}';
    }else if (e is SocketException){
      throw 'Network Error ${e.message}';
    }else if (e is PlatformException){
      throw 'PlatForm Exception ${e.message}';
    }else{
      throw 'Something went wrong!, please try again.';
    }
  }
}

// -- upload image using ImageData on Cloud Firebase Storage
// - -returns the downloaded url of the uploaded image
Future<String> uploadImageFile (String path, XFile image)async{
  try{
    final ref = _firebaseStorage.ref(path).child(image.name);
   await ref.putFile(File(image.path));
    final url = await ref.getDownloadURL();
    return url;
  }catch(e){
    // handle exceptions
    if(e is FirebaseException){
      throw 'Firebase exception ${e.message}';
    }else if (e is SocketException){
      throw 'Network Error ${e.message}';
    }else if (e is PlatformException){
      throw 'PlatForm Exception ${e.message}';
    }else{
      throw 'Something went wrong!, please try again.';
    }
  }
}

}