import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../admin/coupon.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/cart/coupon/coupon_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/helpers/helpers_functions.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../controllers/cart/cart_controller.dart';
import '../../controllers/checkout/order_controller.dart';
import 'widgets/billing_address_section.dart';
import 'widgets/billing_amount_section.dart';

// class CheckoutScreen extends StatelessWidget {
//   const CheckoutScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final cartController = CartController.instance;
//     final subTotal = cartController.totalCartPrice.value;
//     final totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, 'US');
//     final orderController = Get.put(OrderController());
//     final isDark = THelperFunctions.isDarkMode(context);
//     return Scaffold(
//       appBar: TAppBar(
//           showBackArrow: true,
//           title: Text('Order Review'.tr,
//               style: Theme.of(context).textTheme.headlineSmall)),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.defaultSpace),
//           child: Column(
//             children: [
//               // -- Cart Items
//               const TCartItems(showAddRemoveButtons: false),
//               const SizedBox(height: TSizes.spaceBtwSections),
//
//               // -- Coupon TextField
//               const TCouponCode(),
//
//               const SizedBox(height: TSizes.spaceBtwSections),
//
//               // -- Billing Section
//               TRoundedContainer(
//                 showBorder: true,
//                 padding: const EdgeInsets.all(TSizes.md),
//                 backgroundColor: isDark ? TColors.dark : TColors.white,
//                 child: const Column(children: [
//                   // -- Price
//                   BillingAmountSection(),
//                   SizedBox(height: TSizes.spaceBtwItems),
//                   // -- Divider
//                   Divider(),
//                   SizedBox(height: TSizes.spaceBtwItems),
//
//                   // -- Payment Method
//                   BillingPaymentSection(),
//                   SizedBox(height: TSizes.spaceBtwItems),
//                   // -- Address
//                   BillingAddressSection(),
//                 ]),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(TSizes.defaultSpace),
//         child: ElevatedButton(
//           onPressed: ()=>orderController.processOrder(totalAmount),
//           child: Text('${TTexts.checkout} \$$totalAmount'),
//         ),
//         // ElevatedButton(
//         //     onPressed: () => subTotal > 0
//         //         ?  ()=> orderController.processOrder(totalAmount)
//         //         :  ()=> TLoaders.warningSnackBar(title: 'Empty Cart', message: 'Add items in the cart in order to proceed.'),
//         //         // Get.to(() => SuccessScreen(
//         //         //   title: 'Payment Successful',
//         //         //   image: TImages.success,
//         //         //   subTitle: 'Thank you for your purchase!',
//         //         //   onPressed: () => Get.offAll(() => const NavigationMenu()),
//         //         // )),
//         //     child: Text('Checkout \$$totalAmount'),
//         // ),
//       ),
//     );
//   }
// }



