import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class TCircularIcon extends StatelessWidget {
  // A Cuustom Circular Icon Widget with a background color
  // properties :
  // Container [width] , [height] , [backgroundColor] .
  // Icon's [size] , [color] , [onPressed] .
  final double? width, height, size;
  final Color? backgroundColor, color;
  final IconData? icon;
  final VoidCallback? onPressed;
  const TCircularIcon(
      {super.key,
      this.width,
      this.height,
      this.size = TSizes.lg,
      this.backgroundColor,
      this.color,
      required this.icon,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor != null
            ? backgroundColor!
            : THelperFunctions.isDarkMode(context)
                ? TColors.black.withOpacity(0.9)
                : TColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: size, color: color),
      ),
    );
  }
}
