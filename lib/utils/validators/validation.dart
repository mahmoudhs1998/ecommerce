import 'package:get/get.dart';

import '../constants/texts.dart';

class TValidator {

  // Empty Text Validation

  static String? validateEmptyText(String? fieldName , String? value){
    if (value == null || value.isEmpty) {
      return '$fieldName ${TTexts.isRequired.tr}'.toString().tr;
    }
    return null;
  }
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email'.tr;
    }

    // Regular expression to validate email format
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email'.tr;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password'.tr;
    }

    // check for minimum password characters

    if (value.length < 6) {
      return 'Password must be at least 6 characters'.tr;
    }
    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.'.tr;
    }
    // Check for numbers
    if (!value.contains(RegExp(r'[8-9]'))) {
      return 'Password must contain at least one number.'.tr;
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(), .? ":{}1<>]'))) {
      return 'Password must contain at least one special character.'.tr;
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.'.tr;
    }

// Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).'.tr;
    }

    return null;
  }

  static String? validateEgyptianPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.'.tr;
    }

    // Regular expression for Egyptian phone number validation
    // Accepts formats: 01144357587, 201144357587, +201144357587
    final phoneRegExp = RegExp(r'^(?:\+20|20)?1\d{9}$|^01\d{9}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format.'.tr;
    }

    return null;
  }



}
