import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class TRatingProgressIndicator extends StatelessWidget {
  final String text;
  final double ratingValue;
  const TRatingProgressIndicator({
    super.key,
    required this.text,
    required this.ratingValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: TDeviceUtils.getScreenWidth(context) * 0.8,
            child: LinearProgressIndicator(
              value: ratingValue,
              minHeight: 11,
              backgroundColor: TColors.grey,
              borderRadius: BorderRadius.circular(7),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(TColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
