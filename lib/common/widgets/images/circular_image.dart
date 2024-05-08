import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class TcircularImage extends StatelessWidget {
  final double width, height, padding;
  final String image;
  final Color? overlayColor, backgroundColor;
  final BoxFit? fit;
  final bool isNetworkImage;
  const TcircularImage({
    super.key,
    required this.image,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
    this.overlayColor,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (THelperFunctions.isDarkMode(context)
                ? TColors.dark
                : TColors.light),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image(
        image: isNetworkImage
            ? NetworkImage(image)
            : AssetImage(image) as ImageProvider,
        color: overlayColor,
      ),
    );
  }
}
