// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:get/get.dart';
// //
// // import '../../../features/personalization/models/order.dart';
// // import '../../../utils/constants/enums.dart';
// //
// // class AdminOrderController extends GetxController {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   var orders = <OrderModel>[].obs;
// //   var isLoading = true.obs;
// //   var errorMessage = ''.obs;
// //
// //   // Helper method to convert the special order ID format to Firestore document ID
// //   String _getFirestoreId(String orderId) {
// //     return orderId.replaceAll(RegExp(r'[\[\]#]'), '');
// //   }
// //
// //   // Helper method to convert Firestore document ID to the special order ID format
// //   String _getSpecialOrderId(String firestoreId) {
// //     return '[#$firestoreId]';
// //   }
// //
// //   @override
// //   void onInit() {
// //     fetchOrders();
// //     super.onInit();
// //   }
// //
// //   void fetchOrders() async {
// //     try {
// //       isLoading(true);
// //
// //       QuerySnapshot userSnapshot = await _firestore.collection('Users').get();
// //       List<QueryDocumentSnapshot> userDocs = userSnapshot.docs;
// //
// //       List<OrderModel> fetchedOrders = [];
// //       for (var userDoc in userDocs) {
// //         QuerySnapshot orderSnapshot =
// //             await userDoc.reference.collection('Orders').get();
// //         var userOrders = orderSnapshot.docs.map((doc) {
// //           print('Order ID from Firestore: ${doc.id}');
// //           // Convert Firestore ID to special format when creating OrderModel
// //           return OrderModel.fromQuerySnapshot(doc)
// //               .copyWith(id: _getSpecialOrderId(doc.id));
// //         }).toList();
// //         fetchedOrders.addAll(userOrders);
// //       }
// //
// //       orders.assignAll(fetchedOrders);
// //     } catch (e) {
// //       errorMessage('Failed to load orders: $e');
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// //
// //   Future<void> updateOrderStatus(
// //       String userId, String orderId, OrderStatus newStatus) async {
// //     try {
// //       print(
// //           'Updating order status - User ID: $userId, Order ID: $orderId, New Status: $newStatus');
// //
// //       // Convert the special order ID to Firestore ID
// //       String firestoreOrderId = _getFirestoreId(orderId);
// //       print('Converted Firestore Order ID: $firestoreOrderId');
// //
// //       // Construct the path using the Firestore order ID
// //       String path = 'Users/$userId/Orders/$firestoreOrderId';
// //       print('Document path: $path');
// //
// //       // Check if the document exists before updating
// //       DocumentSnapshot docSnapshot = await _firestore.doc(path).get();
// //       if (!docSnapshot.exists) {
// //         print('Document does not exist: $path');
// //         throw Exception('Document does not exist: $path');
// //       }
// //
// //       print('Current document data: ${docSnapshot.data()}');
// //
// //       // Update the order status
// //       await _firestore.doc(path).update({
// //         'status': newStatus.toString(),
// //       });
// //
// //       print('Order status updated successfully');
// //
// //       // Update the local list of orders
// //       int index = orders
// //           .indexWhere((order) => order.id == orderId && order.userId == userId);
// //       if (index != -1) {
// //         orders[index] = orders[index].copyWith(status: newStatus);
// //         print('Local order list updated');
// //       } else {
// //         print(
// //             'Order not found in local list. User ID: $userId, Order ID: $orderId');
// //       }
// //     } catch (e) {
// //       print('Error updating order status: $e');
// //       Get.snackbar('Error', 'Failed to update order status: $e');
// //     }
// //   }
// //
// //   Future<void> deleteOrder(String userId, String orderId) async {
// //     try {
// //       // Convert the special order ID to Firestore ID
// //       String firestoreOrderId = _getFirestoreId(orderId);
// //       String path = 'Users/$userId/Orders/$firestoreOrderId';
// //       await _firestore.doc(path).delete();
// //       orders.removeWhere(
// //           (order) => order.id == orderId && order.userId == userId);
// //       print('Order deleted successfully. User ID: $userId, Order ID: $orderId');
// //     } catch (e) {
// //       print('Error deleting order: $e');
// //       Get.snackbar('Error', 'Failed to delete order: $e');
// //     }
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
//
// import '../../../features/personalization/models/order.dart';
// import '../../../utils/constants/enums.dart';
//
// class AdminOrderController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   var orders = <OrderModel>[].obs;
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;
//
//   String _getFirestoreId(String orderId) {
//     return orderId.replaceAll(RegExp(r'[\[\]#]'), '');
//   }
//
//   String _getSpecialOrderId(String firestoreId) {
//     return '[#$firestoreId]';
//   }
//
//   @override
//   void onInit() {
//     fetchOrders();
//     super.onInit();
//   }
//
//   void fetchOrders() async {
//     try {
//       isLoading(true);
//
//       QuerySnapshot userSnapshot = await _firestore.collection('Users').get();
//       List<QueryDocumentSnapshot> userDocs = userSnapshot.docs;
//
//       List<OrderModel> fetchedOrders = [];
//       for (var userDoc in userDocs) {
//         var userData = userDoc.data() as Map<String, dynamic>;
//         var userName = userData['userName'] as String?;
//         QuerySnapshot orderSnapshot =
//         await userDoc.reference.collection('Orders').get();
//         var userOrders = orderSnapshot.docs.map((doc) async {
//           print('Order ID from Firestore: ${doc.id}');
//           return OrderModel.fromQuerySnapshot(doc)
//               .copyWith(id: _getSpecialOrderId(doc.id), userName: userName);
//         }).toList();
//         fetchedOrders.addAll(await Future.wait(userOrders));
//       }
//
//       orders.assignAll(fetchedOrders);
//     } catch (e) {
//       errorMessage('Failed to load orders: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> updateOrderStatus(
//       String userId, String orderId, OrderStatus newStatus) async {
//     try {
//       print('Updating order status - User ID: $userId, Order ID: $orderId, New Status: $newStatus');
//
//       String firestoreOrderId = _getFirestoreId(orderId);
//       print('Converted Firestore Order ID: $firestoreOrderId');
//
//       String path = 'Users/$userId/Orders/$firestoreOrderId';
//       print('Document path: $path');
//
//       DocumentSnapshot docSnapshot = await _firestore.doc(path).get();
//       if (!docSnapshot.exists) {
//         print('Document does not exist: $path');
//         throw Exception('Document does not exist: $path');
//       }
//
//       print('Current document data: ${docSnapshot.data()}');
//
//       await _firestore.doc(path).update({
//         'status': newStatus.toString(),
//       });
//
//       print('Order status updated successfully');
//
//       int index = orders.indexWhere((order) => order.id == orderId && order.userId == userId);
//       if (index != -1) {
//         orders[index] = orders[index].copyWith(status: newStatus);
//         print('Local order list updated');
//       } else {
//         print('Order not found in local list. User ID: $userId, Order ID: $orderId');
//       }
//     } catch (e) {
//       print('Error updating order status: $e');
//       Get.snackbar('Error', 'Failed to update order status: $e');
//     }
//   }
//
//   Future<void> deleteOrder(String userId, String orderId) async {
//     try {
//       String firestoreOrderId = _getFirestoreId(orderId);
//       String path = 'Users/$userId/Orders/$firestoreOrderId';
//       await _firestore.doc(path).delete();
//       orders.removeWhere((order) => order.id == orderId && order.userId == userId);
//       print('Order deleted successfully. User ID: $userId, Order ID: $orderId');
//     } catch (e) {
//       print('Error deleting order: $e');
//       Get.snackbar('Error', 'Failed to delete order: $e');
//     }
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/order.dart';
import '../../../utils/constants/enums.dart';

class AdminOrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var orders = <OrderModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  String _getFirestoreId(String orderId) {
    return orderId.replaceAll(RegExp(r'[\[\]#]'), '');
  }

  String _getSpecialOrderId(String firestoreId) {
    return '[#$firestoreId]';
  }

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  void fetchOrders() async {
    try {
      isLoading(true);

      QuerySnapshot userSnapshot = await _firestore.collection('Users').get();
      List<QueryDocumentSnapshot> userDocs = userSnapshot.docs;

      List<OrderModel> fetchedOrders = [];
      for (var userDoc in userDocs) {
        var userData = userDoc.data() as Map<String, dynamic>;
        var userName = userData['userName'] as String?;
        QuerySnapshot orderSnapshot =
        await userDoc.reference.collection('Orders').get();
        var userOrders = orderSnapshot.docs.map((doc) async {
          print('Order ID from Firestore: ${doc.id}');
          return OrderModel.fromQuerySnapshot(doc).copyWith(
            id: _getSpecialOrderId(doc.id),
            userName: userName,
          );
        }).toList();
        fetchedOrders.addAll(await Future.wait(userOrders));
      }

      orders.assignAll(fetchedOrders);
    } catch (e) {
      errorMessage('Failed to load orders: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateOrderStatus(
      String userId, String orderId, OrderStatus newStatus) async {
    try {
      print(
          'Updating order status - User ID: $userId, Order ID: $orderId, New Status: $newStatus');

      String firestoreOrderId = _getFirestoreId(orderId);
      print('Converted Firestore Order ID: $firestoreOrderId');

      String path = 'Users/$userId/Orders/$firestoreOrderId';
      print('Document path: $path');

      DocumentSnapshot docSnapshot = await _firestore.doc(path).get();
      if (!docSnapshot.exists) {
        print('Document does not exist: $path');
        throw Exception('Document does not exist: $path');
      }

      print('Current document data: ${docSnapshot.data()}');

      await _firestore.doc(path).update({
        'status': newStatus.toString(),
        'deliveryDate': newStatus == OrderStatus.delivered ? Timestamp.now() : FieldValue.delete(),
      });

      print('Order status updated successfully');

      int index = orders.indexWhere(
              (order) => order.id == orderId && order.userId == userId);
      if (index != -1) {
        orders[index] = orders[index].copyWith(status: newStatus);
        print('Local order list updated');
      } else {
        print(
            'Order not found in local list. User ID: $userId, Order ID: $orderId');
      }
    } catch (e) {
      print('Error updating order status: $e');
      Get.snackbar('Error', 'Failed to update order status: $e');
    }
  }

  Future<void> deleteOrder(String userId, String orderId) async {
    try {
      String firestoreOrderId = _getFirestoreId(orderId);
      String path = 'Users/$userId/Orders/$firestoreOrderId';
      await _firestore.doc(path).delete();
      orders.removeWhere(
              (order) => order.id == orderId && order.userId == userId);
      print(
          'Order deleted successfully. User ID: $userId, Order ID: $orderId');
    } catch (e) {
      print('Error deleting order: $e');
      Get.snackbar('Error', 'Failed to delete order: $e');
    }
  }
}
