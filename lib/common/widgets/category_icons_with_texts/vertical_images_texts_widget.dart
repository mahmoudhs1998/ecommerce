import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../images/circular_image.dart';

class TVerticalImageText extends StatelessWidget {
  final String title, image;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;
  const TVerticalImageText({
    super.key, required this.title,
     required this.image,
       this.textColor = TColors.white, 
       this.backgroundColor =  TColors.white,
    this.isNetworkImage = true,
       this.onTap,
  });

  @override
  Widget build(BuildContext context) {
   // final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            // category Circular Image
            TcircularImage(
              image: image,
              fit: BoxFit.cover, // fit width
              padding: TSizes.sm * 1.4,
              isNetworkImage:isNetworkImage ,
              backgroundColor: backgroundColor,
              // overlayColor: THelperFunctions.isDarkMode(context)
              //     ? TColors.dark
              //     : TColors.light,

            ),
            // Container(
            //   width: 56,
            //   height: 56,
            //   padding: const EdgeInsets.all(TSizes.sm),
            //   decoration: BoxDecoration(
                
            //     color:
            //         backgroundColor ?? (isDark ? TColors.dark : TColors.light),
            //     borderRadius: BorderRadius.circular(100),
            //   ),
            //   child: Center(
            //     child: Image(
            //       width: 56,
            //       height: 56,
            //       image: NetworkImage(image), //AssetImage(image),
            //       fit: BoxFit.fitWidth,
            //       //color: isDark ? TColors.dark : TColors.light,
            //     ),
            //   ),
            // ),
            // category Text
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            SizedBox(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TCategoriesSection  => TSectionHeading
