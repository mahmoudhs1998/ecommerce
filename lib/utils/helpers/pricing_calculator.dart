// class TPricingCalculator {
//   // calculate price based on tax and shipping
//   static double calculateTotalPrice(double productPrice, String location) {
//     double taxRate = getTaxRateForLocation(location);
//     double taxAmount = productPrice * taxRate;
//
//     double shippingCost = getShippingCost(location);
//
//     double totalPrice = productPrice + taxAmount + shippingCost;
//
//     return totalPrice;
//   }
//
//   // calculate shipping cost
//   static String calculateShippingCost(double productPrice, String location) {
//     double shippingCost = getShippingCost(location);
//     return shippingCost.toStringAsFixed(2);
//   }
//
//
//   /// -- Calculate tax
//   static String calculateTax(double subTotal, String location) {
//     double taxRate = getTaxRateForLocation(location);
//     double taxAmount = subTotal * taxRate;
//     return taxAmount.toStringAsFixed(2);
//   }
//   // calculate tax rate
//   static String calculateTaxRate(double productPrice, String location) {
//     double taxRate = getTaxRateForLocation(location);
//     double taxAmount = productPrice * taxRate;
//     return taxAmount.toStringAsFixed(2);
//   }
//
//   static double getTaxRateForLocation(String location) {
// // Lookup the tax rate for the given location from a tax rate database or API.
// // Return the appropriate tax rate.
//     return 0.10; // Example tax rate of 10%
//   }
//
//   static double getShippingCost(String location) {
// // Lookup the shipping cost for the given location using a shipping rate API.
// // Calculate the shipping cost based on various factors like distance, weight, etc.
//     return 5.00; // Example shipping cost of $5
//   }
//
//   /// -- Sum all cart values and return total amount
// // static double calculateCartTotal(CartModel cart) {
// // return cart.items.map((e) => e.price).fold(0, (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0));
// // }
// }


import '../../admin/coupon.dart';

class TPricingCalculator {
  // Calculate the total price with tax, shipping, and discount applied
  static double calculateTotalPrice(double productPrice, String location, UserCouponModel? coupon) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);

    double discount = calculateDiscount(productPrice, coupon);

    double totalPrice = productPrice + taxAmount + shippingCost - discount;
    return totalPrice > 0 ? totalPrice : 0.0;
  }

  // Calculate the discount amount based on the coupon
  static double calculateDiscount(double productPrice, UserCouponModel? coupon) {
    if (coupon == null) return 0.0;

    double discount = 0.0;
    if (coupon.discountType == 'percentage') {
      discount = productPrice * (coupon.discountAmount ?? 0) / 100;
    } else if (coupon.discountType == 'fixed') {
      discount = coupon.discountAmount ?? 0;
    }

    return discount > productPrice ? productPrice : discount;
  }

  // Other methods remain the same...
  static double getTaxRateForLocation(String location) {
    return 0.10; // Example tax rate of 10%
  }

  static double getShippingCost(String location) {
    return 5.00; // Example shipping cost of $5
  }

// Other methods like calculateShippingCost, calculateTax, etc.
}
