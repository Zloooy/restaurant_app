import "package:flutter/material.dart";
import "package:restaurant_app/database/models/restaurant.dart";
import "package:restaurant_app/ui/themes/theme_constants.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";
import "package:restaurant_app/ui/widgets/rating_widget/rating_widget.dart";

typedef RestaurantCallback = void Function(Restaurant r);
final RestaurantCallback _noAction = (r) {};

class RestaurantItem extends StatelessWidget {
  final Restaurant _restaurant;
  final RestaurantCallback _onTap;
  RestaurantItem(this._restaurant, {Key key, RestaurantCallback onTap})
      : _onTap = onTap ?? _noAction,
        super(key: key);
  @override
  Widget build(BuildContext context) => Padding(
      padding: LIST_SEPARATOR_PADDING,
      child: GestureDetector(
        onTap: () => _onTap(_restaurant),
        child: Card(
            elevation: ELEVATION,
            shape: BORDER_SHAPE,
            child: Wrap(runSpacing: DEFAULT_SPACING, children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: CIRCULAR_RADIUS, topRight: CIRCULAR_RADIUS),
                    image: DecorationImage(
                      image: _restaurant.mainImage,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  width: double.infinity,
                  height: 50.dp),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Wrap(runSpacing: DEFAULT_SPACING, children: [
                        Text(_restaurant.name,
                            style: Theme.of(context).textTheme.headline6),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RatingWidget(rating: _restaurant.rating),
                              SizedBox(width: 2.0.dp),
                              Text(_restaurant.cuisine,
                                  style: Theme.of(context).textTheme.caption,
                                  textAlign: TextAlign.right)
                            ]),
                      ]))),
              SizedBox(height: (DEFAULT_SPACING / 2).dp, width: 1)
            ])),
      ));
}
