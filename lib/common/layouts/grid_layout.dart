import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TGridLayout extends StatelessWidget {
  final int itemCount;
  final double mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;
  const TGridLayout(
      {super.key,
      required this.itemCount,
      required this.itemBuilder,
      this.mainAxisExtent = 288.0});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: mainAxisExtent,
          crossAxisSpacing: TSizes.gridViewSpacing,
          mainAxisSpacing: TSizes.gridViewSpacing,
        ),
        itemBuilder: itemBuilder);
  }
}
