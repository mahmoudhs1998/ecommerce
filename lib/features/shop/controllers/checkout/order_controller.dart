import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/zBottom_navigation_bar/navigation_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../admin/products/controller/test/logic.dart';
import '../../../../common/widgets/cart/coupon/coupon_widget.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/address_controller.dart';
import '../../../personalization/models/order.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../cart/cart_controller.dart';
import 'checkout_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = CartController. instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckOutController.instance;
  final orderRepository = Get.put(OrderRepository());

/// Fetch user's order history
 Future<List<OrderModel>> fetchUserOrders() async{
   try{
     final userOrders = await orderRepository.fetchUserOrders();
     return userOrders;
   }catch(e){
     TLoaders.warningSnackBar(title: '0h Snap!', message: e.toString());
     return [];
   }
 }

/// Add methods for order processing
 Future<void> processOrder(double totalAmount) async{
   try {
     // start loader
     TFullScreenLoader.openLoadingDialog('Processing Your Order',TImages.shopAnimation);

     // Get User Authenticated Id
     final userId = AuthenticationRepository.instance.currentAuthUser!.uid;
     if(userId.isEmpty) return;
     // Add Details
     final order = OrderModel(
       // Generate Unique Id for Order
       id: UniqueKey().toString(),
         userId: userId,
         status: OrderStatus.pending,
         totalAmount: totalAmount,
         orderDate: DateTime.now(),
         paymentMethod: checkoutController.selectedPaymentMethod.value.name,
         address: addressController.selectedAddress.value,
         deliveryDate: DateTime.now(),
         items: cartController.cartItems.toList(),
     );
     // Save the order to FireStore
     await orderRepository.saveOrder(order, userId);

     // Update the Cart Statues
     cartController.clearCart();
     // Show Success screen
     Get.off(() => SuccessScreen(
       image: TImages.shopAnimation,
       title: 'Payment Success!',
       subTitle: 'Your item will be shipped soon!',
       onPressed: () => Get.offAll(() => const NavigationMenu()),
     )); // SuccessScreen

   } catch(e){
     TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
   }
 }

 }






