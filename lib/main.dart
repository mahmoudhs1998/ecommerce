import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
// Todo: Add Widgets Binding
// Todo: Init Local Storage
// Todo: Await Native Splash
// Todo: Initialize Firebase
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
//Todo: Initialize Authentication
  runApp(const App());
}



 


