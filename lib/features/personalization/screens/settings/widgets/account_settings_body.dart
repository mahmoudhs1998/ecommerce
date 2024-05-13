import 'package:ecommerce/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/personalization/screens/address/address.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AccountSettingsBodyWidget extends StatelessWidget {
  const AccountSettingsBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // -- Account Settings
        const TCategoriesSectionHeading(
          title: "Account Settings",
          showActionButton: false,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
         TSettingsMenuTile(
          icon: Iconsax.safe_home,
          title: 'My Address',
          subTitle: 'Set Shopping delivery address',
          onTap: () => Get.to(() => const UserAddressScreen()),
        ),
        const TSettingsMenuTile(
          icon: Iconsax.shopping_cart,
          title: 'My Cart',
          subTitle: 'Add , remove Products and move to checkout',
        ),
        const TSettingsMenuTile(
          icon: Iconsax.bag_tick,
          title: 'My Orders',
          subTitle: 'In-Progress and completed Orders',
        ),
        const TSettingsMenuTile(
          icon: Iconsax.bank,
          title: 'Bank Account',
          subTitle: 'withdraw balance to registered bank account',
        ),
        const TSettingsMenuTile(
          icon: Iconsax.discount_shape,
          title: 'My Coupons',
          subTitle: 'List of All the discounted Coupons',
        ),
        const TSettingsMenuTile(
          icon: Iconsax.notification,
          title: 'Notifications',
          subTitle: 'set any kind of notification message',
        ),
        const TSettingsMenuTile(
          icon: Iconsax.security_card,
          title: 'Account Privacy',
          subTitle: 'Manage Data usage and connected accounts',
        ),
    
        // -- App Settings
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        const TCategoriesSectionHeading(
          title: "App Settings",
          showActionButton: false,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        const TSettingsMenuTile(
          icon: Iconsax.document_upload,
          title: 'Load data',
          subTitle: 'Upload Data to your cloud Firebase Storage',
        ),
        TSettingsMenuTile(
          icon: Iconsax.location,
          title: 'Geolocation',
          subTitle: 'Set recommendation based on location',
          trailing: Switch(value: true, onChanged: (value) {}),
        ),
    // TSettingsMenuTile
        TSettingsMenuTile(
          icon: Iconsax.security_user,
          title: 'Safe Mode',
          subTitle: 'Search result is safe for all ages',
          trailing: Switch(value: false, onChanged: (value) {}),
        ),
    // TSettingsMenuTile
        TSettingsMenuTile(
          icon: Iconsax.image,
          title: 'HD Image Quality',
          subTitle: 'Set image quality to be seen',
          trailing: Switch(value: false, onChanged: (value) {}),
        ), // TSettingsMenuTile
        /// - Logout Button
        const SizedBox(height: TSizes.spaceBtwSections),
    
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
              onPressed: () {}, child: const Text('Logout')),
        ), // SizedBox
    
        const SizedBox(height: TSizes.spaceBtwSections * 2.5),
      ],
    );
  }
}
