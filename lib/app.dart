import 'package:ecommerce/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const Scaffold(
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