import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


/// Global Keys for Languages :
const String language = 'lang';
const String arabic = 'ar';
const String english = 'en';

class LocaleController extends GetxController {
  static LocaleController get instance => Get.find();

  // Locale initialLanguage = TLocalStorage.instance().readData(language) == arabic
  //     ? const Locale(arabic)
  //     : const Locale(english);

  // Locale initialLanguage = sharedprefs!.getString(language) == arabic
  //     ? const Locale(arabic)
  //     : const Locale(english);
  /// to take the default language of the device
    Locale initialLanguage =sharedprefs!.getString(language) == null ? Get.deviceLocale! :  Locale(sharedprefs!.getString(language)!);

  void changeLanguage(String languageCode) {
    Locale currentLocale = Locale(languageCode);
    //TLocalStorage.instance().writeData(language, currentLocale);
    sharedprefs!.setString(language, languageCode);
    Get.updateLocale(currentLocale);
  }
}
