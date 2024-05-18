import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/appbar/app_bar.dart';
import 'widgets/order_list.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          title: Text('My Orders',
              style: Theme.of(context).textTheme.headlineSmall) , showBackArrow: true),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace), 

        // -- Orders 
        child:  TOrdersListItems(),

      ),
    );
  }
}
