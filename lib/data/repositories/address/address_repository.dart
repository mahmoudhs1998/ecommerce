import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/address_model.dart';

class AddressRepository extends GetxController
{
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId =  AuthenticationRepository.instance.currentAuthUser!.uid;
      if(userId.isEmpty) throw 'Unable to find user information. try again in few minutes';

      final result = await _db.collection('Users').doc(userId).collection('Addresses').get();
      return result.docs.map((documentSnapshot) => AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();
    }catch(e) {
      throw 'Something went wrong while fetching Address information. try again later';
    }
  }

  /// Clear the Selected field for all addresses
  Future<void> updateSelectedField(String addressId , bool selected) async {
    try {
      final userId =  AuthenticationRepository.instance.currentAuthUser!.uid;
      if(userId.isEmpty) throw 'Unable to find user information. try again in few minutes';

      await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).update({'SelectedAddress': selected});
    }catch(e) {
      throw 'Something went wrong while updating Selected field. try again later';
    }
  }

   Future<String> addAddress (AddressModel address ) async{
     try {
       final userId =  AuthenticationRepository.instance.currentAuthUser!.uid;
       if(userId.isEmpty) throw 'Unable to find user information. try again in few minutes';

       final currentAddress = await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
       return currentAddress.id;
     }catch(e) {
       throw 'Something went wrong while adding Address. try again later';
     }
   }
}