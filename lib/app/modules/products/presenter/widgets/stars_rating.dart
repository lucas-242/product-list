import 'package:flutter/material.dart';

class StarsRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final void Function(double rating)? onRatingChanged;
  final Color? color;

  const StarsRating({
    Key? key,
    this.starCount = 5,
    this.rating = .0,
    this.onRatingChanged,
    this.color = const Color(0xFFFF9B3F),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(starCount, (index) => buildStar(context, index)),
    );
  }

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: color,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: color,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color,
      );
    }
    return InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: icon,
    );
  }
}
