import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/enums.dart';
import 'controller/admin_order_controller.dart';

class AdminOrderPanel extends StatelessWidget {
  final AdminOrderController orderController = Get.put(AdminOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel')),
      body: Obx(() {
        if (orderController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (orderController.errorMessage.isNotEmpty) {
          return Center(child: Text(orderController.errorMessage.value));
        }

        if (orderController.orders.isEmpty) {
          return Center(child: Text('No orders found'));
        }

        return
            //  ListView.builder(
            //   itemCount: orderController.orders.length,
            //   itemBuilder: (context, index) {
            //     final order = orderController.orders[index];
            //     return ListTile(
            //       title: Text('Order ID: ${order.id}'),
            //       subtitle: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text('Status: ${order.orderStatusText}'),
            //           Text('Total Amount: ${order.totalAmount.toStringAsFixed(2)}'),
            //           Text('Order Date: ${order.formattedOrderDate}'),
            //           Text('Payment Method: ${order.paymentMethod}'),
            //           Text('Delivery Date: ${order.formattedDeliveryDate}'),
            //         ],
            //       ),
            //       trailing: PopupMenuButton<OrderStatus>(
            //         onSelected: (status) {
            //           orderController.updateOrderStatus(
            //               order.userId, order.id, status);
            //         },
            //         itemBuilder: (context) => [
            //           PopupMenuItem(
            //             value: OrderStatus.processing,
            //             child: Text('Processing'),
            //           ),
            //           PopupMenuItem(
            //             value: OrderStatus.shipped,
            //             child: Text('Shipped'),
            //           ),
            //           PopupMenuItem(
            //             value: OrderStatus.delivered,
            //             child: Text('Delivered'),
            //           ),
            //         ],
            //       ),
            //       onLongPress: () {
            //         showDialog(
            //           context: context,
            //           builder: (context) => AlertDialog(
            //             title: Text('Delete Order'),
            //             content:
            //                 Text('Are you sure you want to delete this order?'),
            //             actions: [
            //               TextButton(
            //                 onPressed: () => Navigator.of(context).pop(),
            //                 child: Text('Cancel'),
            //               ),
            //               TextButton(
            //                 onPressed: () {
            //                   orderController.deleteOrder(order.userId, order.id);
            //                   Navigator.of(context).pop();
            //                 },
            //                 child: Text('Delete'),
            //               ),
            //             ],
            //           ),
            //         );
            //       },
            //     );
            //   },
            // );
            ListView.builder(
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) {
            final order = orderController.orders[index];
            return ListTile(
              title: Text('Order ID: ${order.id}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status: ${order.orderStatusText}'),
                  Text('Total Amount: ${order.totalAmount.toStringAsFixed(2)}'),
                  Text('Order Date: ${order.formattedOrderDate}'),
                  Text('Payment Method: ${order.paymentMethod}'),
                  Text('Delivery Date: ${order.formattedDeliveryDate}'),
                  SizedBox(height: 8), // Add some space before listing items
                  Text('Items:'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: order.items
                        .map((item) => Text(
                            '${item.quantity} x ${item.title} - ${item.price.toStringAsFixed(2)}'))
                        .toList(),
                  ),
                ],
              ),
              trailing: PopupMenuButton<OrderStatus>(
                onSelected: (status) {
                  orderController.updateOrderStatus(
                      order.userId, order.id, status);
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: OrderStatus.processing,
                    child: Text('Processing'),
                  ),
                  PopupMenuItem(
                    value: OrderStatus.shipped,
                    child: Text('Shipped'),
                  ),
                  PopupMenuItem(
                    value: OrderStatus.delivered,
                    child: Text('Delivered'),
                  ),
                ],
              ),
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Delete Order'),
                    content:
                        Text('Are you sure you want to delete this order?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          orderController.deleteOrder(order.userId, order.id);
                          Navigator.of(context).pop();
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
