import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:ecommerce/zBottom_navigation_bar/controllers/bottom_nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationMenuController());
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          indicatorShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          height: 80,
          
          elevation: 0,
          backgroundColor: isDark ? TColors.black : TColors.white,
          indicatorColor: isDark
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (currentIndex) =>
              controller.selectedIndex.value = currentIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.shop),
              label: 'Store',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.heart),
              label: 'Wishlist',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.user),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

