import 'package:ecommerce/common/widgets/texts/brand_title_text.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextSizes brandTextSize;
  final TextAlign? textAlign;
  const TBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = TColors.primaryColor,
    this.brandTextSize = TextSizes.small,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Flexible(
        child: TBrandTitleText(
          title: title,
          maxLines: maxLines,
          brandTextSize: brandTextSize,
          color: textColor,
          textAlign: textAlign,
        ),
      ),
      const SizedBox(
        width: TSizes.xs,
      ),
      Icon(
        Iconsax.verify5,
        color: iconColor,
        size: TSizes.iconXs,
      ),
    ]);
  }
}
