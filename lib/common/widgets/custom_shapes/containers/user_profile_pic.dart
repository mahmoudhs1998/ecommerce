import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_image_container.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:flutter/material.dart';

class UserProfilePic extends StatelessWidget {
  final double? width, height;
  const UserProfilePic({
    super.key, this.width=50, this.height=50,
  });

  @override
  Widget build(BuildContext context) {
    return  TRoundedImage(
      imageUrl: TImages.banner4,
      fit: BoxFit.cover,
      width: width,
      height: height,
      padding: EdgeInsets.zero,
      borderRadius: 100,
    );
  }
}
