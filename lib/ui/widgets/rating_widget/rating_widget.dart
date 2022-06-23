import "package:flutter/material.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";

class RatingWidget extends StatelessWidget {
  final double? rating;
  RatingWidget({this.rating, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Icon(Icons.star, color: Theme.of(context).colorScheme.secondary),
        SizedBox(width: 3.dp),
        Text("$rating",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Theme.of(context).colorScheme.secondary)),
      ]);
}
