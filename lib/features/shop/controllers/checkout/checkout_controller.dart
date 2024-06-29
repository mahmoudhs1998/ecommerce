import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/list_tiles/payment_list_tile.dart';
import '../../models/payment/payment_method_model.dart';

class CheckOutController extends  GetxController
{
  static CheckOutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'Paypal', image:TImages.payPal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
          child: Container(
            padding:const EdgeInsets.all(TSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TCategoriesSectionHeading(title: 'Select Payment Method' , showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),
                PaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: TImages.payPal)),
                const SizedBox(height: TSizes.spaceBtwItems/2),
                PaymentTile(paymentMethod: PaymentMethodModel(name: 'Google Pay', image: TImages.payPal)),// TODo : add  googlePay image
                const SizedBox(height: TSizes.spaceBtwItems/2),
                PaymentTile(paymentMethod: PaymentMethodModel(name: 'Apple Pay', image: TImages.payPal)),// TODo : add  applePay image
                const SizedBox(height: TSizes.spaceBtwItems/2),
                PaymentTile(paymentMethod: PaymentMethodModel(name: 'VISA', image: TImages.payPal)),// TODo : add  visa image
                const SizedBox(height: TSizes.spaceBtwItems/2),
                PaymentTile(paymentMethod: PaymentMethodModel(name: 'Master Card', image: TImages.payPal)),// TODo : add  masterCard image
                const SizedBox(height: TSizes.spaceBtwItems/2),
                PaymentTile(paymentMethod: PaymentMethodModel(name: 'Paytm', image: TImages.payPal)),// TODo : add  paytm image
                const SizedBox(height: TSizes.spaceBtwItems/2),
                PaymentTile(paymentMethod: PaymentMethodModel(name: 'Paystack', image: TImages.payPal)),// TODo : add  paystack image
                const SizedBox(height: TSizes.spaceBtwItems/2),
                PaymentTile(paymentMethod: PaymentMethodModel(name: 'Credit Card', image: TImages.payPal)),// TODo : add  creditCard image
                const SizedBox(height: TSizes.spaceBtwItems/2),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ),
          ),
        ),
    );
  }
}