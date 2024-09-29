import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });


  /// Empty Helper Function
  static CategoryModel empty() =>
      CategoryModel(id: '', image: '', name: '', isFeatured: false);

/// Convert model to Json structure so that you can store data in Firebase
Map<String , dynamic> toJson(){
  return {
    'Id': id,
    'Name': name,
    'Image': image,
    'IsFeatured': isFeatured,
    'ParentId': parentId,
  };
}

/// Mop Json oriented document snapshot from Firebase to UserModel
factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
  if(document.data() != null){
    final data = document.data()!;
    // Map json Record to the Model
    return CategoryModel(
        id: document.id,
        name: data['Name']??'',
        image: data['Image']??'',
        parentId: data['ParentId']??'',
        isFeatured: data['IsFeatured']??false
    );
  }else{
    return CategoryModel.empty();
  }

}



}



// class SubCategoryModel {
//   String id;
//   String name;
//   String parentId;
//   String image;
//   bool isFeatured;
//
//   SubCategoryModel({
//     required this.id,
//     required this.name,
//     required this.parentId,
//     required this.image,
//     this.isFeatured = false,
//   });
//
//   factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
//     return SubCategoryModel(
//       id: map['Id'],
//       name: map['Name'],
//       parentId: map['ParentId'],
//       image: map['Image'],
//       isFeatured: map['IsFeatured'] ?? false,
//     );
//   }
//
//   factory SubCategoryModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
//     if(document.data() != null){
//       final data = document.data()!;
//       // Map json Record to the Model
//       return SubCategoryModel(
//           id: document.id,
//           name: data['Name']??'',
//           image: data['Image']??'',
//           parentId: data['ParentId']??'',
//           isFeatured: data['IsFeatured']??false
//       );
//     }else{
//       return SubCategoryModel.empty();
//     }
//
//   }
//
//   /// Empty Helper Function
//   static SubCategoryModel empty() =>
//       SubCategoryModel(id: '', image: '', name: '', isFeatured: false, parentId: '');
//
// }
