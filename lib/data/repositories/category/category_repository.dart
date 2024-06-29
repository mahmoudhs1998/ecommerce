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
   } on FormatException catch (_) {
     throw TFormatException();
   } on PlatformException catch (e) {
     throw TPlatformException(e.code).message;
   }catch(e) {
     throw 'Something went wrong , please try again';
   }
 }
///   Get Sub categories
  Future<List<CategoryModel>> getSubCategories(String categoryId)async{
    try{
      final snapshot = await _db.collection("Categories").where('ParentId', isEqualTo: categoryId).get();
      final result = snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }catch(e) {
      throw 'Something went wrong , please try again';
    }
  }
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
   } on FormatException catch (_) {
     throw TFormatException();
   } on PlatformException catch (e) {
     throw TPlatformException(e.code).message;
   }catch(e) {
     throw 'Something went wrong , please try again';
   }
}
///   Upload  categories to the Cloud FireStore


  // Future<void> addCategory(CategoryModel category) async {
  //   try {
  //     // Generate a new document reference with an auto-generated ID
  //     final docRef = _db.collection('Categories').doc();
      
  //     // Create a new CategoryModel with the auto-generated ID
  //     final newCategory = CategoryModel(
  //       id: docRef.id,
  //       name: category.name,
  //       image: category.image,
  //       isFeatured: category.isFeatured,
  //       parentId: category.parentId,
  //     );

  //     // Set the document data with the new category
  //     await docRef.set(newCategory.toJson());
  //   } catch (e) {
  //     print('Error adding category: $e');
  //     throw e;
  //   }
  // }

  Future<String> getNextCategoryId() async {
    try {
      final querySnapshot = await _db.collection('Categories')
          .orderBy('Id', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final lastId = int.parse(querySnapshot.docs.first['Id']);
        return (lastId + 1).toString();
      } else {
        return '1';
      }
    } catch (e) {
      print('Error getting next category ID: $e');
      throw e;
    }
  }

  Future<void> addCategory(CategoryModel category) async {
    try {
      final nextId = await getNextCategoryId();
      final newCategory = CategoryModel(
        id: nextId,
        name: category.name,
        image: category.image,
        isFeatured: category.isFeatured,
        parentId: category.parentId,
      );

      await _db.collection('Categories').doc(nextId).set(newCategory.toJson());
    } catch (e) {
      print('Error adding category: $e');
      throw e;
    }
  }


  Future<void> updateCategory(String id, CategoryModel category) async {
    try {
      await _db.collection('Categories').doc(id).update(category.toJson());
    } catch (e) {
      print('Error updating category: $e');
      throw e;
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _db.collection('Categories').doc(categoryId).delete();
    } catch (e) {
      print('Error deleting category: $e');
      throw e;
    }
  }

}