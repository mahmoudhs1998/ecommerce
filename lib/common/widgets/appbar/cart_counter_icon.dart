import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class TCartCounterIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  const TCartCounterIcon({
    super.key,
    this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Stack(children: [
      IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: isDark ? TColors.white : TColors.dark),
      ),
      Positioned(
        right: 0,
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: isDark ? TColors.white : TColors.black,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              '2',
              style: Theme.of(context).textTheme.labelSmall!.apply(
                  color: isDark ? TColors.black : TColors.white,
                  fontSizeFactor: 0.8),
            ),
          ),
        ),
      ),
    ]);
  }
}
