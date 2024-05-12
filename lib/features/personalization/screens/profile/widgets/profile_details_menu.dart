import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TProfileMenu extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title,value;
  const TProfileMenu({
    super.key,
    required this.onTap,
    this.icon = Iconsax.arrow_right_34,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems / 1.5),
        child: Row(children: [
          Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              )),
          Expanded(
              flex: 3,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              )),
           Expanded(
              child: Icon(
          icon,
            size: 18,
          ))
        ]),
      ),
    );
  }
}
