import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/services/firebase/firebase_storage_services.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common/widgets/exceptions/exceptions.dart';

class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
 ///  Get All categories
 Future<List<CategoryModel>> getAllCategories()async {
   try {
     final snapshot = await _db.collection('Categories').get();
     final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList() ;
     return list;
   } on FirebaseException catch (e) {
     throw TFirebaseException(e.code).message;
   } on FormatException catch (e) {
     throw TFormatException();
   } on PlatformException catch (e) {
     throw TPlatformException(e.code).message;
   }catch(e) {
     throw 'Something went wrong , please try again';
   }
 }
///   Get Sub categories
// upload categories to the cloud fire store
Future<void> uploadDummyData(List<CategoryModel> categories)async{
   try{
     // upload all the categories along with their Images
     final storage = Get.put(TFirebaseStorageServices());
     // Loop through each category
     for(var category in categories){
       // get image data from the local assets
       final file = await storage.getImageDataFromAssets(category.image);

       // upload the image and get its url
       final url = await storage.uploadImageData('Categories', file, category.name);

       // Assign the url to the category.image Attribute
       category.image = url;

       // Store category to the cloud fire store
       await _db.collection('Categories').doc(category.id).set(category.toJson());
     }

   } on FirebaseException catch (e) {
     throw TFirebaseException(e.code).message;
   } on FormatException catch (e) {
     throw TFormatException();
   } on PlatformException catch (e) {
     throw TPlatformException(e.code).message;
   }catch(e) {
     throw 'Something went wrong , please try again';
   }
}
///   Upload  categories to the Cloud FireStore
}