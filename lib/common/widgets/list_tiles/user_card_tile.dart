import 'package:ecommerce/common/widgets/custom_shapes/containers/user_profile_pic.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UserProfileTileCard extends StatelessWidget {
  final VoidCallback? onPressed;
  const UserProfileTileCard({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: const UserProfilePic(height: 50, width: 50),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
      subtitle: Text(
        controller.user.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Iconsax.edit,
            color: TColors.white,
          )),
    );
  }
}
