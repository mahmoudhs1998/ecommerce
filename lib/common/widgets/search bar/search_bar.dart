import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/device/device_utility.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

// Search Bar => Search Container
class TSearchBar extends StatelessWidget {
  final String searchBarHint;
  final IconData? searchBarIcon;
  final bool showBackGround, showBorder;
  final VoidCallback? onTap;
  const TSearchBar({
    super.key,
    required this.searchBarHint,
    this.searchBarIcon = Iconsax.search_normal,
    this.showBackGround = true,
    this.showBorder = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: showBackGround
                ? isDark
                    ? TColors.dark
                    : TColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: TColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(searchBarIcon, color: TColors.darkGrey),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(searchBarHint, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
