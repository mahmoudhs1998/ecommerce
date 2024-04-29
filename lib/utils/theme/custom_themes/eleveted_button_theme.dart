// import 'package:flutter/material.dart';

// class TElevatedButtonTheme {
// TElevatedButtonTheme ._ (); //To avoid crihting instances

// /// -- Light Thene
// static final lightElevotedButtonTheme = ElevatedButtonThemeData(
// style: ElevatedButton.styleFrom(
// elevation: 0,
// foregroundColor: Colors.white,
// backgroundColor: Colors.blue,
// disabledForegroundColor: Colors.grey,
// disabledBackgroundColor: Colors.grey,
// side: const BorderSide(color: Colors.blue),
// padding: const EdgeInsets.symmetric(vertical: 18),
// textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
// shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

// )) ; // ElevatedButtonThemeData

// /// -- Dark Thene
// static final darkElevatedButtonThene = ElevatedButtonThemeData(
// style: ElevatedButton.styleFrom(
// elevation: 0,
// foregroundColor: Colors.white,
// backgroundColor: Colors.blue,
// disabledForegroundColor: Colors.grey,
// disabledBackgroundColor: Colors.grey.
// side: const BorderSide(color: Colors.blue ),
// padding: const EdgeInsets.symmetric(vertical: 18)
// textStyle: const TextStyle(fontSize: 16, color: Colors.mhite, fontWeight: FontWeight.w600)
// shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

// )) ; // ElevatedButtonThemeData
// }

import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._(); // To avoid creating instances

  /// Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 10),
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  /// Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 10),
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
