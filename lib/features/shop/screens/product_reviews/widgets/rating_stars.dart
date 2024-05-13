import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class RatingBarStars extends StatelessWidget {
  final double rating;
  const RatingBarStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 20,
      unratedColor: TColors.grey,
      itemBuilder: (_, __) {
        return const Icon(Iconsax.star1, color: TColors.primaryColor);
      },
    );
  }
}
