// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../features/personalization/models/order.dart';
// import '../../utils/constants/enums.dart';

// enum OrderStatuss { processing, shipped, delivered }

// class OrderModels {
//   final String id;
//   final String userId;
//   final double totalAmount;
//   final DateTime orderDate;
//   final OrderStatuss status;
//   final String paymentMethod;
//   final DateTime deliveryDate;

//   OrderModels({
//     required this.id,
//     required this.userId,
//     required this.totalAmount,
//     required this.orderDate,
//     required this.status,
//     required this.paymentMethod,
//     required this.deliveryDate,
//   });

//   factory OrderModels.fromQuerySnapshot(DocumentSnapshot doc) {
//     return OrderModels(
//       id: doc.id,
//       userId: doc['userId'],
//       totalAmount: doc['totalAmount'],
//       orderDate: (doc['orderDate'] as Timestamp).toDate(),
//       status:
//           OrderStatuss.values.firstWhere((e) => e.toString() == doc['status']),
//       paymentMethod: doc['paymentMethod'],
//       deliveryDate: (doc['deliveryDate'] as Timestamp).toDate(),
//     );
//   }

//   OrderModels copyWith({OrderStatuss? status}) {
//     return OrderModels(
//       id: id,
//       userId: userId,
//       totalAmount: totalAmount,
//       orderDate: orderDate,
//       status: status ?? this.status,
//       paymentMethod: paymentMethod,
//       deliveryDate: deliveryDate,
//     );
//   }

//   String get orderStatusText => status.toString().split('.').last;
//   String get formattedOrderDate =>
//       '${orderDate.day}/${orderDate.month}/${orderDate.year}';
//   String get formattedDeliveryDate =>
//       '${deliveryDate.day}/${deliveryDate.month}/${deliveryDate.year}';
// }

// class AdminOrderController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   var orders = <OrderModel>[].obs;
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;

//   // Helper method to convert the special order ID format to Firestore document ID
//   String _getFirestoreId(String orderId) {
//     return orderId.replaceAll(RegExp(r'[\[\]#]'), '');
//   }

//   // Helper method to convert Firestore document ID to the special order ID format
//   String _getSpecialOrderId(String firestoreId) {
//     return '[#$firestoreId]';
//   }

//   @override
//   void onInit() {
//     fetchOrders();
//     super.onInit();
//   }

//   void fetchOrders() async {
//     try {
//       isLoading(true);

//       QuerySnapshot userSnapshot = await _firestore.collection('Users').get();
//       List<QueryDocumentSnapshot> userDocs = userSnapshot.docs;

//       List<OrderModel> fetchedOrders = [];
//       for (var userDoc in userDocs) {
//         QuerySnapshot orderSnapshot =
//             await userDoc.reference.collection('Orders').get();
//         var userOrders = orderSnapshot.docs.map((doc) {
//           print('Order ID from Firestore: ${doc.id}');
//           // Convert Firestore ID to special format when creating OrderModel
//           return OrderModel.fromQuerySnapshot(doc)
//               .copyWith(id: _getSpecialOrderId(doc.id));
//         }).toList();
//         fetchedOrders.addAll(userOrders);
//       }

