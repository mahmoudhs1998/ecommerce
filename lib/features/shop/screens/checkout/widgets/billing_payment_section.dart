import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helpers_functions.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Column(children: [
      TCategoriesSectionHeading(
          title: 'Payment Method', buttonTitle: 'Change', onPressed: () {}),
      const SizedBox(height: TSizes.spaceBtwItems / 2),
      Row(children: [
        TRoundedContainer(
          width: 60,
          height: 35,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: isDark ? TColors.light : TColors.white,
          child: Image.asset(TImages.payPal, fit: BoxFit.contain),
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Text('PayPal', style: Theme.of(context).textTheme.bodyLarge),
      ]),
    ]);
  }
}
