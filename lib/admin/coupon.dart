import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/shop/screens/checkout/checkout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repositories/authentication/authentication_repository.dart';
import '../features/shop/controllers/cart/cart_controller.dart';
import '../utils/helpers/pricing_calculator.dart';


/// controller
// class UserCouponControllers extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final RxList<UserCouponModel> availableCoupons = <UserCouponModel>[].obs;
//   final Rx<UserCouponModel?> appliedCoupon = Rx<UserCouponModel?>(null);
//   final RxDouble totalAmount = 0.0.obs;
//   final RxDouble discountedAmount = 0.0.obs;
//
//   void setTotalAmount(double amount) {
//     totalAmount.value = amount;
//     calculateDiscountedAmount();
//   }
//
//   void calculateDiscountedAmount() {
//     if (appliedCoupon.value != null) {
//       final discount = calculateDiscount(appliedCoupon.value!);
//       discountedAmount.value = totalAmount.value - discount;
//     } else {
//       discountedAmount.value = totalAmount.value;
//     }
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchCouponsWithoutIndex();
//     setTotalAmount(CartController.instance.totalCartPrice.value);
//   }
//
//   Future<void> fetchCouponsWithoutIndex() async {
//     try {
//       final snapshot = await FirebaseFirestore.instance.collection('Coupons').get();
//       final allCoupons = snapshot.docs.map((doc) => UserCouponModel.fromDocumentSnapshot(doc)).toList();
//       final now = DateTime.now();
//
//       final filteredCoupons = allCoupons.where((coupon) =>
//       coupon.status == 'active' &&
//           coupon.expiryDate != null &&
//           coupon.expiryDate!.isAfter(now)).toList();
//
//       availableCoupons.assignAll(filteredCoupons);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch coupons: $e',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }
//
//   Future<void> applyCoupon(String couponCode, String currentProductId) async {
//     try {
//       await fetchCouponsWithoutIndex();
//
//       final coupon = availableCoupons.firstWhere((c) => c.code == couponCode, orElse: () => UserCouponModel.empty());
//
//       if (coupon.id!.isEmpty) {
//         Get.snackbar('Error', 'Coupon not found',
//             backgroundColor: Colors.red, colorText: Colors.white);
//         return;
//       }
//
//       print('Coupon Details: ${coupon.toJson()}');
//       print('Current Product ID: $currentProductId');
//
//       if (validateCoupon(coupon, currentProductId)) {
//         appliedCoupon.value = coupon;
//         final discount = calculateDiscount(coupon);
//         discountedAmount.value = totalAmount.value - discount;
//         incrementUsageCount(coupon.id!);
//         Get.snackbar('Success', 'Coupon applied successfully',
//             backgroundColor: Colors.green, colorText: Colors.white);
//       }
//     } catch (error) {
//       Get.snackbar('Error', 'An unexpected error occurred: $error',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }
//
//   bool validateCoupon(UserCouponModel coupon, String currentProductId) {
//     final now = DateTime.now();
//     final isValid = coupon.expiryDate != null &&
//         coupon.expiryDate!.isAfter(now) &&
//         coupon.status == 'active' &&
//         totalAmount.value >= (coupon.minimumPurchaseAmount ?? 0);
//
//     if (!isValid) {
//       Get.snackbar('Error', 'Coupon is invalid or expired',
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return false;
//     }
//
//     final appliesToProduct = coupon.applicableProductId == null || coupon.applicableProductId == currentProductId;
//
//     if (!appliesToProduct) {
//       Get.snackbar('Error', 'Coupon does not apply to this product',
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return false;
//     }
//
//     return true;
//   }
//
//   double calculateDiscount(UserCouponModel coupon) {
//     double discount = 0.0;
//
//     if (coupon.discountType == 'percentage') {
//       discount = totalAmount.value * (coupon.discountAmount ?? 0) / 100;
//     } else if (coupon.discountType == 'fixed') {
//       discount = coupon.discountAmount ?? 0;
//     }
//
//     return discount > totalAmount.value ? totalAmount.value : discount;
//   }
//   Future<void> incrementUsageCount(String couponId) async {
//     try {
//       final couponRef = _firestore.collection('Coupons').doc(couponId);
//       await _firestore.runTransaction((transaction) async {
//         final snapshot = await transaction.get(couponRef);
//         if (snapshot.exists) {
//           final usageCount = (snapshot.data() as Map<String, dynamic>)['usageCount'] ?? 0;
//           transaction.update(couponRef, {'usageCount': usageCount + 1});
//         }
//       });
//     } catch (error) {
//       Get.snackbar('Error', 'Failed to update coupon usage: $error',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }
//   void removeCoupon() {
//     appliedCoupon.value = null;
//     discountedAmount.value = totalAmount.value;
//     Get.snackbar('Success', 'Coupon removed',
//         backgroundColor: Colors.green, colorText: Colors.white);
//   }
// }




