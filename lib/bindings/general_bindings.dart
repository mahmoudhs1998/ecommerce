import 'package:ecommerce/common/network/network_connectivity.dart';
import 'package:ecommerce/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:ecommerce/features/shop/controllers/product/variations_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationsController());
    Get.put(AddressController());
    Get.put(CheckOutController());
  }
}