// class CheckoutScreen extends StatelessWidget {
//   const CheckoutScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final cartController = CartController.instance;
//     final orderController = Get.put(OrderController());
//     final userCouponController = Get.put(UserCouponControllers());
//     final isDark = THelperFunctions.isDarkMode(context);
//
//     return Scaffold(
//       appBar: TAppBar(
//         showBackArrow: true,
//         title: Text('Order Review'.tr,
//             style: Theme.of(context).textTheme.headlineSmall),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.defaultSpace),
//           child: Column(
//             children: [
//               // -- Cart Items
//               const TCartItems(showAddRemoveButtons: false),
//               const SizedBox(height: TSizes.spaceBtwSections),
//
//               // -- Coupon TextField
//               const TCouponCode(),
//
//               const SizedBox(height: TSizes.spaceBtwSections),
//
//               // -- Billing Section
//               TRoundedContainer(
//                 showBorder: true,
//                 padding: const EdgeInsets.all(TSizes.md),
//                 backgroundColor: isDark ? TColors.dark : TColors.white,
//                 child: Column(
//                   children: [
//                     // -- Price
//                     Obx(() => BillingAmountSection(
//                 subTotal: userCouponController.totalAmount.value,
//                 discount: userCouponController.totalAmount.value - userCouponController.discountedAmount.value,
//                 total: userCouponController.discountedAmount.value,
//               )),
//                     const SizedBox(height: TSizes.spaceBtwItems),
//                     // -- Divider
//                     const Divider(),
//                     const SizedBox(height: TSizes.spaceBtwItems),
//
//                     // -- Payment Method
//                     const BillingPaymentSection(),
//                     const SizedBox(height: TSizes.spaceBtwItems),
//                     // -- Address
//                     const BillingAddressSection(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(TSizes.defaultSpace),
//         child: Obx(() => ElevatedButton(
//           onPressed: () => orderController.processOrder(userCouponController.discountedAmount.value),
//           child: Text('Checkout \$${userCouponController.discountedAmount.value.toStringAsFixed(2)}'),
//         )),
//       ),
//     );
//   }
// }

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final orderController = Get.put(OrderController());
    final userCouponController = Get.put(UserCouponControllers());
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Order Review'.tr,
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // -- Cart Items
              const TCartItems(showAddRemoveButtons: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              // -- Coupon TextField
              TCouponCode(
                onApply: (String couponCode) {
                  // Get all product IDs in the cart and join them into a single string
                  final String productIds = cartController.cartItems
                      .map((item) => item.productId)
                      .join(','); // Join product IDs with a comma

                  // Apply coupon for all products in the cart
                  userCouponController.applyCoupon(couponCode, productIds);
                },
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              // -- Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: isDark ? TColors.dark : TColors.white,
                child: Column(
                  children: [
                    // -- Price
                    Obx(() => BillingAmountSection(
                      subTotal: userCouponController.totalAmount.value,
                      discount: userCouponController.totalAmount.value - userCouponController.discountedAmount.value,
                      total: userCouponController.discountedAmount.value,
                    )),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    // -- Divider
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // -- Payment Method
                    const BillingPaymentSection(),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    // -- Address
                    const BillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(() => ElevatedButton(
          onPressed: () => orderController.processOrder(userCouponController.discountedAmount.value),
          child: Text('Checkout \$${userCouponController.discountedAmount.value.toStringAsFixed(2)}'),
        )),
      ),
    );
  }
}

class UserCouponController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<UserCouponModel> availableCoupons = <UserCouponModel>[].obs;
  final Rx<UserCouponModel?> appliedCoupon = Rx<UserCouponModel?>(null);
  final RxDouble totalAmount = 0.0.obs;
  final RxDouble discountedAmount = 0.0.obs;

  void setTotalAmount(double amount) {
    totalAmount.value = amount;
    calculateDiscountedAmount();
  }

  void calculateDiscountedAmount() {
    if (appliedCoupon.value != null) {
      final discount = calculateDiscount(appliedCoupon.value!);
      discountedAmount.value = totalAmount.value - discount;
    } else {
      discountedAmount.value = totalAmount.value;
    }
  }

  @override
  void onInit() {
    super.onInit();
    //fetchValidCoupons();
    fetchCouponsWithoutIndex();
//    fetchCoupons();
    setTotalAmount(CartController.instance.totalCartPrice.value);
  }

  // Future<void> fetchCoupons() async {
  //   try {
  //     final snapshot = await _firestore.collection('Coupons')
  //         .where('status', isEqualTo: 'active')
  //        // .where('expiryDate', isGreaterThan: Timestamp.now()) // Use Timestamp
  //         // .where('expiryDate', isGreaterThan: DateTime.now())
  //         .get();
  //     final couponsList = snapshot.docs.map((doc) => UserCouponModel.fromJson(doc.data())).toList();
  //     availableCoupons.assignAll(couponsList);
  //     update();
  //   } catch (error) {
  //     Get.snackbar('Error', 'Failed to fetch coupons: $error',
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   }
  // }

  // good
  // Future<void> fetchCoupons() async {
  //   try {
  //     final now = Timestamp.now();
  //     final snapshot = await _firestore.collection('Coupons')
  //         .where('status', isEqualTo: 'active')
  //         //.where('expiryDate', isGreaterThan: now)
  //         //.where('expiryDate', isGreaterThan: now)
  //         .get();
  //     triggerIndexCreation();
  //     final couponsList = snapshot.docs.map((doc) => UserCouponModel.fromJson(doc.data())).toList();
  //     availableCoupons.assignAll(couponsList);
  //     update();
  //   } catch (error) {
  //     Get.snackbar('Error', 'Failed to fetch coupons: $error',
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //     print(error.toString());
  //   }
  // }
