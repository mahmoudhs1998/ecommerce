import 'package:ecommerce/features/shop/screens/home/home_screen.dart';
import 'package:ecommerce/features/shop/screens/store/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenuController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [

    const HomeScreen(),
    const  StoreScreen(),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.yellow,
    ),
  ];
}
