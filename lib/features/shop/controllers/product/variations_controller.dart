import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:get/get.dart';

import '../../models/product_variation_model.dart';
import '../cart/cart_controller.dart';
import 'images_controller.dart';

// class VariationsController extends GetxController {
//   static VariationsController get instance => Get.find();
//
//   /// Variables
//   RxMap selectedAttributes = {}.obs;
//   RxString variationStockStatus = ''.obs;
//   Rx<ProductVariationModel> selectedVariation =
//       ProductVariationModel.empty().obs;
//
//   /// -- Select Attribute, and Variation
//   void onAttributeSelected(ProductModel product, attributeName, attributeValue) {
// // When attribute is selected we will first add that attribute to the selectedAttributes
//     final selectedAttributes =
//         Map<String, dynamic>.from(this.selectedAttributes);
//     selectedAttributes[attributeName] = attributeValue;
//     this.selectedAttributes[attributeName] = attributeValue;
//
//     final selectedVariation = product.productVariations!.firstWhere(
//       (variation) =>
//           _isSameAttributeValues(variation.attributeValues, selectedAttributes),
//       orElse: () => ProductVariationModel.empty(),
//     );
//
// // Show the selected Variation image as a Main Image
//     if (selectedVariation.image.isNotEmpty) {
//       ImagesController.instance.selectProductImage.value =
//           selectedVariation.image;
//     }
//
//     // Show selected variation quantity already in the cart.
//     if (selectedVariation.id.isNotEmpty) {
//       final cartController = CartController.instance;
//       cartController.productQuantityInCart.value =
//           cartController.getVariationQuantityInCart(
//               product.id, selectedVariation.id);
//     }
//
// // Assign Selected Variation
//     this.selectedVariation.value = selectedVariation;
//     // Update selected product variation status
//     getProductVariationStockStatus();
//   }
//
//   /// -- Check If selected attributes matches any variation attributes
//   bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes) {
// // If selectedAttributes contains 3 attributes and current variation contains 2 then return.
//     if (variationAttributes.length != selectedAttributes.length) return false;
//
// // If any of the attributes is different then return. e.g. [Green, Large] x [Green, Small]
//     for (final key in variationAttributes.keys) {
// // Attributes[Key] = Value which could be [Green, Small, Cotton] etc.
//       if (variationAttributes[key] != selectedAttributes[key]) return false;
//     }
//
//     return true;
//   }
//
//   /// -- Check Attribute availability / Stock in Variation
//   Set<String?> getAttributesAvailabilityInVariation(List<ProductVariationModel> variations, String attributeName) {
// // Pass the variations to check which attributes are available and stock is not 0
//     final availableVariationAttributeValues = variations
//         .where((variation) =>
// // Check Empty / Out of Stock Attributes
//             variation.attributeValues[attributeName] != null &&
//             variation.attributeValues[attributeName]!.isNotEmpty &&
//             variation.stock > 0)
// // Fetch all non-empty attributes of variations
//         .map((variation) => variation.attributeValues[attributeName])
//         .toSet();
//     return availableVariationAttributeValues;
//   }
//
//   /// -- Check Product Variation Stock Status
//   void getProductVariationStockStatus() {
//     variationStockStatus.value =
//         selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
//
//   }
//
//   /// -- Reset Selected Attributes when Switching Products
//   void resetSelectedAttributes() {
//     selectedAttributes.clear();
//     variationStockStatus.value = '';
//     selectedVariation.value = ProductVariationModel.empty();
//   }
//
//   /// -- Variation Price
//   String getVariationPrice(){
//     return (selectedVariation.value.salePrice > 0 ? selectedVariation.value.salePrice : selectedVariation.value.price ).toString();
//   }
// }




class VariationsController extends GetxController {
  static VariationsController get instance => Get.find();

  // Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;
  RxList<ProductVariationModel> productVariations = <ProductVariationModel>[].obs;


  String? getVariationDescription() {
    return selectedVariation.value.description;
  }

  // Select Attribute and Variation
  void onAttributeSelected(ProductModel product, String attributeName, dynamic attributeValue) {
    final selectedAttributes = Map<String, dynamic>.from(this.selectedAttributes);


    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
          (variation) => _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );


    if (selectedVariation.image.isNotEmpty) {
      ImagesController.instance.selectProductImage.value = selectedVariation.image;
    }

    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController.getVariationQuantityInCart(
        product.id,
        selectedVariation.id,
      );
    }
    print('Selected Variation Description: ${selectedVariation.description}');

    this.selectedVariation.value = selectedVariation;
    getProductVariationStockStatus();
  }

  // Check if selected attributes match variation attributes
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes) {
    if (variationAttributes.length != selectedAttributes.length) return false;

    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  // Check attribute availability in variations
  Set<String?> getAttributesAvailabilityInVariation(List<ProductVariationModel> variations, String attributeName) {
    return variations
        .where((variation) =>
    variation.attributeValues[attributeName] != null &&
        variation.attributeValues[attributeName]!.isNotEmpty &&
        variation.stock > 0)
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();
  }

  // Get product variation stock status
  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  // Reset selected attributes
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }

  // Get variation price
  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
        ? selectedVariation.value.salePrice
        : selectedVariation.value.price)
        .toString();
  }



  // Update variation description
  void updateVariationDescription(String newDescription) {
    selectedVariation.update((val) {
      val?.description = newDescription;
    });
    update();
  }

  // Add new variation
  void addVariation(ProductVariationModel newVariation) {
    productVariations.add(newVariation);
    update();
  }

  // Remove variation
  void removeVariation(String variationId) {
    productVariations.removeWhere((variation) => variation.id == variationId);
    update();
  }

  // Update variation
  void updateVariation(ProductVariationModel updatedVariation) {
    int index = productVariations.indexWhere((variation) => variation.id == updatedVariation.id);
    if (index != -1) {
      productVariations[index] = updatedVariation;
      update();
    }
  }

  // Get all variations
  List<ProductVariationModel> getAllVariations() {
    return productVariations;
  }

  // Check if a variation exists
  bool variationExists(String variationId) {
    return productVariations.any((variation) => variation.id == variationId);
  }

  // Get variation by ID
  ProductVariationModel? getVariationById(String variationId) {
    return productVariations.firstWhere((variation) => variation.id == variationId, orElse: () => ProductVariationModel.empty());
  }

  // Update stock for a variation
  void updateVariationStock(String variationId, int newStock) {
    int index = productVariations.indexWhere((variation) => variation.id == variationId);
    if (index != -1) {
      productVariations[index].stock = newStock;
      update();
    }
  }
}