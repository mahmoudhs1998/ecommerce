import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/exceptions/exceptions.dart';
import '../../../../features/authentication/models/user_model.dart';

/// Repository class for User - Related Operations

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// function to save user data to firestore
  Future<void> saveUserRecord(UserModel user)async {
    try{
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }on FormatException catch (e) {
      throw TFormatException();
    }on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong , please try again';
    }
  }
}
