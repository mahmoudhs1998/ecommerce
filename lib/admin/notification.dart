// Models

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyNotification {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final DateTime sentAt;
  final int totalSend;
  final int totalOpened;
  final int totalFailed;
  final int totalError;

  MyNotification({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.sentAt,
    this.totalSend = 0,
    this.totalOpened = 0,
    this.totalFailed = 0,
    this.totalError = 0,
  });

  factory MyNotification.fromJson(Map<String, dynamic> json) {
    return MyNotification(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      sentAt: (json['sentAt'] as Timestamp).toDate(),
      totalSend: json['totalSend'] ?? 0,
      totalOpened: json['totalOpened'] ?? 0,
      totalFailed: json['totalFailed'] ?? 0,
      totalError: json['totalError'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'sentAt': Timestamp.fromDate(sentAt),
      'totalSend': totalSend,
      'totalOpened': totalOpened,
      'totalFailed': totalFailed,
      'totalError': totalError,
    };
  }
}
// Controllers

class NotificationController extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxList<MyNotification> notifications = <MyNotification>[].obs;
  final Rx<MyNotification?> selectedNotification = Rx<MyNotification?>(null);

  final titleCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final imageUrlCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initializeFirebaseMessaging();
    fetchNotifications();
  }

  Future<void> initializeFirebaseMessaging() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received message: ${message.notification?.title}");
      // Handle foreground messages here
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Message opened app: ${message.notification?.title}");
      // Handle when the app is opened from a notification
    });
  }

  Future<void> fetchNotifications() async {
    try {
      final querySnapshot = await _firestore.collection('notifications').orderBy('sentAt', descending: true).get();
      notifications.value = querySnapshot.docs.map((doc) => MyNotification.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error fetching notifications: $e");
    }
  }

  Future<void> sendNotification() async {
    if (titleCtrl.text.isEmpty || descriptionCtrl.text.isEmpty) {
      Get.snackbar('Error', 'Title and description are required.');
      return;
    }

    final notification = MyNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleCtrl.text,
      description: descriptionCtrl.text,
      imageUrl: imageUrlCtrl.text.isNotEmpty ? imageUrlCtrl.text : null,
      sentAt: DateTime.now(),
    );

    try {
      await _firestore.collection('notifications').doc(notification.id).set(notification.toJson());
      await fetchNotifications();
      Get.back(); // Close the dialog
      Get.snackbar('Success', 'Notification sent successfully.');
    } catch (e) {
      print("Error sending notification: $e");
      Get.snackbar('Error', 'Failed to send notification.');
    }

    titleCtrl.clear();
    descriptionCtrl.clear();
    imageUrlCtrl.clear();
  }

  void selectNotification(MyNotification notification) {
    selectedNotification.value = notification;
  }

  void clearSelection() {
    selectedNotification.value = null;
  }
}

// UI Components

class NotificationListView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      itemCount: controller.notifications.length,
      itemBuilder: (context, index) {
        final notification = controller.notifications[index];
        return ListTile(
          title: Text(notification.title),
          subtitle: Text(notification.description),
          trailing: Text(notification.sentAt.toString()),
          onTap: () => controller.selectNotification(notification),
        );
      },
    ));
  }
}
class SendNotificationForm extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: controller.titleCtrl,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextFormField(
            controller: controller.descriptionCtrl,
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
          TextFormField(
            controller: controller.imageUrlCtrl,
            decoration: InputDecoration(labelText: 'Image URL (optional)'),
          ),
          ElevatedButton(
            onPressed: controller.sendNotification,
            child: Text('Send Notification'),
          ),
        ],
      ),
    );
  }
}
class NotificationDetailsView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final notification = controller.selectedNotification.value;
      if (notification == null) {
        return Center(child: Text('No notification selected'));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Title: ${notification.title}'),
          Text('Description: ${notification.description}'),
          if (notification.imageUrl != null) Image.network(notification.imageUrl!),
          Text('Sent at: ${notification.sentAt}'),
          Text('Total sent: ${notification.totalSend}'),
          Text('Total opened: ${notification.totalOpened}'),
          Text('Total failed: ${notification.totalFailed}'),
          Text('Total errors: ${notification.totalError}'),
        ],
      );
    });
  }
}

class NotificationHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: NotificationListView(),
          ),
          Expanded(
            flex: 3,
            child: NotificationDetailsView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.dialog(AlertDialog(
          content: SendNotificationForm(),
        )),
        child: Icon(Icons.add),
      ),
    );
  }
}