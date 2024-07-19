import 'package:ecommerce/admin/product_category/add_product_category.dart';
import 'package:ecommerce/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/features/personalization/screens/address/address.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../admin/brand_category/add_brand_category.dart';
import '../../../../../admin/categories/admin_category_screen.dart';
import '../../../../../admin/order/admin_order.dart';
import '../../../../../admin/order/test.dart';
import '../../../../../admin/products/admin_product_screen.dart';
import '../../../../../admin/products/controller/test/new.dart';
import '../../../../../admin/products/controller/test/ui.dart';
import '../../../../../admin/products/new_screen_test.dart';
import '../../../../../localization/language_switch_dialoge.dart';
import '../../../../order/order.dart';

class AccountSettingsBodyWidget extends StatelessWidget {
  const AccountSettingsBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // -- Account Settings
        TCategoriesSectionHeading(
          title: "Account Settings".tr,
          showActionButton: false,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        TSettingsMenuTile(
          icon: Iconsax.safe_home,
          title: 'My Address'.tr,
          subTitle: 'Set Shopping delivery address'.tr,
          onTap: () => Get.to(() => const UserAddressScreen()),
        ),
        TSettingsMenuTile(
          icon: Iconsax.shopping_cart,
          title: 'My Cart'.tr,
          subTitle: 'Add , remove Products and move to checkout'.tr,
        ),
        TSettingsMenuTile(
          icon: Iconsax.bag_tick,
          title: 'My Orders'.tr,
          subTitle: 'In-Progress and completed Orders'.tr,
          onTap: () => Get.to(() => const OrderScreen()),
        ),
        TSettingsMenuTile(
          icon: Iconsax.bank,
          title: 'Bank Account'.tr,
          subTitle: 'withdraw balance to registered bank account'.tr,
        ),
        TSettingsMenuTile(
          icon: Iconsax.discount_shape,
          title: 'My Coupons'.tr,
          subTitle: 'List of All the discounted Coupons'.tr,
        ),
        TSettingsMenuTile(
          icon: Iconsax.notification,
          title: 'Notifications'.tr,
          subTitle: 'set any kind of notification message'.tr,
        ),
        TSettingsMenuTile(
          icon: Iconsax.security_card,
          title: 'Account Privacy'.tr,
          subTitle: 'Manage Data usage and connected accounts'.tr,
        ),

        // -- App Settings
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        TCategoriesSectionHeading(
          title: "App Settings".tr,
          showActionButton: false,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        //  TSettingsMenuTile(
        //   icon: Iconsax.document_upload,
        //   title: 'Load data',
        //   subTitle: 'Upload Data to your cloud Firebase Storage',
        //   onTap: () {},
        // ),
        TSettingsMenuTile(
          icon: Iconsax.language_circle,
          title: 'Change Language'.tr,
          subTitle: 'Upload Data to your cloud Firebase Storage',
          onTap: () {
            Get.dialog(const LanguageSwitchDialog());
          },
        ),

        TSettingsMenuTile(
          icon: Iconsax.document_upload,
          title: 'Add Category',
          subTitle: 'Add new categories to your Firebase Storage',
          onTap: () => Get.to(() => AdminCategoryScreen()),
        ),
        TSettingsMenuTile(
          icon: Iconsax.document_upload,
          title: 'Add BrandCategory',
          subTitle: 'Add new BrandCategory to your Firebase Storage',
          onTap: () => Get.to(() => AddBrandCategoryPage()),
        ),
        TSettingsMenuTile(
          icon: Iconsax.document_upload,
          title: 'Add ProductCategory',
          subTitle: 'Add new ProductCategory to your Firebase Storage',
          onTap: () => Get.to(() => AddProductCategoryPage()),
        ),
        TSettingsMenuTile(
          icon: Iconsax.document_upload,
          title: 'Add Banner',
          subTitle: 'Add new Banner to your Firebase Storage',
          // onTap: () => Get.to(() => AddBannerPage()),
        ),
        TSettingsMenuTile(
          icon: Iconsax.document_upload,
          title: 'Add Banner',
          subTitle: 'Add new Brand to your Firebase Storage',
          //  onTap: () => Get.to(() => AdminBrandScreen()),
        ),
        // Product
        TSettingsMenuTile(
          icon: Iconsax.document_upload,
          title: 'Add Product',
          subTitle: 'Add new Product to your Firebase Storage',
          onTap: () =>
              Get.to(()
              =>  //AddProductForms()
                 ProductAdditionForm()
              ),
        ),

        // Order
        TSettingsMenuTile(
          icon: Iconsax.document_upload,
          title: 'Order',
          subTitle: 'Manage Order from your Firebase Storage',
          onTap: () => Get.to(() => AdminOrderPanel()),
        ),

        //AdminProductScreen
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
              onPressed: () => AuthenticationRepository.instance.logout(),
              child: Text('Logout'.tr)),
        ), // SizedBox

        const SizedBox(height: TSizes.spaceBtwSections * 2.5),
      ],
    );
  }
}
