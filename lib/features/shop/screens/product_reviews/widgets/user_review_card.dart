import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/features/shop/screens/product_reviews/widgets/rating_stars.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          // -- User Image
          const CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
          ),
          const SizedBox(width: TSizes.spaceBtwItems),

          // -- User Name
          Text(
            'John Doe',
            style: Theme.of(context).textTheme.titleLarge!.apply(
                  color: isDark ? TColors.white : TColors.black,
                ),
          ),
        ]),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
      ]),

      const SizedBox(height: TSizes.spaceBtwItems),
      // -- Rating review and Date

      Row(children: [
        const RatingBarStars(rating: 4),
        const SizedBox(width: TSizes.spaceBtwItems),
        Text('13 May, 2024',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: isDark ? TColors.white : TColors.black)),
      ]),

      const SizedBox(height: TSizes.spaceBtwItems),
      // -- Review  Description text

      const ReadMoreText(
        'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
        trimLines: 1,
        trimMode: TrimMode.Line,
        trimExpandedText: 'Show less',
        trimCollapsedText: 'Show more',
        moreStyle: TextStyle(
          color: TColors.primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        lessStyle: TextStyle(
          color: TColors.primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: TSizes.spaceBtwItems),

      // -- Company Review
      TRoundedContainer(
        backgroundColor: isDark ? TColors.darkGrey : TColors.grey,
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Company Name',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '13 May, 2024',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // -- Review  Description text

              const ReadMoreText(
                'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
                trimLines: 1,
                trimMode: TrimMode.Line,
                trimExpandedText: 'Show less',
                trimCollapsedText: 'Show more',
                moreStyle: TextStyle(
                  color: TColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                lessStyle: TextStyle(
                  color: TColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: TSizes.spaceBtwSections),
    ]);
  }
}
