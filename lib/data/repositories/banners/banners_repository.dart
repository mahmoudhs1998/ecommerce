import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/shop/models/banner_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common/widgets/exceptions/exceptions.dart';

class BannersRepository extends GetxController{
  static BannersRepository get instance => Get.find();

  // variables
 final _db = FirebaseFirestore.instance;

 // Get all orders related to the Current user
Future<List<BannerModel>> fetchBanners() async{
  try{
    final result = await _db.collection('Banners').where('active',isEqualTo:true).get();
    return result.docs.map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot)).toList();
  }on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on FormatException catch (e) {
    throw TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  }catch(e) {
    throw 'Something went wrong , please try again';
  }
}

// upload Banners to the Cloud Firestore
}