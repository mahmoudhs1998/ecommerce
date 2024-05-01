import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({
    super.key,
    required this.isThemeMode, required this.dividerText,
  });

  final bool isThemeMode;
  final String dividerText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: isThemeMode ? TColors.darkGrey : TColors.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
         Text(dividerText , style: Theme.of(context). textTheme. labelMedium),
        Flexible(
          child: Divider(
            color: isThemeMode ? TColors.darkGrey : TColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
