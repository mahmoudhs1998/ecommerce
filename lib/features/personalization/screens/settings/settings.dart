import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce/common/widgets/list_tiles/user_card_tile.dart';
import 'package:ecommerce/features/personalization/screens/profile/profile_screen.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/account_settings_body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // -- Header
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                TAppBar(
                  title: Text(
                    "Account",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TColors.white),
                  ),
                ),

                // -- User Profile Card
                 UserProfileTileCard(onPressed: () => Get.to(const ProfileScreen()),),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            )),
            // -- Body

            const Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: AccountSettingsBodyWidget(),
            )
          ],
        ),
      ),
    );
  }
}