// old is prefect
// class UserCouponControllers extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final RxList<UserCouponModel> availableCoupons = <UserCouponModel>[].obs;
//   final Rx<UserCouponModel?> appliedCoupon = Rx<UserCouponModel?>(null);
//   final RxDouble totalAmount = 0.0.obs;
//   final RxDouble discountedAmount = 0.0.obs;
//
//   final AuthenticationRepository _authRepo = AuthenticationRepository.instance;
//
//   @override
//   void onInit() {
//     super.onInit();
//     setTotalAmount(CartController.instance.totalCartPrice.value);
//     fetchCouponsForCurrentUser();
//   }
//
//   void setTotalAmount(double amount) {
//     totalAmount.value = amount;
//     calculateDiscountedAmount();
//   }
//
//   void calculateDiscountedAmount() {
//     if (appliedCoupon.value != null) {
//       final discount = calculateDiscount(appliedCoupon.value!);
//       discountedAmount.value = totalAmount.value - discount;
//     } else {
//       discountedAmount.value = totalAmount.value;
//     }
//   }
//
//   Future<void> fetchCouponsForCurrentUser() async {
//     try {
//       final user = _authRepo.currentAuthUser;
//       if (user == null) {
//         throw 'User not logged in';
//       }
//
//       // Fetch user-specific coupons
//       final userCouponsSnapshot = await _firestore
//           .collection('Users')
//           .doc(user.uid)
//           .collection('Coupons')
//           .get();
//
//       // Fetch global coupons
//       final globalCouponsSnapshot = await _firestore
//           .collection('Coupons')
//           .get();
//
//       final allCoupons = [
//         ...userCouponsSnapshot.docs,
//         ...globalCouponsSnapshot.docs,
//       ].map((doc) => UserCouponModel.fromDocumentSnapshot(doc)).toList();
//
//       final now = DateTime.now();
//
//       final filteredCoupons = allCoupons.where((coupon) =>
//       coupon.status == 'active' &&
//           coupon.expiryDate != null &&
//           coupon.expiryDate!.isAfter(now)).toList();
//
//       availableCoupons.assignAll(filteredCoupons);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch coupons: $e',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }
//
//   Future<void> applyCoupon(String couponCode, String currentProductId) async {
//     try {
//       final user = _authRepo.currentAuthUser;
//       if (user == null) {
//         throw 'User not logged in';
//       }
//
//       await fetchCouponsForCurrentUser();
//
//       final coupon = availableCoupons.firstWhere(
//             (c) => c.code == couponCode,
//         orElse: () => throw 'Coupon not found',
//       );
//
//       if (await validateCoupon(coupon, currentProductId)) {
//         appliedCoupon.value = coupon;
//         final discount = calculateDiscount(coupon);
//         discountedAmount.value = totalAmount.value - discount;
//         await markCouponAsUsed(coupon);
//         await incrementUsageCount(coupon.id!);
//         Get.snackbar('Success', 'Coupon applied successfully',
//             backgroundColor: Colors.green, colorText: Colors.white);
//       }
//     } catch (error) {
//       Get.snackbar('Error', error.toString(),
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }
//
//   Future<void> markCouponAsUsed(UserCouponModel coupon) async {
//     final user = _authRepo.currentAuthUser;
//     if (user == null) return;
//
//     try {
//       final usedCouponRef = _firestore
//           .collection('Users')
//           .doc(user.uid)
//           .collection('UsedCoupons')
//           .doc(coupon.id);
//
//       await usedCouponRef.set({
//         ...coupon.toJson(),
//         'usedAt': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       print('Error marking coupon as used: $e');
//       throw 'Failed to mark coupon as used';
//     }
//   }
//
//   Future<bool> validateCoupon(UserCouponModel coupon, String currentProductId) async {
//     final now = DateTime.now();
//     final isValid = coupon.expiryDate != null &&
//         coupon.expiryDate!.isAfter(now) &&
//         coupon.status == 'active' &&
//         totalAmount.value >= (coupon.minimumPurchaseAmount ?? 0);
//
//     if (!isValid) {
//       throw 'Coupon is invalid or expired';
//     }
//
//     final appliesToProduct = coupon.applicableProductId == null || coupon.applicableProductId == currentProductId;
//
//     if (!appliesToProduct) {
//       throw 'Coupon does not apply to this product';
//     }
//
//     // Check if the coupon has already been used by the current user
//     final user = _authRepo.currentAuthUser;
//     if (user != null) {
//       final usedCouponRef = await _firestore
//           .collection('Users')
//           .doc(user.uid)
//           .collection('UsedCoupons')
//           .doc(coupon.id)
//           .get();
//
//       if (usedCouponRef.exists) {
//         throw 'You have already used this coupon';
//       }
//     }
//
//     return true;
//   }
//
//   double calculateDiscount(UserCouponModel coupon) {
//     double discount = 0.0;
//
//     if (coupon.discountType == 'percentage') {
//       discount = totalAmount.value * (coupon.discountAmount ?? 0) / 100;
//     } else if (coupon.discountType == 'fixed') {
//       discount = coupon.discountAmount ?? 0;
//     }
//
//     return discount > totalAmount.value ? totalAmount.value : discount;
//   }
//
//   Future<void> incrementUsageCount(String couponId) async {
//     try {
//       final couponRef = _firestore.collection('Coupons').doc(couponId);
//       await _firestore.runTransaction((transaction) async {
//         final snapshot = await transaction.get(couponRef);
//         if (snapshot.exists) {
//           final usageCount = (snapshot.data() as Map<String, dynamic>)['usageCount'] ?? 0;
//           transaction.update(couponRef, {'usageCount': usageCount + 1});
//         }
//       });
//     } catch (error) {
//       print('Failed to update coupon usage: $error');
//       throw 'Failed to update coupon usage';
//     }
//   }
//
//   void removeCoupon() {
//     appliedCoupon.value = null;
//     discountedAmount.value = totalAmount.value;
//     Get.snackbar('Success', 'Coupon removed',
//         backgroundColor: Colors.green, colorText: Colors.white);
//   }
// }


