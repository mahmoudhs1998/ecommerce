import 'package:flutter/material.dart';

import 'app.dart';

void main() {
// Todo: Add Widgets Binding
// Todo: Init Local Storage
// Todo: Await Native Splash
// Todo: Initialize Firebase
//Todo: Initiolize Authentication
  runApp(const App());
}



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: Scaffold(
        body: Center(
          child: Text(
          'Welcome to Ecommerce!',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Popins',
          ),
        ),
        ),
      ),
    );
    
  }
}

