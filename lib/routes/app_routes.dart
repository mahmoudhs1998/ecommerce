import 'package:ecommerce/routes/routes.dart';
import 'package:get/get.dart';

import '../features/authentication/screens/login/login_screen.dart';
import '../features/authentication/screens/onboarding/onboarding_screen.dart';
import '../features/authentication/screens/password_configurations/forget_password.dart';
import '../features/authentication/screens/signup/signup_screen.dart';
import '../features/authentication/screens/signup/verify_email.dart';
import '../features/order/order.dart';
import '../features/personalization/screens/address/address.dart';
import '../features/personalization/screens/profile/profile_screen.dart';
import '../features/personalization/screens/settings/settings.dart';
import '../features/shop/screens/cart/cart.dart';
import '../features/shop/screens/checkout/checkout.dart';
import '../features/shop/screens/home/home_screen.dart';
import '../features/shop/screens/product_reviews/product_reviews_screen.dart';
import '../features/shop/screens/store/store_screen.dart';
import '../features/shop/screens/wishlist/wishlist.dart';

class AppRoutes
{

static final pages = [
  GetPage(name: TRoutes.home, page: () => const HomeScreen()),
  GetPage(name: TRoutes.store, page: () => const StoreScreen()),
  GetPage(name: TRoutes.favourites, page: () => const FavoriteScreen()),
  GetPage(name: TRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: TRoutes.productReviews, page: () => ProductReviewsScreen()),
  GetPage(name: TRoutes.order, page: () => const OrderScreen()),
  GetPage(name: TRoutes.checkout, page: () => const CheckoutScreen()),
  GetPage(name: TRoutes.cart, page: () => const CartScreen()),
  GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
  GetPage(name: TRoutes.userAddress, page: () => const UserAddressScreen()),
  GetPage(name: TRoutes.signup, page: () => const SignUpScreen()),
  GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
  GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
  GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: TRoutes.onBoarding, page: () => const OnBoardingScreen()),
// Add more GetPage entries as needed
];
}