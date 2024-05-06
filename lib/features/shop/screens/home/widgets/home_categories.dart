import 'package:ecommerce/common/widgets/category_icons_with_texts/vertical_images_texts_widget.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:flutter/material.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (_, index) {
          return TVerticalImageText(
            title: "Shoe",
            image: TImages.category1,
            onTap: () {},
          );
        },
      ),
    );
  }
}