//       orders.assignAll(fetchedOrders);
//     } catch (e) {
//       errorMessage('Failed to load orders: $e');
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> updateOrderStatus(
//       String userId, String orderId, OrderStatus newStatus) async {
//     try {
//       print(
//           'Updating order status - User ID: $userId, Order ID: $orderId, New Status: $newStatus');

//       // Convert the special order ID to Firestore ID
//       String firestoreOrderId = _getFirestoreId(orderId);
//       print('Converted Firestore Order ID: $firestoreOrderId');

//       // Construct the path using the Firestore order ID
//       String path = 'Users/$userId/Orders/$firestoreOrderId';
//       print('Document path: $path');

//       // Check if the document exists before updating
//       DocumentSnapshot docSnapshot = await _firestore.doc(path).get();
//       if (!docSnapshot.exists) {
//         print('Document does not exist: $path');
//         throw Exception('Document does not exist: $path');
//       }

//       print('Current document data: ${docSnapshot.data()}');

//       // Update the order status
//       await _firestore.doc(path).update({
//         'status': newStatus.toString(),
//       });

//       print('Order status updated successfully');

//       // Update the local list of orders
//       int index = orders
//           .indexWhere((order) => order.id == orderId && order.userId == userId);
//       if (index != -1) {
//         orders[index] = orders[index].copyWith(status: newStatus);
//         print('Local order list updated');
//       } else {
//         print(
//             'Order not found in local list. User ID: $userId, Order ID: $orderId');
//       }
//     } catch (e) {
//       print('Error updating order status: $e');
//       Get.snackbar('Error', 'Failed to update order status: $e');
//     }
//   }

//   Future<void> deleteOrder(String userId, String orderId) async {
//     try {
//       // Convert the special order ID to Firestore ID
//       String firestoreOrderId = _getFirestoreId(orderId);
//       String path = 'Users/$userId/Orders/$firestoreOrderId';
//       await _firestore.doc(path).delete();
//       orders.removeWhere(
//           (order) => order.id == orderId && order.userId == userId);
//       print('Order deleted successfully. User ID: $userId, Order ID: $orderId');
//     } catch (e) {
//       print('Error deleting order: $e');
//       Get.snackbar('Error', 'Failed to delete order: $e');
//     }
//   }
// }

// class AdminOrderPanel extends StatelessWidget {
//   final AdminOrderController orderController = Get.put(AdminOrderController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Admin Panel')),
//       body: Obx(() {
//         if (orderController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (orderController.errorMessage.isNotEmpty) {
//           return Center(child: Text(orderController.errorMessage.value));
//         }

//         if (orderController.orders.isEmpty) {
//           return Center(child: Text('No orders found'));
//         }

//         return ListView.builder(
//           itemCount: orderController.orders.length,
//           itemBuilder: (context, index) {
//             final order = orderController.orders[index];
//             return ListTile(
//               title: Text('Order ID: ${order.id}'),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Status: ${order.orderStatusText}'),
//                   Text('Total Amount: ${order.totalAmount.toStringAsFixed(2)}'),
//                   Text('Order Date: ${order.formattedOrderDate}'),
//                   Text('Payment Method: ${order.paymentMethod}'),
//                   Text('Delivery Date: ${order.formattedDeliveryDate}'),
//                 ],
//               ),
//               trailing: PopupMenuButton<OrderStatus>(
//                 onSelected: (status) {
//                   orderController.updateOrderStatus(
//                       order.userId, order.id, status);
//                 },
//                 itemBuilder: (context) => [
//                   PopupMenuItem(
//                     value: OrderStatus.processing,
//                     child: Text('Processing'),
//                   ),
//                   PopupMenuItem(
//                     value: OrderStatus.shipped,
//                     child: Text('Shipped'),
//                   ),
//                   PopupMenuItem(
//                     value: OrderStatus.delivered,
//                     child: Text('Delivered'),
//                   ),
//                 ],
//               ),
//               onLongPress: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: Text('Delete Order'),
//                     content:
//                         Text('Are you sure you want to delete this order?'),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.of(context).pop(),
//                         child: Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           orderController.deleteOrder(order.userId, order.id);
//                           Navigator.of(context).pop();
//                         },
//                         child: Text('Delete'),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       }),
//     );
//   }
// }


import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/shop/models/brand_model.dart';
import '../../features/shop/models/category_model.dart';
import '../../features/shop/models/product_attribute_model.dart';
import '../../features/shop/models/product_model.dart';

// class AdminPanelController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   // Text editing controllers
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController stockController = TextEditingController();
//   final TextEditingController skuController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController salePriceController = TextEditingController();
//   final TextEditingController productTypeController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController categoryIdController = TextEditingController();
//
//   // Brands list
//   RxList<NewBrandModel> brands = RxList<NewBrandModel>([]);
//   RxList<NewBrandModel> filteredBrands = RxList<NewBrandModel>([]);
//   Rx<NewBrandModel?> selectedBrand = Rx<NewBrandModel?>(null);
//
//   // Rx variables for images
//   Rx<File?> thumbnail = Rx<File?>(null);
//   RxList<File?> selectedImages = RxList<File?>([]);
//   Rx<bool> isFeatured = Rx<bool>(false);
//
//   // Uploaded image URLs
//   RxString thumbnailUrl = ''.obs;
//
//   // ImagePicker instance
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize any necessary data or fetch brands
//     fetchBrands();
//   }
//
//   // Fetch brands from Firestore
//   void fetchBrands() async {
//     try {
//       final brandsSnapshot = await _firestore.collection('Brands').get();
//       if (brandsSnapshot.docs.isNotEmpty) {
//         brands.assignAll(brandsSnapshot.docs.map((doc) => NewBrandModel.fromQuerySnapshot(doc)).toList());
//         filteredBrands.assignAll(brands);
//       }
//     } catch (error) {
//       print('Error fetching brands: $error');
//     }
//   }
//
//   // Method to filter brands based on search text
//   void filterBrands(String searchText) {
//     if (searchText.isEmpty) {
//       filteredBrands.assignAll(brands);
//     } else {
//       var filteredList = brands.where((brand) => brand.name.toLowerCase().contains(searchText.toLowerCase())).toList();
//       filteredBrands.assignAll(filteredList);
//     }
//   }
//
//   // Method to add a new product
//   Future<void> addProduct() async {
//     String? validationError = _validateProduct();
//     if (validationError != null) {
//       Get.snackbar('Error', validationError, backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//
//     List<String> imageUrls = await uploadImagesToFirebase(selectedImages.toList());
//     final newProductId = await _getNextProductId();
//
//     final product = ProductModel(
//       id: newProductId,
//       title: titleController.text.trim(),
//       stock: int.parse(stockController.text),
//       price: double.parse(priceController.text),
//       salePrice: double.parse(salePriceController.text),
//       sku: skuController.text.trim(),
//       thumbnail: thumbnailUrl.value,
//       productType: productTypeController.text.trim(),
//       description: descriptionController.text.trim(),
//       categoryId: categoryIdController.text.trim(),
//       images: imageUrls,
//       isFeatured: isFeatured.value,
//       brand: selectedBrand.value,
//       date: DateTime.now(),
//     );
//
//     try {
//       await _firestore.collection('Products').doc(newProductId).set(product.toJson());
//
//       if (selectedBrand.value != null) {
//         await _updateBrandProductCount(selectedBrand.value!.id);
//       }
//
//       Get.snackbar('Success', 'Product added successfully', backgroundColor: Colors.green, colorText: Colors.white);
//       _clearForm();
//     } catch (error) {
//       Get.snackbar('Error', 'Failed to add product: $error', backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }
//
//
//
//   Future<void> selectThumbnailImage() async {
//     try {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         File thumbnailFile = File(pickedFile.path);
//         String thumbnailUrl = await uploadThumbnailToFirebase(thumbnailFile);
//         if (thumbnailUrl.isNotEmpty) {
//           this.thumbnail.value = thumbnailFile;
//           this.thumbnailUrl.value = thumbnailUrl;
//         }
//       } else {
//         print('No image selected');
//       }
//     } catch (e) {
//       print('Error selecting thumbnail image: $e');
//     }
//   }
//
//   Future<String> uploadThumbnailToFirebase(File thumbnailFile) async {
//     try {
//       String fileName = '${DateTime.now().millisecondsSinceEpoch}_thumbnail';
//       Reference ref = _storage.ref().child('thumbnails').child(fileName);
//
//       TaskSnapshot uploadTask;
//       if (kIsWeb) {
//         uploadTask = await ref.putData(await thumbnailFile.readAsBytes());
//       } else {
//         uploadTask = await ref.putFile(thumbnailFile);
//       }
//
//       String downloadUrl = await uploadTask.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print('Error uploading thumbnail: $e');
//       return '';
//     }
//   }
//   // Method to upload images to Firebase storage
//   Future<List<String>> uploadImagesToFirebase(List<File?> images) async {
//     List<String> downloadUrls = [];
//
//     try {
//       for (int i = 0; i < images.length; i++) {
//         File? image = images[i];
//         if (image != null) {
//           String fileName = '${DateTime.now().millisecondsSinceEpoch}_$i';
//           Reference ref = _storage.ref().child('images').child(fileName);
//
//           TaskSnapshot uploadTask = await ref.putFile(image);
//           String downloadUrl = await uploadTask.ref.getDownloadURL();
//           downloadUrls.add(downloadUrl);
//         }
//       }
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//
//     return downloadUrls;
//   }
//
//   // Method to validate product input
//   String? _validateProduct() {
//     if (titleController.text.trim().isEmpty) {
//       return 'Please enter a product title';
//     }
//     if (priceController.text.isEmpty || double.tryParse(priceController.text) == null) {
//       return 'Please enter a valid price';
//     }
//     if (stockController.text.isEmpty || int.tryParse(stockController.text) == null) {
//       return 'Please enter a valid stock quantity';
//     }
//     if (thumbnailUrl.value.isEmpty) {
//       return 'Please select a thumbnail image';
//     }
//     if (selectedBrand.value == null) {
//       return 'Please select a brand';
//     }
//     if (productTypeController.text.trim().isEmpty) {
//       return 'Please enter a product type';
//     }
//     if (categoryIdController.text.trim().isEmpty) {
//       return 'Please select a category';
//     }
//     return null; // Return null if all validations pass
//   }
//
//   // Method to get the next product ID
//   Future<String> _getNextProductId() async {
//     try {
//       final counterDoc = _firestore.collection('counters').doc('Products');
//       final snapshot = await counterDoc.get();
//
//       if (snapshot.exists) {
//         final data = snapshot.data()!;
//         final currentId = data['lastId'] as int;
//         final newId = currentId + 1;
//
//         await counterDoc.update({'lastId': newId});
//         return newId.toString().padLeft(3, '0'); // Pads the ID with zeros (e.g., 001, 002, etc.)
//       } else {
//         await counterDoc.set({'lastId': 1});
//         return '001';
//       }
//     } catch (e) {
//       print('Error getting next product ID: $e');
//       return '001'; // Return a default ID in case of error
//     }
//   }
//
//   // Method to update brand product count
//   Future<void> _updateBrandProductCount(String brandId) async {
//     try {
//       await _firestore.collection('Brands').doc(brandId).update({
//         'ProductsCount': FieldValue.increment(1),
//       });
//     } catch (e) {
//       print('Error updating brand product count: $e');
//     }
//   }
//
//   // Method to clear form fields
//   void _clearForm() {
//     titleController.clear();
//     stockController.clear();
//     skuController.clear();
//     priceController.clear();
//     salePriceController.clear();
//     productTypeController.clear();
//     descriptionController.clear();
//     categoryIdController.clear();
//     thumbnailUrl.value = '';
//     selectedImages.clear();
//     isFeatured.value = false;
//     selectedBrand.value = null;
//   }
// }


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/shop/models/product_variation_model.dart';
import '../../utils/constants/enums.dart';

///Very Perfectoo#########
// class AdminPanelController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   // Text editing controllers
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController stockController = TextEditingController();
//   final TextEditingController skuController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController salePriceController = TextEditingController();
//   final TextEditingController productTypeController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController categoryIdController = TextEditingController();
//   final TextEditingController thumbnailUrlController = TextEditingController();
//
//   // Brands list
//   RxList<NewBrandModel> brands = RxList<NewBrandModel>([]);
//   RxList<NewBrandModel> filteredBrands = RxList<NewBrandModel>([]);
//   Rx<NewBrandModel?> selectedBrand = Rx<NewBrandModel?>(null);
//
//   // Rx variables for images
//   RxList<File?> selectedImages = RxList<File?>([]);
//   Rx<bool> isFeatured = Rx<bool>(false);
//
//   // Uploaded image URLs
//   RxString thumbnailUrl = ''.obs;
//
//   // ImagePicker instance
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize any necessary data or fetch brands
//     fetchBrands();
//   }
//
//   // Fetch brands from Firestore
//   void fetchBrands() async {
//     try {
//       final brandsSnapshot = await _firestore.collection('Brands').get();
//       if (brandsSnapshot.docs.isNotEmpty) {
//         brands.assignAll(brandsSnapshot.docs.map((doc) => NewBrandModel.fromQuerySnapshot(doc)).toList());
//         filteredBrands.assignAll(brands);
//       }
//     } catch (error) {
//       print('Error fetching brands: $error');
//     }
//   }
//
//   // Method to filter brands based on search text
//   void filterBrands(String searchText) {
//     if (searchText.isEmpty) {
//       filteredBrands.assignAll(brands);
//     } else {
//       var filteredList = brands.where((brand) => brand.name.toLowerCase().contains(searchText.toLowerCase())).toList();
//       filteredBrands.assignAll(filteredList);
//     }
//   }
//
//   // Method to add a new product
//   Future<void> addProduct() async {
//     String? validationError = _validateProduct();
//     if (validationError != null) {
//       Get.snackbar('Error', validationError, backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//
//     List<String> imageUrls = await uploadImagesToFirebase(selectedImages.toList());
//     final newProductId = await _getNextProductId();
//
//     final product = ProductModel(
//       id: newProductId,
//       title: titleController.text.trim(),
//       stock: int.parse(stockController.text),
//       price: double.parse(priceController.text),
//       salePrice: double.parse(salePriceController.text),
//       sku: skuController.text.trim(),
//       thumbnail: thumbnailUrl.value,
//       productType: productTypeController.text.trim(),
//       description: descriptionController.text.trim(),
//       categoryId: categoryIdController.text.trim(),
//       images: imageUrls,
//       isFeatured: isFeatured.value,
//       brand: selectedBrand.value,
//       date: DateTime.now(),
//     );
//
//     try {
//       await _firestore.collection('Products').doc(newProductId).set(product.toJson());
//
//       if (selectedBrand.value != null) {
//         await _updateBrandProductCount(selectedBrand.value!.id);
//       }
//
//       Get.snackbar('Success', 'Product added successfully', backgroundColor: Colors.green, colorText: Colors.white);
//       _clearForm();
//     } catch (error) {
//       Get.snackbar('Error', 'Failed to add product: $error', backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }
//
//   // Method to select a brand
//   void selectBrand(NewBrandModel brand) {
//     selectedBrand.value = brand;
//   }
//
//   // Method to select thumbnail image from gallery
//   Future<void> selectThumbnailImage() async {
//     try {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         File thumbnailFile = File(pickedFile.path);
//         String thumbnailUrl = await uploadThumbnailToFirebase(thumbnailFile);
//         if (thumbnailUrl.isNotEmpty) {
//           this.thumbnailUrl.value = thumbnailUrl;
//         }
//       } else {
//         print('No image selected');
//       }
//     } catch (e) {
//       print('Error selecting thumbnail image: $e');
//     }
//   }
//
//   // Example of platform-specific upload code for thumbnail image
//   Future<String> uploadThumbnailToFirebase(File thumbnailFile) async {
//     try {
//       String fileName = '${DateTime.now().millisecondsSinceEpoch}_thumbnail';
//       Reference ref = _storage.ref().child('thumbnails').child(fileName);
//
//       TaskSnapshot uploadTask;
//       if (kIsWeb) {
//         // Web-specific upload method
//         uploadTask = await ref.putData(await thumbnailFile.readAsBytes());
//       } else {
//         // Mobile (Android/iOS) specific upload method
//         uploadTask = await ref.putFile(thumbnailFile);
//       }
//
//       String downloadUrl = await uploadTask.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print('Error uploading thumbnail: $e');
//       return '';
//     }
//   }
//
//   Future<List<String>> uploadImagesToFirebase(List<File?> images) async {
//     List<String> downloadUrls = [];
//
//     try {
//       for (int i = 0; i < images.length; i++) {
//         File? image = images[i];
//         if (image != null) {
//           String fileName = '${DateTime.now().millisecondsSinceEpoch}_$i';
//           Reference ref = _storage.ref().child('images').child(fileName);
//
//           TaskSnapshot uploadTask = await ref.putFile(image);
//           String downloadUrl = await uploadTask.ref.getDownloadURL();
//           downloadUrls.add(downloadUrl);
//         }
//       }
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//
//     return downloadUrls;
//   }
//
//   String? _validateProduct() {
//     if (titleController.text.trim().isEmpty) {
//       return 'Please enter a product title';
//     }
//     if (priceController.text.isEmpty || double.tryParse(priceController.text) == null) {
//       return 'Please enter a valid price';
//     }
//     if (stockController.text.isEmpty || int.tryParse(stockController.text) == null) {
//       return 'Please enter a valid stock quantity';
//     }
//     if (selectedBrand.value == null) {
//       return 'Please select a brand';
//     }
//     if (productTypeController.text.trim().isEmpty) {
//       return 'Please enter a product type';
//     }
//     if (categoryIdController.text.trim().isEmpty) {
//       return 'Please select a category';
//     }
//     return null;
//   }
//
//   Future<String> _getNextProductId() async {
//     try {
//       final counterDoc = _firestore.collection('counters').doc('Products');
//       final snapshot = await counterDoc.get();
//
//       if (snapshot.exists) {
//         final data = snapshot.data()!;
//         final currentId = data['lastId'] as int;
//         final newId = currentId + 1;
//
//         await counterDoc.update({'lastId': newId});
//         return newId.toString().padLeft(3, '0'); // Pads the ID with zeros (e.g., 001, 002, etc.)
//       } else {
//         await counterDoc.set({'lastId': 1});
//         return '001';
//       }
//     } catch (e) {
//       print('Error getting next product ID: $e');
//       return '001'; // Return a default ID in case of error
//     }
//   }
//
//   Future<void> _updateBrandProductCount(String brandId) async {
//     try {
//       await _firestore.collection('Brands').doc(brandId).update({
//         'ProductsCount': FieldValue.increment(1),
//       });
//     } catch (e) {
//       print('Error updating brand product count: $e');
//     }
//   }
//
//   void _clearForm() {
//     titleController.clear();
//     stockController.clear();
//     skuController.clear();
//     priceController.clear();
//     salePriceController.clear();
//     productTypeController.clear();
//     descriptionController.clear();
//     categoryIdController.clear();
//     thumbnailUrl.value = '';
//     thumbnailUrlController.clear();
//     selectedImages.clear();
//     isFeatured.value = false;
//     selectedBrand.value = null;
//   }
//
//   @override
//   void dispose() {
//     // Dispose controllers to avoid memory leaks
//     titleController.dispose();
//     stockController.dispose();
//     skuController.dispose();
//     priceController.dispose();
//     salePriceController.dispose();
//     productTypeController.dispose();
//     descriptionController.dispose();
//     categoryIdController.dispose();
//     thumbnailUrlController.dispose();
//
//     super.dispose();
//   }
// }



/// New Test
///
///
class AdminPanelController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Text editing controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  final TextEditingController thumbnailUrlController = TextEditingController();

  // Brands list
  RxList<NewBrandModel> brands = RxList<NewBrandModel>([]);
  RxList<NewBrandModel> filteredBrands = RxList<NewBrandModel>([]);
  Rx<NewBrandModel?> selectedBrand = Rx<NewBrandModel?>(null);

  // Product type
  Rx<ProductType> selectedProductType = ProductType.single.obs;

  // Rx variables for images
  RxList<File?> selectedImages = RxList<File?>([]);
  Rx<bool> isFeatured = Rx<bool>(false);

  // Uploaded image URLs
  RxString thumbnailUrl = ''.obs;

  // ImagePicker instance
  final ImagePicker _picker = ImagePicker();


  /// ---------- Attributes  & Variations
  ///
  // New variables for product attributes and variations
  RxList<ProductAttributeModel> productAttributes = RxList<ProductAttributeModel>([]);
  RxList<ProductVariationModel> productVariations = RxList<ProductVariationModel>([]);

  final TextEditingController attributeNameController = TextEditingController();
  final TextEditingController attributeValueController = TextEditingController();

  final TextEditingController variationIdController = TextEditingController();
  final TextEditingController variationStockController = TextEditingController();
  final TextEditingController variationPriceController = TextEditingController();
  final TextEditingController variationSalePriceController = TextEditingController();
  final TextEditingController variationDescriptionController = TextEditingController();
  final TextEditingController variationSkuController = TextEditingController();

  ///  ---------- Attributes  & Variations ---------------------------------


  ///  ---------- get Category ID  ---------------------------------


// Categories list
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxList<CategoryModel> filteredCategories = RxList<CategoryModel>([]);
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);


  void fetchCategories() async {
    try {
      final categoriesSnapshot = await _firestore.collection('Categories').get();
      if (categoriesSnapshot.docs.isNotEmpty) {
        categories.assignAll(categoriesSnapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList());
        filteredCategories.assignAll(categories);
      }
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  void filterCategories(String searchText) {
    if (searchText.isEmpty) {
      filteredCategories.assignAll(categories);
    } else {
      var filteredList = categories.where((category) => category.name.toLowerCase().contains(searchText.toLowerCase())).toList();
      filteredCategories.assignAll(filteredList);
    }
  }

  void selectCategory(CategoryModel category) {
    selectedCategory.value = category;
    categoryIdController.text = category.id; // Optionally set the ID in the controller
  }

  String? getCategoryIdByName(String categoryName) {
    var category = categories.firstWhere((cat) => cat.name.toLowerCase() == categoryName.toLowerCase(), orElse: () => CategoryModel.empty());
    return category.id;
  }

  ///  ---------- get Category ID  ---------------------------------
  ///
  ///
  ///
  ///
  ///

  @override
  void onInit() {
    super.onInit();
    // Initialize any necessary data or fetch brands
    fetchBrands();
    fetchCategories();
  }


  /// ---------- Attributes  & Variations ---------------------------------
  ///
  ///
  ///
  ///
  // new

  // Updated method to add product attribute
  void addProductAttribute() {
    String name = attributeNameController.text.trim();
    String value = attributeValueController.text.trim();
    if (name.isNotEmpty && value.isNotEmpty) {
      var existingAttribute = productAttributes.firstWhere(
            (attr) => attr.name == name,
        orElse: () => ProductAttributeModel(name: name, values: []),
      );
      if (!existingAttribute.values!.contains(value)) {
        existingAttribute.values!.add(value);
      }
      if (!productAttributes.contains(existingAttribute)) {
        productAttributes.add(existingAttribute);
      }
      attributeNameController.clear();
      attributeValueController.clear();
    }
  }

  void removeProductAttribute(ProductAttributeModel attribute) {
    productAttributes.remove(attribute);
    // Remove this attribute from all variations
    for (var variation in productVariations) {
      variation.attributeValues.remove(attribute.name);
    }
  }

  void addProductVariation() {
    if (productAttributes.isEmpty) {
      Get.snackbar('Error', 'Please add at least one product attribute first');
      return;
    }

    Map<String, String> attributeValues = {};
    for (var attribute in productAttributes) {
      attributeValues[attribute.name!] = attribute.values!.first; // Default to first value
    }

    productVariations.add(ProductVariationModel(
      id: variationIdController.text.isEmpty ? DateTime.now().millisecondsSinceEpoch.toString() : variationIdController.text,
      stock: int.tryParse(variationStockController.text) ?? 0,
      price: double.tryParse(variationPriceController.text) ?? 0.0,
      salePrice: double.tryParse(variationSalePriceController.text) ?? 0.0,
      description: variationDescriptionController.text,
      sku: variationSkuController.text,
      attributeValues: attributeValues,
    ));

    variationIdController.clear();
    variationStockController.clear();
    variationPriceController.clear();
    variationSalePriceController.clear();
    variationDescriptionController.clear();
    variationSkuController.clear();
  }
  void updateVariationAttributeValue(ProductVariationModel variation, String attributeName, String newValue) {
    variation.attributeValues[attributeName] = newValue;
    productVariations.refresh();
  }

  void removeProductVariation(ProductVariationModel variation) {
    productVariations.remove(variation);
  }
  ///
  ///
  ///
  ///  ---------- Attributes  & Variations ---------------------------------

  // Fetch brands from Firestore
  void fetchBrands() async {
    try {
      final brandsSnapshot = await _firestore.collection('Brands').get();
      if (brandsSnapshot.docs.isNotEmpty) {
        brands.assignAll(brandsSnapshot.docs.map((doc) => NewBrandModel.fromQuerySnapshot(doc)).toList());
        filteredBrands.assignAll(brands);
      }
    } catch (error) {
      print('Error fetching brands: $error');
    }
  }

  // Method to filter brands based on search text
  void filterBrands(String searchText) {
    if (searchText.isEmpty) {
      filteredBrands.assignAll(brands);
    } else {
      var filteredList = brands.where((brand) => brand.name.toLowerCase().contains(searchText.toLowerCase())).toList();
      filteredBrands.assignAll(filteredList);
    }
  }

  // Method to add a new product
  Future<void> addProduct() async {
    String? validationError = _validateProduct();
    if (validationError != null) {
      Get.snackbar('Error', validationError, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    List<String> imageUrls = await uploadImagesToFirebase(selectedImages.toList());
    final newProductId = await _getNextProductId();

    final product = ProductModel(
      id: newProductId,
      title: titleController.text.trim(),
      stock: int.parse(stockController.text),
      price: double.parse(priceController.text),
      salePrice: double.parse(salePriceController.text),
      sku: skuController.text.trim(),
      thumbnail: thumbnailUrl.value,
      productType: selectedProductType.value,
      description: descriptionController.text.trim(),
      categoryId: categoryIdController.text.trim(),
      images: imageUrls,
      isFeatured: isFeatured.value,
      brand: selectedBrand.value,
      date: DateTime.now(),
      productAttributes: productAttributes,
      productVariations: productVariations,
    );

    try {
      await _firestore.collection('Products').doc(newProductId).set(product.toJson());

      if (selectedBrand.value != null) {
        await _updateBrandProductCount(selectedBrand.value!.id);
      }

      Get.snackbar('Success', 'Product added successfully', backgroundColor: Colors.green, colorText: Colors.white);
      _clearForm();
    } catch (error) {
      Get.snackbar('Error', 'Failed to add product: $error', backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Method to select a brand
  void selectBrand(NewBrandModel brand) {
    selectedBrand.value = brand;
  }

  // Method to select thumbnail image from gallery
  Future<void> selectThumbnailImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File thumbnailFile = File(pickedFile.path);
        String thumbnailUrl = await uploadThumbnailToFirebase(thumbnailFile);
        if (thumbnailUrl.isNotEmpty) {
          this.thumbnailUrl.value = thumbnailUrl;
        }
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error selecting thumbnail image: $e');
    }
  }

  // Example of platform-specific upload code for thumbnail image
  Future<String> uploadThumbnailToFirebase(File thumbnailFile) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}_thumbnail';
      Reference ref = _storage.ref().child('thumbnails').child(fileName);

      TaskSnapshot uploadTask;
      if (kIsWeb) {
        // Web-specific upload method
        uploadTask = await ref.putData(await thumbnailFile.readAsBytes());
      } else {
        // Mobile (Android/iOS) specific upload method
        uploadTask = await ref.putFile(thumbnailFile);
      }

      String downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading thumbnail: $e');
      return '';
    }
  }

  Future<List<String>> uploadImagesToFirebase(List<File?> images) async {
    List<String> downloadUrls = [];

    try {
      for (int i = 0; i < images.length; i++) {
        File? image = images[i];
        if (image != null) {
          String fileName = '${DateTime.now().millisecondsSinceEpoch}_$i';
          Reference ref = _storage.ref().child('images').child(fileName);

          TaskSnapshot uploadTask = await ref.putFile(image);
          String downloadUrl = await uploadTask.ref.getDownloadURL();
          downloadUrls.add(downloadUrl);
        }
      }
    } catch (e) {
      print('Error uploading image: $e');
    }

    return downloadUrls;
  }

  String? _validateProduct() {
    if (titleController.text.trim().isEmpty) {
      return 'Please enter a product title';
    }
    if (priceController.text.isEmpty || double.tryParse(priceController.text) == null) {
      return 'Please enter a valid price';
    }
    if (stockController.text.isEmpty || int.tryParse(stockController.text) == null) {
      return 'Please enter a valid stock quantity';
    }
    if (selectedBrand.value == null) {
      return 'Please select a brand';
    }
    if (categoryIdController.text.trim().isEmpty) {
      return 'Please select a category';
    }
    return null;
  }

  Future<String> _getNextProductId() async {
    try {
      final counterDoc = _firestore.collection('counters').doc('Products');
      final snapshot = await counterDoc.get();

      if (snapshot.exists) {
        final data = snapshot.data()!;
        final currentId = data['lastId'] as int;
        final newId = currentId + 1;

        await counterDoc.update({'lastId': newId});
        return newId.toString().padLeft(3, '0'); // Pads the ID with zeros (e.g., 001, 002, etc.)
      } else {
        await counterDoc.set({'lastId': 1});
        return '001';
      }
    } catch (e) {
      print('Error getting next product ID: $e');
      return '001'; // Return a default ID in case of error
    }
  }

  Future<void> _updateBrandProductCount(String brandId) async {
    try {
      await _firestore.collection('Brands').doc(brandId).update({
        'ProductsCount': FieldValue.increment(1),
      });
    } catch (e) {
      print('Error updating brand product count: $e');
    }
  }

  void _clearForm() {
    titleController.clear();
    stockController.clear();
    skuController.clear();
    priceController.clear();
    salePriceController.clear();
    descriptionController.clear();
    categoryIdController.clear();
    thumbnailUrl.value = '';
    thumbnailUrlController.clear();
    selectedImages.clear();
    isFeatured.value = false;
    selectedBrand.value = null;
    selectedProductType.value = ProductType.single;
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    titleController.dispose();
    stockController.dispose();
    skuController.dispose();
    priceController.dispose();
    salePriceController.dispose();
    descriptionController.dispose();
    categoryIdController.dispose();
    thumbnailUrlController.dispose();
    categoryIdController.dispose();

    super.dispose();
  }
}
