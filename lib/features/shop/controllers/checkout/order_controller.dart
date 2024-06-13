import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/zBottom_navigation_bar/navigation_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/address_controller.dart';
import '../../../personalization/models/order.dart';
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



