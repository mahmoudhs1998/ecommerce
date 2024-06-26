import 'package:flutter/material.dart';

import 'progress_indicator_and_rating.dart';

class OverallProductRating extends StatelessWidget {
  final double rating;

  const OverallProductRating({super.key, required this.rating});


  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 3,
        child: Text(
          rating.toStringAsFixed(1), // Display rating with one decimal place //'4.8',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      const Expanded(
        flex: 7,
        child: Column(children: [
          TRatingProgressIndicator(text: '5', ratingValue: 1.0),
          TRatingProgressIndicator(text: '4', ratingValue: 0.8),
          TRatingProgressIndicator(text: '3', ratingValue: 0.6),
          TRatingProgressIndicator(text: '2', ratingValue: 0.4),
          TRatingProgressIndicator(text: '1', ratingValue: 0.2),
        ]),
      ),
    ]);
  }
}
