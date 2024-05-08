import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/device/device_utility.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class CategoryTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;

  const CategoryTabBar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Material(
      color:  isDark ? TColors.dark : TColors.white,
      child: TabBar(
        tabs: tabs, 
        isScrollable: true,
        indicatorColor: TColors.primaryColor,
        labelColor:isDark ? TColors.white : TColors.primaryColor,
        unselectedLabelColor: TColors.darkGrey,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