class UserCouponControllers extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<UserCouponModel> availableCoupons = <UserCouponModel>[].obs;
  final Rx<UserCouponModel?> appliedCoupon = Rx<UserCouponModel?>(null);
  final RxDouble totalAmount = 0.0.obs;
  final RxDouble discountedAmount = 0.0.obs;

  final AuthenticationRepository _authRepo = AuthenticationRepository.instance;

  @override
  void onInit() {
    super.onInit();
    setTotalAmount(CartController.instance.totalCartPrice.value);
    fetchCouponsForCurrentUser();
  }

  void setTotalAmount(double amount) {
    totalAmount.value = amount;
    calculateDiscountedAmount();
  }

  void calculateDiscountedAmount() {
    if (appliedCoupon.value != null) {
      final discount = TPricingCalculator.calculateDiscount(totalAmount.value, appliedCoupon.value);
      discountedAmount.value = totalAmount.value - discount;
    } else {
      discountedAmount.value = totalAmount.value;
    }
  }

  Future<void> fetchCouponsForCurrentUser() async {
    try {
      final user = _authRepo.currentAuthUser;
      if (user == null) {
        throw 'User not logged in';
      }

      // Fetch user-specific and global coupons
      final userCouponsSnapshot = await _firestore.collection('Users').doc(user.uid).collection('Coupons').get();
      final globalCouponsSnapshot = await _firestore.collection('Coupons').get();

      final allCoupons = [
        ...userCouponsSnapshot.docs,
        ...globalCouponsSnapshot.docs,
      ].map((doc) => UserCouponModel.fromDocumentSnapshot(doc)).toList();

      final now = DateTime.now();
      final filteredCoupons = allCoupons.where((coupon) =>
      coupon.status == 'active' &&
          coupon.expiryDate != null &&
          coupon.expiryDate!.isAfter(now)).toList();

      availableCoupons.assignAll(filteredCoupons);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch coupons: $e', backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> applyCoupon(String couponCode, String currentProductId) async {
    try {
      final user = _authRepo.currentAuthUser;
      if (user == null) {
        throw 'User not logged in';
      }

      await fetchCouponsForCurrentUser();

      final coupon = availableCoupons.firstWhere((c) => c.code == couponCode, orElse: () => throw 'Coupon not found');

      if (await validateCoupon(coupon, currentProductId)) {
        appliedCoupon.value = coupon;
        calculateDiscountedAmount();
        await markCouponAsUsed(coupon);
        await incrementUsageCount(coupon.id!);
        Get.snackbar('Success', 'Coupon applied successfully', backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (error) {
      Get.snackbar('Error', error.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> markCouponAsUsed(UserCouponModel coupon) async {
    final user = _authRepo.currentAuthUser;
    if (user == null) return;

    try {
      final usedCouponRef = _firestore.collection('Users').doc(user.uid).collection('UsedCoupons').doc(coupon.id);
      await usedCouponRef.set({
        ...coupon.toJson(),
        'usedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error marking coupon as used: $e');
      throw 'Failed to mark coupon as used';
    }
  }

  Future<bool> validateCoupon(UserCouponModel coupon, String currentProductId) async {
    final now = DateTime.now();
    final isValid = coupon.expiryDate != null &&
        coupon.expiryDate!.isAfter(now) &&
        coupon.status == 'active' &&
        totalAmount.value >= (coupon.minimumPurchaseAmount ?? 0);

    if (!isValid) {
      throw 'Coupon is invalid or expired';
    }

    final appliesToProduct = coupon.applicableProductId == null || coupon.applicableProductId == currentProductId;

    if (!appliesToProduct) {
      throw 'Coupon does not apply to this product';
    }

    final user = _authRepo.currentAuthUser;
    if (user != null) {
      final usedCouponRef = await _firestore.collection('Users').doc(user.uid).collection('UsedCoupons').doc(coupon.id).get();
      if (usedCouponRef.exists) {
        throw 'You have already used this coupon';
      }
    }

    return true;
  }

  Future<void> incrementUsageCount(String couponId) async {
    try {
      final couponRef = _firestore.collection('Coupons').doc(couponId);
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(couponRef);
        if (snapshot.exists) {
          final usageCount = (snapshot.data() as Map<String, dynamic>)['usageCount'] ?? 0;
          transaction.update(couponRef, {'usageCount': usageCount + 1});
        }
      });
    } catch (error) {
      print('Failed to update coupon usage: $error');
      throw 'Failed to update coupon usage';
    }
  }

  void removeCoupon() {
    appliedCoupon.value = null;
    discountedAmount.value = totalAmount.value;
    Get.snackbar('Success', 'Coupon removed', backgroundColor: Colors.green, colorText: Colors.white);
  }
}






/// model
class UserCouponModel {
  String? id;
  String? code;
  String? discountType;
  double? discountAmount;
  double? minimumPurchaseAmount;
  DateTime? expiryDate;
  String? status;
  String? applicableCategoryId;
  String? applicableSubCategoryId;
  String? applicableProductId; // Single applicable product ID

  UserCouponModel({
    this.id,
    this.code,
    this.discountType,
    this.discountAmount,
    this.minimumPurchaseAmount,
    this.expiryDate,
    this.status,
    this.applicableCategoryId,
    this.applicableSubCategoryId,
    this.applicableProductId,
  });

  factory UserCouponModel.fromJson(Map<String, dynamic> json) {
    return UserCouponModel(
      id: json['id'],
      code: json['code'],
      discountType: json['discountType'],
      discountAmount: json['discountAmount']?.toDouble(),
      minimumPurchaseAmount: json['minimumPurchaseAmount']?.toDouble(),
      expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate']) : null,
      status: json['status'],
      applicableCategoryId: json['applicableCategoryId'],
      applicableSubCategoryId: json['applicableSubCategoryId'],
      applicableProductId: json['applicableProductId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'discountType': discountType,
      'discountAmount': discountAmount,
      'minimumPurchaseAmount': minimumPurchaseAmount,
      'expiryDate': expiryDate?.toIso8601String(),
      'status': status,
      'applicableCategoryId': applicableCategoryId,
      'applicableSubCategoryId': applicableSubCategoryId,
      'applicableProductId': applicableProductId,
    };
  }

  static List<UserCouponModel> fromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return UserCouponModel.fromJson(data).copyWith(id: doc.id);
    }).toList();
  }

  static UserCouponModel fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserCouponModel.fromJson(data).copyWith(id: doc.id);
  }

  UserCouponModel copyWith({
    String? id,
    String? code,
    String? discountType,
    double? discountAmount,
    double? minimumPurchaseAmount,
    DateTime? expiryDate,
    String? status,
    String? applicableCategoryId,
    String? applicableSubCategoryId,
    String? applicableProductId,
  }) {
    return UserCouponModel(
      id: id ?? this.id,
      code: code ?? this.code,
      discountType: discountType ?? this.discountType,
      discountAmount: discountAmount ?? this.discountAmount,
      minimumPurchaseAmount: minimumPurchaseAmount ?? this.minimumPurchaseAmount,
      expiryDate: expiryDate ?? this.expiryDate,
      status: status ?? this.status,
      applicableCategoryId: applicableCategoryId ?? this.applicableCategoryId,
      applicableSubCategoryId: applicableSubCategoryId ?? this.applicableSubCategoryId,
      applicableProductId: applicableProductId ?? this.applicableProductId,
    );
  }
  // Method to create an empty instance
  static UserCouponModel empty() {
    return UserCouponModel(
      id: '',
      code: '',
      status: '',
      discountAmount: 0.0,
      discountType: '',
      expiryDate: DateTime.now(),
      applicableProductId:'',
      minimumPurchaseAmount: 0.0,
    );
  }
}
