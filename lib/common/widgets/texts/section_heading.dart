import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCategoriesSectionHeading extends StatelessWidget {
  final String title, buttonTitle;
  final Color? textColor;
  final bool showActionButton;
  final VoidCallback? onPressed;
  const TCategoriesSectionHeading(
      {super.key,
      required this.title,
      this.buttonTitle = "View all",
      this.textColor,
      this.showActionButton = true,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        if (showActionButton)
          TextButton(onPressed: onPressed, child: Text(buttonTitle.tr)),
      ],
    );
  }
}
