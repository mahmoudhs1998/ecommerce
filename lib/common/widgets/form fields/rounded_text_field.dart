import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  /// `CustomFormField` is a StatelessWidget that creates a custom form field with border radius.
  ///
  /// This widget takes two required parameters:
  /// - `labelText`: A String that defines the label text of the form field.
  /// - `prefixIcon`: An IconData that defines the prefix icon of the form field.
  ///
  /// Usage:
  /// ```dart
  /// CustomFormField(
  ///   labelText: 'Username',
  ///   prefixIcon: Icons.person,
  /// );
  /// ```
  ///
  /// The `build` method of this widget returns a `TextFormField` with custom `InputDecoration`.
  /// The border color of the form field changes based on the current theme mode (dark or light).
  /// The border radius of the form field is set to 8.
  ///
  /// The `labelText` and `prefixIcon` passed to the `CustomFormField` are used in the `InputDecoration`.
  // -- Custom Form Field With Border Radius

  final String labelText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function()? suffixPressed;
  const CustomFormField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    this.validator,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.suffixIcon = Icons.clear,
    this.suffixPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return TextFormField(

      onChanged: onChanged,
      focusNode : focusNode,
      controller:controller ,
        validator: validator,
      decoration: InputDecoration(
        suffixIcon:IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon)) ,
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide( 
              width: 0.8, color: isDark ? TColors.darkGrey : TColors.grey),

          borderRadius: BorderRadius.circular(8), // Set the border radius here
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 0.8, color: isDark ? TColors.darkGrey : TColors.grey),
          borderRadius: BorderRadius.circular(8), // Set the border radius here
        ),
        prefixIcon: Icon(prefixIcon),
      ),
    );
  }
}
