import 'package:ecommerce/bindings/general_bindings.dart';
import 'package:ecommerce/localization/locale.dart';
import 'package:ecommerce/localization/locale_controller.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
   final langController = Get.put(LocaleController());
    return GetMaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        initialBinding: GeneralBindings(),
        getPages: AppRoutes.pages,
        locale: langController.initialLanguage ,//Get.deviceLocale,
        translations: LocaleLang(),
        home: const Scaffold(
          backgroundColor: TColors.primaryColor,
          body: Center(
            child: CircularProgressIndicator(color: TColors.white),
          ),
        ),
        // OnBoardingScreen(),

        );
  }
}
