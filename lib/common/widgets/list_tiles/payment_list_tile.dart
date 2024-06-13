import 'package:ecommerce/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/shop/models/payment/payment_method_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helpers_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';

class PaymentTile extends StatelessWidget {
  final PaymentMethodModel paymentMethod;
  const PaymentTile({super.key, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    final controller = CheckOutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },

      leading: TRoundedContainer(
      width: 60,
      height: 40,
      backgroundColor: THelperFunctions.isDarkMode(context)
          ? TColors.light
          : TColors.white,
      padding: const EdgeInsets.all(TSizes.sm),
      child: Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain),
    ),
    title: Text(paymentMethod.name),
    trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