class CouponController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final coupons = <CouponModel>[].obs;
  final RxString filterCategory = ''.obs;
  final RxString sortOrder = 'createdAt'.obs;

  // Text editing controllers
  final TextEditingController codeController = TextEditingController();
  final TextEditingController discountTypeController = TextEditingController();
  final TextEditingController discountAmountController = TextEditingController();
  final TextEditingController minimumPurchaseAmountController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController applicableCategoryIdController = TextEditingController();
  final TextEditingController applicableSubCategoryIdController = TextEditingController();
  final TextEditingController applicableProductIdController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  CouponModel? selectedCoupon;

  @override
  void onInit() {
    super.onInit();
    fetchCoupons();
    fetchCategories();
    fetchSubCategories();
    fetchProducts();
  }

  // Fetch Coupons
  Future<void> fetchCoupons() async {
    try {
      final snapshot = await _firestore.collection('Coupons').get();
      final couponsList = snapshot.docs.map((doc) => CouponModel.fromJson(doc.data())).toList();
      coupons.assignAll(couponsList);
      update();
    } catch (error) {
      Get.snackbar('Error', 'Failed to fetch coupons: $error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Add Coupon
  Future<void> addCoupon() async {
    try {
      final newCoupon = CouponModel(
        code: codeController.text,
        discountType: discountTypeController.text,
        discountAmount: double.tryParse(discountAmountController.text),
        minimumPurchaseAmount: double.tryParse(minimumPurchaseAmountController.text),
        expiryDate: DateTime.tryParse(expiryDateController.text),
        status: statusController.text,
        applicableCategoryId: applicableCategoryIdController.text,
        applicableSubCategoryId: applicableSubCategoryIdController.text,
        applicableProductId: applicableProductIdController.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final docRef = await _firestore.collection('Coupons').add(newCoupon.toJson());
      newCoupon.id = docRef.id;
      coupons.add(newCoupon);

      clearForm();
      Get.snackbar('Success', 'Coupon added successfully',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (error) {
      Get.snackbar('Error', 'Failed to add coupon: $error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Update Coupon
  Future<void> updateCoupon(String couponId) async {
    try {
      final updatedCoupon = CouponModel(
        id: couponId,
        code: codeController.text,
        discountType: discountTypeController.text,
        discountAmount: double.tryParse(discountAmountController.text),
        minimumPurchaseAmount: double.tryParse(minimumPurchaseAmountController.text),
        expiryDate: DateTime.tryParse(expiryDateController.text),
        status: statusController.text,
        applicableCategoryId: applicableCategoryIdController.text,
        applicableSubCategoryId: applicableSubCategoryIdController.text,
        applicableProductId: applicableProductIdController.text,
        updatedAt: DateTime.now(),
      );

      await _firestore.collection('Coupons').doc(couponId).update(updatedCoupon.toJson());

      final index = coupons.indexWhere((coupon) => coupon.id == couponId);
      if (index != -1) {
        coupons[index] = updatedCoupon;
      }

      clearForm();
      Get.snackbar('Success', 'Coupon updated successfully',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (error) {
      Get.snackbar('Error', 'Failed to update coupon: $error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Delete Coupon
  Future<void> deleteCoupon(String couponId) async {
    try {
      await _firestore.collection('Coupons').doc(couponId).delete();
      coupons.removeWhere((coupon) => coupon.id == couponId);
      Get.snackbar('Success', 'Coupon deleted successfully',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (error) {
      Get.snackbar('Error', 'Failed to delete coupon: $error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Validate Coupon
  // bool validateCoupon() {
  //   if (codeController.text.isEmpty) {
  //     Get.snackbar('Error', 'Coupon code is required',
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //     return false;
  //   }
  //   if (discountAmountController.text.isNotEmpty &&
  //       double.tryParse(discountAmountController.text) == null) {
  //     Get.snackbar('Error', 'Invalid discount amount',
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //     return false;
  //   }
  //   if (minimumPurchaseAmountController.text.isNotEmpty &&
  //       double.tryParse(minimumPurchaseAmountController.text) == null) {
  //     Get.snackbar('Error', 'Invalid minimum purchase amount',
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //     return false;
  //   }
  //   if (expiryDateController.text.isNotEmpty &&
  //       DateTime.tryParse(expiryDateController.text) == null) {
  //     Get.snackbar('Error', 'Invalid expiry date',
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //     return false;
  //   }
  //   return true;
  // }

  // Increment usage count
  // Future<void> incrementUsageCount(String couponId) async {
  //   try {
  //     final couponRef = _firestore.collection('Coupons').doc(couponId);
  //     await _firestore.runTransaction((transaction) async {
  //       final snapshot = await transaction.get(couponRef);
  //       final coupon = CouponModel.fromJson(snapshot.data()!);
  //       await transaction.update(couponRef, {
  //         'usageCount': coupon.usageCount + 1,
  //       });
  //     });
  //     Get.snackbar('Success', 'Coupon usage updated',
  //         backgroundColor: Colors.green, colorText: Colors.white);
  //   } catch (error) {
  //     Get.snackbar('Error', 'Failed to update coupon usage: $error',
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   }
  // }


  Future<void> submitCoupon() async {
    if (formKey.currentState!.validate()) {
      try {
        final newCoupon = CouponModel(
          id: selectedCoupon?.id, // This will be null for new coupons
          code: codeController.text,
          discountType: discountTypeController.text,
          discountAmount: double.tryParse(discountAmountController.text) ?? 0.0,
          minimumPurchaseAmount: double.tryParse(minimumPurchaseAmountController.text) ?? 0.0,
          expiryDate: DateTime.tryParse(expiryDateController.text),
          status: statusController.text,
          applicableCategoryId: applicableCategoryIdController.text,
          applicableSubCategoryId: applicableSubCategoryIdController.text,
          applicableProductId: applicableProductIdController.text,
          createdAt: selectedCoupon?.createdAt ?? DateTime.now(),
          updatedAt: DateTime.now(),
          usageCount: selectedCoupon?.usageCount ?? 0,
        );

        if (selectedCoupon != null) {
          // Updating existing coupon
          await _firestore.collection('Coupons').doc(selectedCoupon!.id).update(newCoupon.toJson());
          final index = coupons.indexWhere((coupon) => coupon.id == selectedCoupon!.id);
          if (index != -1) {
            coupons[index] = newCoupon;
          }
          Get.snackbar('Success', 'Coupon updated successfully',
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          // Adding new coupon
          final docRef = await _firestore.collection('Coupons').add(newCoupon.toJson());
          final String newId = docRef.id;

          // Update the newCoupon with the generated ID
          final updatedCoupon = newCoupon.copyWith(id: newId);

          // Update the document in Firestore with the ID included
          await docRef.update(updatedCoupon.toJson());

          coupons.add(updatedCoupon);
          Get.snackbar('Success', 'Coupon added successfully',
              backgroundColor: Colors.green, colorText: Colors.white);
        }

        clearForm();
        update();
      } catch (error) {
        Get.snackbar('Error', 'Failed to submit coupon: $error',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

  void setDataForUpdateCoupon(CouponModel? coupon) {
    selectedCoupon = coupon;
    if (coupon != null) {
      codeController.text = coupon.code ?? '';
      discountTypeController.text = coupon.discountType ?? 'fixed';
      discountAmountController.text = coupon.discountAmount?.toString() ?? '';
      minimumPurchaseAmountController.text = coupon.minimumPurchaseAmount?.toString() ?? '';
      expiryDateController.text = coupon.expiryDate != null ? DateFormat('yyyy-MM-dd').format(coupon.expiryDate!) : '';
      statusController.text = coupon.status ?? 'active';

      // Set category, subcategory, and product based on IDs
      selectedCategory.value = categories.firstWhereOrNull((cat) => cat.id == coupon.applicableCategoryId);
      selectedSubCategory.value = subCategories.firstWhereOrNull((subCat) => subCat.id == coupon.applicableSubCategoryId);
      selectedProduct.value = products.firstWhereOrNull((prod) => prod.id == coupon.applicableProductId);

      applicableCategoryIdController.text = coupon.applicableCategoryId ?? '';
      applicableSubCategoryIdController.text = coupon.applicableSubCategoryId ?? '';
      applicableProductIdController.text = coupon.applicableProductId ?? '';
    } else {
      clearForm();
    }
    update();
  }

  // Get IDs ##########
  RxList<String> categoryNames = <String>[].obs;
  RxList<String> subCategoryNames = <String>[].obs;
  RxList<String> productNames = <String>[].obs;
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
  Rx<SubCategoryModel?> selectedSubCategory = Rx<SubCategoryModel?>(null);
  Rx<ProductModel?> selectedProduct = Rx<ProductModel?>(null);

// New fields for category, subcategory, and product selection
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<SubCategoryModel> subCategories = <SubCategoryModel>[].obs;
  RxList<ProductModel> products = <ProductModel>[].obs;

  // New methods for fetching categories, subcategories, and products
  Future<void> fetchCategories() async {
    try {
      final snapshot = await _firestore.collection('Categories').get();
      categories.value = snapshot.docs
          .map((doc) => CategoryModel.fromSnapshot(doc))
          .toList();
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  Future<void> fetchSubCategories() async {
    try {
      final snapshot = await _firestore.collection('subCategories').get();
      subCategories.value = snapshot.docs
          .map((doc) => SubCategoryModel.fromMap(doc.data()))
          .toList();
    } catch (error) {
      print('Error fetching subcategories: $error');
    }
  }

  Future<void> fetchProducts() async {
    try {
      final snapshot = await _firestore.collection('Products').get();
      products.value = snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  // Methods for selecting category, subcategory, and product
  void selectCategory(CategoryModel category) {
    selectedCategory.value = category;
    applicableCategoryIdController.text = category.id;
    // Reset subcategory and product when category changes
    selectedSubCategory.value = null;
    selectedProduct.value = null;
    applicableSubCategoryIdController.clear();
    applicableProductIdController.clear();
  }

  void selectSubCategory(SubCategoryModel subCategory) {
    selectedSubCategory.value = subCategory;
    applicableSubCategoryIdController.text = subCategory.id;
    // Reset product when subcategory changes
    selectedProduct.value = null;
    applicableProductIdController.clear();
  }
  void selectProduct(ProductModel product) {
    selectedProduct.value = product;
    applicableProductIdController.text = product.id;
  }



  // Get IDs ##########


  final RxString couponCode = ''.obs;
  final RxDouble totalAmount = 0.0.obs; // Total amount of the user's order
  final RxDouble discountedAmount = 0.0.obs; // Discounted amount after applying the coupon

  // Apply Coupon
  Future<void> applyCoupon(String couponCode) async {
    try {
      final couponSnapshot = await _firestore
          .collection('Coupons')
          .where('code', isEqualTo: couponCode)
          .limit(1)
          .get();

      if (couponSnapshot.docs.isNotEmpty) {
        final couponData = couponSnapshot.docs.first.data();
        final coupon = CouponModel.fromJson(couponData);

        // Validate the coupon
        if (validateCoupon(coupon)) {
          final discount = calculateDiscount(coupon);
          discountedAmount.value = totalAmount.value - discount;
          Get.snackbar('Success', 'Coupon applied successfully',
              backgroundColor: Colors.green, colorText: Colors.white);

          // Optionally, you can update the coupon usage count here
          incrementUsageCount(coupon.id!);
        } else {
          Get.snackbar('Error', 'Invalid or expired coupon',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar('Error', 'Coupon not found',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to apply coupon: $error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Validate Coupon
  bool validateCoupon(CouponModel coupon) {
    final now = DateTime.now();
    return coupon.expiryDate != null &&
        coupon.expiryDate!.isAfter(now) &&
        coupon.status == 'active';
  }

  // Calculate Discount
  double calculateDiscount(CouponModel coupon) {
    double discount = 0.0;

    if (coupon.discountType == 'percentage') {
      discount = totalAmount.value * (coupon.discountAmount ?? 0) / 100;
    } else if (coupon.discountType == 'fixed') {
      discount = coupon.discountAmount ?? 0;
    }

    // Ensure discount does not exceed total amount
    return discount > totalAmount.value ? totalAmount.value : discount;
  }

  // Increment coupon usage count
  Future<void> incrementUsageCount(String couponId) async {
    try {
      final couponRef = _firestore.collection('Coupons').doc(couponId);
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(couponRef);
        final coupon = CouponModel.fromJson(snapshot.data()!);
        await transaction.update(couponRef, {
          'usageCount': coupon.usageCount + 1,
        });
      });
    } catch (error) {
      Get.snackbar('Error', 'Failed to update coupon usage: $error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void clearForm() {
    codeController.clear();
    discountTypeController.clear();
    discountAmountController.clear();
    minimumPurchaseAmountController.clear();
    expiryDateController.clear();
    statusController.clear();
    applicableCategoryIdController.clear();
    applicableSubCategoryIdController.clear();
    applicableProductIdController.clear();
    selectedCoupon = null;
    update();
  }
}
