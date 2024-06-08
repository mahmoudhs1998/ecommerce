import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common/widgets/exceptions/exceptions.dart';

class BrandRepository extends GetxController
{
  static BrandRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

/// Get all Brands
  Future<List<BrandModel>> getAllBrands() async{
    try{
      final querySnapshot = await _db.collection('Brands').get();
      final result =  querySnapshot.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
      return result;
    }on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Something went wrong , please try again';
    }
  }

/// Get Brands For Category
}