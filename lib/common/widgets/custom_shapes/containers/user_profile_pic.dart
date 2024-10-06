import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helpers_functions.dart';

// class UserProfilePic extends StatelessWidget {
//   final double width, height, padding;
//   final String image;
//   final Color? overlayColor, backgroundColor;
//   final BoxFit? fit;
//   final bool isNetworkImage;
//   const UserProfilePic({
//     super.key,
//     required this.image,
//     this.width = 50,
//     this.height = 50,
//     this.padding = TSizes.sm,
//     this.overlayColor,
//     this.backgroundColor,
//     this.fit = BoxFit.cover,
//     this.isNetworkImage = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       padding: EdgeInsets.all(padding),
//       decoration: BoxDecoration(
//         color: backgroundColor ??
//             (THelperFunctions.isDarkMode(context)
//                 ? TColors.dark
//                 : TColors.light),
//         borderRadius: BorderRadius.circular(100),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(100),
//         child: isNetworkImage
//             ? CachedNetworkImage(
//           fit: fit,
//           color: overlayColor,
//           imageUrl: image,
//           progressIndicatorBuilder: (context, url, downloadProgress) => const TShimmerEffect(width: 55, height: 55 , radius: 55,),
//           errorWidget: (context, url, error) => const Icon(Icons.error),
//         ) // CachedNetworkImage
//             : Image(
//           fit: fit,
//           image: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,
//           color: overlayColor,
//         ),
//       ), // Center
//     );
//   }
// }

class UserProfilePic extends StatelessWidget {
  final double radius;
  final String image;
  final Color? overlayColor, backgroundColor;
  final BoxFit fit;
  final bool isNetworkImage;

  const UserProfilePic({
    super.key,
    required this.image,
    this.radius = 30.0, // CircleAvatar uses radius, which is half of the diameter
    this.overlayColor,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FullImagePreview(
              imageUrl: image,
              isNetworkImage: isNetworkImage,
            ),
          ),
        );
      },
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? Colors.transparent,
        backgroundImage: isNetworkImage
            ? NetworkImage(image)
            : AssetImage(image) as ImageProvider, // Cast AssetImage to ImageProvider
        onBackgroundImageError: (error, stackTrace) => Icon(Icons.error),
        child: null, // Removes child to avoid overlaying the background image
      ),
    );
  }
}


class FullImagePreview extends StatelessWidget {
  final String imageUrl;
  final bool isNetworkImage;

  const FullImagePreview({
    super.key,
    required this.imageUrl,
    this.isNetworkImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(); // Close the preview when tapped
          },
          child: Hero(
            tag: imageUrl, // Use Hero for smooth animation
            child: isNetworkImage
                ? Image.network(
              imageUrl,
              fit: BoxFit.contain,
            )
                : Image.asset(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
