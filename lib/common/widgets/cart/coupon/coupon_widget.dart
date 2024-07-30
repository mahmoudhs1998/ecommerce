import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../admin/coupon.dart';
import '../../../../features/shop/controllers/checkout/order_controller.dart';
import '../../../../features/shop/screens/checkout/checkout.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helpers_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';

// class TCouponCode extends StatelessWidget {
//
//   const TCouponCode({
//     super.key,
//   });
//
//
//   @override
//   Widget build(BuildContext context) {
//         final isDark = THelperFunctions.isDarkMode(context);
//         final CouponController couponController = Get.put(CouponController());
//
//     return TRoundedContainer(
//       showBorder: true,
//       backgroundColor: isDark ? TColors.dark : TColors.white,
//       padding: const EdgeInsets.only(
//           top: TSizes.sm,
//           bottom: TSizes.sm,
//           left: TSizes.md,
//           right: TSizes.sm),
//       child: Row(
//         children: [
//           Flexible(
//             child: TextFormField(
//               decoration: const InputDecoration(
//                 hintText: 'Have a Promo Code? Enter Here',
//                 border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 errorBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//               ),
//             ),
//           ),
//
//           // -- Apply Button
//           SizedBox(
//             width: 80,
//             child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: isDark
//                       ? TColors.white.withOpacity(0.5)
//                       : TColors.black.withOpacity(0.5),
//                   backgroundColor: Colors.grey.withOpacity(0.2),
//                   side:
//                       BorderSide(color: Colors.grey.withOpacity(0.1)),
//                 ),
//                 onPressed: () {
//                   couponController.applyCoupon(couponController.couponCode.value);
//                 },
//                 child: const Text('Apply')),
//           ),
//         ],
//       ),
//     );
//   }
// }














// model ::::::::::::::::


// class TCouponCode extends StatelessWidget {
//   const TCouponCode({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = THelperFunctions.isDarkMode(context);
//     final UserCouponControllers couponController = Get.find<UserCouponControllers>();
//     final TextEditingController textController = TextEditingController();
//
//     return Column(
//       children: [
//         TRoundedContainer(
//           showBorder: true,
//           backgroundColor: isDark ? TColors.dark : TColors.white,
//           padding: const EdgeInsets.only(
//               top: TSizes.sm,
//               bottom: TSizes.sm,
//               left: TSizes.md,
//               right: TSizes.sm),
//           child: Row(
//             children: [
//               Flexible(
//                 child: TextFormField(
//                   controller: textController,
//                   decoration: const InputDecoration(
//                     hintText: 'Have a Promo Code? Enter Here',
//                     border: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     disabledBorder: InputBorder.none,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 80,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: isDark
//                         ? TColors.white.withOpacity(0.5)
//                         : TColors.black.withOpacity(0.5),
//                     backgroundColor: Colors.grey.withOpacity(0.2),
//                     side: BorderSide(color: Colors.grey.withOpacity(0.1)),
//                   ),
//                   onPressed: () {
//                     couponController.applyCoupon(textController.value.text);
//                   },
//                   child: const Text('Apply'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: TSizes.spaceBtwItems),
//         Obx(() {
//           if (couponController.appliedCoupon.value != null) {
//             return Column(
//               children: [
//                 Text(
//                   'Applied Coupon: ${couponController.appliedCoupon.value!.code}',
//                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: TSizes.xs),
//                 Text(
//                   'Discount: \$${(couponController.totalAmount.value - couponController.discountedAmount.value).toStringAsFixed(2)}',
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//                 const SizedBox(height: TSizes.xs),
//                 TextButton(
//                   onPressed: () => couponController.removeCoupon(),
//                   child: const Text('Remove Coupon'),
//                 ),
//               ],
//             );
//           }
//           return const SizedBox.shrink();
//         }),
//       ],
//     );
//   }
// }


// class TCouponCode extends StatelessWidget {
//   final Function(String) onApply;
//
//   const TCouponCode({Key? key, required this.onApply}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = THelperFunctions.isDarkMode(context);
//     final UserCouponControllers couponController = Get.find<UserCouponControllers>();
//     final TextEditingController textController = TextEditingController();
//
//     return Column(
//       children: [
//         TRoundedContainer(
//           showBorder: true,
//           backgroundColor: isDark ? TColors.dark : TColors.white,
//           padding: const EdgeInsets.only(
//               top: TSizes.sm,
//               bottom: TSizes.sm,
//               left: TSizes.md,
//               right: TSizes.sm),
//           child: Row(
//             children: [
//               Flexible(
//                 child: TextFormField(
//                   controller: textController,
//                   decoration: const InputDecoration(
//                     hintText: 'Have a Promo Code? Enter Here',
//                     border: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     disabledBorder: InputBorder.none,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 80,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: isDark
//                         ? TColors.white.withOpacity(0.5)
//                         : TColors.black.withOpacity(0.5),
//                     backgroundColor: Colors.grey.withOpacity(0.2),
//                     side: BorderSide(color: Colors.grey.withOpacity(0.1)),
//                   ),
//                   // onPressed: () {
//                   //   couponController.applyCoupon(textController.text, currentProductId);
//                   // },
//                   onPressed: () {
//                     onApply(textController.text);
//                   },
//                   child: const Text('Apply'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: TSizes.spaceBtwItems),
//         Obx(() {
//           if (couponController.appliedCoupon.value != null) {
//             return Column(
//               children: [
//                 Text(
//                   'Applied Coupon: ${couponController.appliedCoupon.value!.code}',
//                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: TSizes.xs),
//                 Text(
//                   'Discount: \$${(couponController.totalAmount.value - couponController.discountedAmount.value).toStringAsFixed(2)}',
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//                 const SizedBox(height: TSizes.xs),
//                 TextButton(
//                   onPressed: () => couponController.removeCoupon(),
//                   child: const Text('Remove Coupon'),
//                 ),
//               ],
//             );
//           }
//           return const SizedBox.shrink();
//         }),
//       ],
//     );
//   }
// }

