import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/utils/constants/shimmer.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/products/sortable/sort_able_products.dart';
import '../../controllers/product/all_product_controller.dart';
import '../../models/product_model.dart';

class AllProducts extends StatelessWidget {
  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;
  const AllProducts({super.key, required this.title, this.query, this.futureMethod});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return  Scaffold(
      appBar: TAppBar(title: Text(title.tr), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {

              // check the state of the futureBuilder snapshot
              final loader =   TVerticalProductShimmer();
              final widget = CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot , loader : loader);

              // Return appropriate widget based on snapshot state
              if (widget != null) return widget;

              // Products Found
              final products = snapshot.data!;
              return  SortableProducts(products: products,);
            }
          ),
        ),
      ),
    );
  }
}
