import "package:flutter/material.dart";

class RatingWidget extends StatelessWidget {
  final double rating;
  RatingWidget({this.rating, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Icon(Icons.star),
        Text("$rating",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Theme.of(context).accentColor)),
      ]);
}
