import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_image_container.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helpers_functions.dart';

class UserProfilePic extends StatelessWidget {
  final double width, height, padding;
  final String image;
  final Color? overlayColor, backgroundColor;
  final BoxFit? fit;
  final bool isNetworkImage;
  const UserProfilePic({
    super.key,
    required this.image,
    this.width = 50,
    this.height = 50,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
              ? CachedNetworkImage(
            fit: fit,
            color: overlayColor,
            imageUrl: image,
            progressIndicatorBuilder: (context, url, downloadProgress) => const TShimmerEffect(width: 55, height: 55 , radius: 55,),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ) // CachedNetworkImage
              : Image(
            fit: fit,
            image: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,
            color: overlayColor,
          ), // Image
        ),
      ), // Center
    );
  }
}
