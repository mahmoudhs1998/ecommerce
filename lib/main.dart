import 'package:ecommerce/services/fcm_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'features/authentication/controllers/login/login_controller.dart';
import 'firebase_options.dart';

SharedPreferences? sharedprefs;
Future<void> main() async {
// Todo: Add Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  sharedprefs = await SharedPreferences.getInstance();
// Todo: Init Local Storage
  await GetStorage.init();
// Todo: Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // // Initialize FCM Service
  // await Get.putAsync(() => FCMService().init());
// Todo: Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));
//Todo: Initialize Authentication
  // Initialize FCM Service
  // await Get.putAsync(() => FCMService().init());
  // await Get.find<FCMService>().testFCM();
  LocalNotificationService.initialize();

  Get.put(FCMService());
  // Initialize and start listening for notifications

  Get.put(NotificationService());

  runApp(const App());
}
// mh4221058@gmail.com
// Jon1998
//mahmoudhs236@gmail.com
//JON_SNOW_1998


