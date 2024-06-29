import 'package:ecommerce/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helpers_functions.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final checkOutController = Get.put(CheckOutController());
    final isDark = THelperFunctions.isDarkMode(context);
    return Column(children: [
      TCategoriesSectionHeading(
          title: 'Payment Method', buttonTitle: 'Change', onPressed: () => checkOutController.selectPaymentMethod(context)),
      const SizedBox(height: TSizes.spaceBtwItems / 2),
      Obx(
        ()=> Row(children: [
          TRoundedContainer(
            width: 60,
            height: 35,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: isDark ? TColors.light : TColors.white,
            child: Image(image: AssetImage(checkOutController.selectedPaymentMethod.value.image), fit: BoxFit.contain), // Image.asset(TImages.payPal, fit: BoxFit.contain),
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          Text(checkOutController.selectedPaymentMethod.value.name, style: Theme.of(context).textTheme.bodyLarge),
        ]),
      ),
    ]);
  }
}
