import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/helpers_functions.dart';
import '../../shop/models/cart/cart_item_model.dart';
import 'address_model.dart';

class OrderModel
{
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  

  OrderModel({
  required this.id,
  this.userId = '',
  required this.status,
  required this.items,
  required this.totalAmount,
  required this.orderDate,
  this.paymentMethod = 'Paypal',
  this.address,
  this.deliveryDate,
});

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null ? THelperFunctions.getFormattedDate(deliveryDate!) :"";

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
      ? 'Shipment on the way'
      : 'Processing';

  Map<String,dynamic> toJson(){
    return {
      'id': id,
      'userId': userId,
     'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel. fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      status: OrderStatus.values.firstWhere((e) =>
      e.toString() == data['status']),
      totalAmount: data['totalAmount'] as double,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] as String,
      address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
      deliveryDate: data['deliveryDate'] == null
          ? null
          : (data['deliveryDate'] as Timestamp).toDate(),
      items: (data['items'] as List<dynamic>).map((itemData) =>
          CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
    ); // OrderModel
  }

   OrderModel copyWith({
    String? id,
    String? userId,
    OrderStatus? status,
    double? totalAmount,
    DateTime? orderDate,
    String? paymentMethod,
    AddressModel? address,
    DateTime? deliveryDate,
    List<CartItemModel>? items,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      orderDate: orderDate ?? this.orderDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      address: address ?? this.address,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      items: items ?? this.items,
    );
  }


  factory OrderModel.fromQuerySnapshot(DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>;
  print('Order ID from Firestore: ${data['id']}'); // Debug log

  return OrderModel(
    id: data['id'] as String,
    userId: data['userId'] as String,
    status: OrderStatus.values.firstWhere((e) => e.toString() == data['status']),
    totalAmount: data['totalAmount'] as double,
    orderDate: (data['orderDate'] as Timestamp).toDate(),
    paymentMethod: data['paymentMethod'] as String,
    address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
    deliveryDate: data['deliveryDate'] == null ? null : (data['deliveryDate'] as Timestamp).toDate(),
    items: (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
  );
}



}