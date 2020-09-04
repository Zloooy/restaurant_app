import "package:flutter/material.dart";
import "package:restaurant_app/database/models/index.dart";
import "package:restaurant_app/ui/themes/theme_constants.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";

typedef void AdCallback(Ad ad);
final AdCallback _noAction = (a){};
class AdItem extends StatelessWidget {
  final Ad ad;
  final AdCallback _onTap;
  AdItem(this.ad, {Key key, AdCallback onTap}) : 
	  _onTap=onTap ?? _noAction,
	  super(key: key);
  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => print("AdItem tapped"),
      child: GestureDetector(
		      onTap:() => _onTap(ad),
		      child:Card(
          elevation: ELEVATION,
          shape: BORDER_SHAPE,
          child: Container(
              height: 50.dp,
              width: 100.dp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(CIRCULAR_RADIUS),
                  image: DecorationImage(
                      image: ad.image, fit: BoxFit.fitWidth))))));
}