// Optional fallback method
  Future<void> fetchCouponsWithoutIndex() async {
    final snapshot = await FirebaseFirestore.instance.collection('Coupons').get();
    final allCoupons = UserCouponModel.fromQuerySnapshot(snapshot);
    final now = DateTime.now();

    final filteredCoupons = allCoupons.where((coupon) =>
    coupon.status == 'active' && coupon.expiryDate != null && coupon.expiryDate!.isAfter(now)).toList();

    availableCoupons.assignAll(filteredCoupons);
    update();
  }
  Future<void> fetchCoupons() async {
    try {
      final now = DateTime.now();

      final snapshot = await FirebaseFirestore.instance.collection('Coupons')
          .where('status', isEqualTo: 'active')
          .where('expiryDate', isGreaterThan: now) // Using DateTime directly
          .get();

      final filteredCoupons = UserCouponModel.fromQuerySnapshot(snapshot);

      availableCoupons.assignAll(filteredCoupons);
      update();
    } catch (error) {
      Get.snackbar('Error', 'Failed to fetch coupons: $error',
          backgroundColor: Colors.red, colorText: Colors.white);
      print( ' errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${error.toString()}');
    }
  }
  Future<void> fetchValidCoupons() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final DateTime now = DateTime.now();

    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('Coupons')
          .where('status', isEqualTo: 'active')
          .where('expiryDate', isGreaterThan: Timestamp.fromDate(now))
          .get();

      final List<CouponModel> validCoupons = snapshot.docs
          .map((doc) => CouponModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      print('Valid coupons: ${validCoupons.length}');
    } catch (error) {
      if (error is FirebaseException && error.code == 'failed-precondition') {
        print('This query requires a Firestore index. Please create it in the Firebase Console.');
        print('Index creation link: ${error.message}');
      } else {
        print('Error fetching valid coupons: $error');
      }
    }
  }
  // Future<void> fetchAvailableCoupons() async {
  //   try {
  //     final snapshot = await _firestore
  //         .collection('Coupons')
  //         .where('status', isEqualTo: 'active')
  //         .where('expiryDate', isGreaterThan: DateTime.now())
  //         .get();
  //
  //     final couponsList = snapshot.docs
  //         .map((doc) => UserCouponModel.fromJson(doc.data()))
  //         .toList();
  //     availableCoupons.assignAll(couponsList);
  //   } catch (error) {
  //     Get.snackbar('Error', 'Failed to fetch coupons: $error',
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   }
  // }

  void triggerIndexCreation() async {
    try {
      final now = Timestamp.fromDate(DateTime.now());
      final snapshot = await FirebaseFirestore.instance.collection('Coupons')
          .where('status', isEqualTo: 'active')
          .where('expiryDate', isGreaterThan: now)
          .get();
    } catch (e) {
      if (e.toString().contains('requires an index')) {
        // Log or handle the index creation URL
        print('Error: $e');
      } else {
        print('Unexpected error: $e');
      }
    }
  }
  Future<void> applyCoupon(String couponCode) async {
    try {
      final coupon = availableCoupons.firstWhere((c) => c.code == couponCode);

      if (validateCoupon(coupon)) {
        appliedCoupon.value = coupon;
        final discount = calculateDiscount(coupon);
        discountedAmount.value = totalAmount.value - discount;
        Get.snackbar('Success', 'Coupon applied successfully',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Invalid or expired coupon',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (error) {
      Get.snackbar('Error', 'Coupon not found or could not be applied',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // bool validateCoupon(UserCouponModel coupon) {
  //   final now = DateTime.now();
  //   return coupon.expiryDate != null &&
  //       coupon.expiryDate!.isAfter(now) &&
  //       coupon.status == 'active' &&
  //       totalAmount.value >= (coupon.minimumPurchaseAmount ?? 0);
  // }
  bool validateCoupon(UserCouponModel coupon) {
    final now = DateTime.now(); // Current date and time as DateTime
    final isValid = coupon.expiryDate != null &&
        coupon.expiryDate!.isAfter(now) && // Compare DateTime objects
        coupon.status == 'active' &&
        totalAmount.value >= (coupon.minimumPurchaseAmount ?? 0);
    return isValid;
  }

  double calculateDiscount(UserCouponModel coupon) {
    double discount = 0.0;

    if (coupon.discountType == 'percentage') {
      discount = totalAmount.value * (coupon.discountAmount ?? 0) / 100;
    } else if (coupon.discountType == 'fixed') {
      discount = coupon.discountAmount ?? 0;
    }

    return discount > totalAmount.value ? totalAmount.value : discount;
  }

  // void setTotalAmount(double amount) {
  //   totalAmount.value = amount;
  //   if (appliedCoupon.value != null) {
  //     final discount = calculateDiscount(appliedCoupon.value!);
  //     discountedAmount.value = totalAmount.value - discount;
  //   } else {
  //     discountedAmount.value = totalAmount.value;
  //   }
  // }

  void removeCoupon() {
    appliedCoupon.value = null;
    discountedAmount.value = totalAmount.value;
    Get.snackbar('Success', 'Coupon removed',
        backgroundColor: Colors.green, colorText: Colors.white);
  }
}


// class UserCouponModel {
//   String? id;
//   String? code;
//   String? discountType;
//   double? discountAmount;
//   double? minimumPurchaseAmount;
//   DateTime? expiryDate;
//   String? status;
//   String? applicableCategoryId;
//   String? applicableSubCategoryId;
//   String? applicableProductId;
//
//   UserCouponModel({
//     this.id,
//     this.code,
//     this.discountType,
//     this.discountAmount,
//     this.minimumPurchaseAmount,
//     this.expiryDate,
//     this.status,
//     this.applicableCategoryId,
//     this.applicableSubCategoryId,
//     this.applicableProductId,
//   });
//
//   factory UserCouponModel.fromJson(Map<String, dynamic> json) {
//     return UserCouponModel(
//       id: json['id'],
//       code: json['code'],
//       discountType: json['discountType'],
//       discountAmount: json['discountAmount']?.toDouble(),
//       minimumPurchaseAmount: json['minimumPurchaseAmount']?.toDouble(),
//       expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate']) : null,
//       status: json['status'],
//       applicableCategoryId: json['applicableCategoryId'],
//       applicableSubCategoryId: json['applicableSubCategoryId'],
//       applicableProductId: json['applicableProductId'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'code': code,
//       'discountType': discountType,
//       'discountAmount': discountAmount,
//       'minimumPurchaseAmount': minimumPurchaseAmount,
//       'expiryDate': expiryDate?.toIso8601String(),
//       'status': status,
//       'applicableCategoryId': applicableCategoryId,
//       'applicableSubCategoryId': applicableSubCategoryId,
//       'applicableProductId': applicableProductId,
//     };
//   }
// }


class UserCouponModel {
  String? id;
  String? code;
  String? discountType;
  double? discountAmount;
  double? minimumPurchaseAmount;
  DateTime? expiryDate; // Use DateTime here
  String? status;
  String? applicableCategoryId;
  String? applicableSubCategoryId;
  String? applicableProductId;

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
      expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate']) : null, // Convert from ISO 8601 String
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
      'expiryDate': expiryDate?.toIso8601String(), // Convert to ISO 8601 String
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
}