class TCouponCode extends StatelessWidget {
  final Function(String) onApply;

  const TCouponCode({Key? key, required this.onApply}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final UserCouponControllers couponController = Get.find<UserCouponControllers>();
    final TextEditingController textController = TextEditingController();

    return Obx(() {
      if (couponController.appliedCoupon.value != null) {
        return Column(
          children: [
            Text(
              'Applied Coupon: ${couponController.appliedCoupon.value!.code}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: TSizes.xs),
            Text(
              'Discount: \$${(couponController.totalAmount.value - couponController.discountedAmount.value).toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.xs),
            TextButton(
              onPressed: () => couponController.removeCoupon(),
              child: const Text('Remove Coupon'),
            ),
          ],
        );
      } else {
        return TRoundedContainer(
          showBorder: true,
          backgroundColor: isDark ? TColors.dark : TColors.white,
          padding: const EdgeInsets.only(
              top: TSizes.sm,
              bottom: TSizes.sm,
              left: TSizes.md,
              right: TSizes.sm),
          child: Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'Have a Promo Code? Enter Here',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: isDark
                        ? TColors.white.withOpacity(0.5)
                        : TColors.black.withOpacity(0.5),
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    side: BorderSide(color: Colors.grey.withOpacity(0.1)),
                  ),
                  onPressed: () {
                    onApply(textController.text);
                  },
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}


class CouponModel {
  String? id;
  String? code;
  String? discountType;
  double? discountAmount;
  double? minimumPurchaseAmount;
  DateTime? expiryDate;
  String? status;
  String? applicableCategoryId;
  String? applicableSubCategoryId;
  String? applicableProductId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int usageCount; // Add this field

  CouponModel({
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
    this.createdAt,
    this.updatedAt,
    this.usageCount = 0, // Initialize with a default value
  });

  CouponModel copyWith({
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
    DateTime? createdAt,
    DateTime? updatedAt,
    int? usageCount,
  }) {
    return CouponModel(
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
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      usageCount: usageCount ?? this.usageCount,
    );
  }

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
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
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      usageCount: json['usageCount'] ?? 0, // Handle usageCount
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
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'usageCount': usageCount, // Add usageCount to JSON
    };
  }
}






// Controller ::::::::::::::::::





// Controller
// class CouponController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final coupons = <CouponModel>[].obs;
//   final RxString filterCategory = ''.obs;
//   final RxString sortOrder = 'createdAt'.obs;
//
//   final TextEditingController codeController = TextEditingController();
//   final TextEditingController discountTypeController = TextEditingController();
//   final TextEditingController discountAmountController = TextEditingController();
//   final TextEditingController minimumPurchaseAmountController = TextEditingController();
//   final TextEditingController expiryDateController = TextEditingController();
//   final TextEditingController statusController = TextEditingController();
//   final TextEditingController applicableCategoryIdController = TextEditingController();
//   final TextEditingController applicableSubCategoryIdController = TextEditingController();
//   final TextEditingController applicableProductIdController = TextEditingController();
//
//   final formKey = GlobalKey<FormState>();
//   CouponModel? selectedCoupon;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchCoupons();
//   }
//
//   Future<void> fetchCoupons() async {
//     try {
//       final snapshot = await _firestore.collection('Coupons').get();
//       final couponsList = snapshot.docs.map((doc) => CouponModel.fromJson(doc.data())).toList();
//       coupons.assignAll(couponsList);
//     } catch (error) {
//       Get.snackbar('Error', 'Failed to fetch coupons: $error',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }
//
//   Future<bool> validateCoupon(String code, double totalAmount) async {
//     final coupon = coupons.firstWhereOrNull((c) => c.code == code);
//     if (coupon == null) {
//       Get.snackbar('Error', 'Invalid coupon code',
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return false;
//     }
//     if (coupon.expiryDate != null && DateTime.now().isAfter(coupon.expiryDate!)) {
//       Get.snackbar('Error', 'Coupon has expired',
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return false;
//     }
//     if (coupon.minimumPurchaseAmount != null &&
//         totalAmount < coupon.minimumPurchaseAmount!) {
//       Get.snackbar('Error', 'Minimum purchase amount not met',
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return false;
//     }
//     return true;
//   }
//
//   double applyCoupon(String code, double totalAmount) {
//     final coupon = coupons.firstWhereOrNull((c) => c.code == code);
//     if (coupon == null) return totalAmount;
//
//     double discount = 0.0;
//     if (coupon.discountType == 'percentage') {
//       discount = totalAmount * (coupon.discountAmount ?? 0.0) / 100;
//     } else {
//       discount = coupon.discountAmount ?? 0.0;
//     }
//
//     return totalAmount - discount;
//   }
//
//   void clearForm() {
//     codeController.clear();
//     discountTypeController.clear();
//     discountAmountController.clear();
//     minimumPurchaseAmountController.clear();
//     expiryDateController.clear();
//     statusController.clear();
//     applicableCategoryIdController.clear();
//     applicableSubCategoryIdController.clear();
//     applicableProductIdController.clear();
//     selectedCoupon = null;
//   }
// }
