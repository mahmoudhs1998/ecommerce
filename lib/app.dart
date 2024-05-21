import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        home: const Scaffold(
          backgroundColor: TColors.primaryColor,
          body: Center(
            child: CircularProgressIndicator(color: TColors.white),
          ),
        )
        // OnBoardingScreen(),

        );
  }
}
