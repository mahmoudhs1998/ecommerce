import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';


class FCMService extends GetxService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<FCMService> init() async {
    try {
      if (!kIsWeb) {
        NotificationSettings settings = await _firebaseMessaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );
        print('User granted permission: ${settings.authorizationStatus}');
      }

      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        print('FCM Token: $token');
      } else {
        print('Failed to retrieve FCM Token');
      }

      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
        print('FCM Token refreshed: $newToken');
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification?.title}');
          LocalNotificationService.displayLocalNotification(
            title: message.notification!.title ?? "No Title",
            body: message.notification!.body ?? "No Body",
          );
        }
      });

      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      print('FCM initialized successfully');
    } catch (e) {
      print('Error initializing FCM: $e');
    }
    return this;
  }

  Future<void> testFCM() async {
    print("Testing FCM");
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    await subscribeToTopic('test_topic');
    print("Subscribed to test_topic");
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    print('Subscribed to topic: $topic');
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    print('Unsubscribed from topic: $topic');
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    LocalNotificationService.displayLocalNotification(
      title: message.notification?.title ?? "No Title",
      body: message.notification?.body ?? "No Body",
    );
  }

  Future<void> subscribeToDefaultTopics() async {
    await subscribeToTopic('general_notifications');
    print('Subscribed to default topic: general_notifications');
    // Add other default topics here if needed
  }
}


// Local



class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        // Handle notification tap
      },
    );
  }

  static Future<void> displayLocalNotification({required String title, required String body}) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'default_channel',
          'Default Channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      );

      await _flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
      );
    } on Exception catch (e) {
      print('Error displaying notification: $e');
    }
  }
}
