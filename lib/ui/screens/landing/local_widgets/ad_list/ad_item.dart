import 'package:flutter/material.dart';
import 'package:restaurant_app/database/models/index.dart';
import 'package:restaurant_app/ui/themes/theme_constants.dart';
class AdItem extends StatelessWidget
{
	final Ad ad;
	AdItem(this.ad);
	@override
	Widget build(BuildContext context) => GestureDetector(
			onTap:()=> print("AdItem tapped"),
				child:	Card(
					elevation:ELEVATION,
					shape: BORDER_SHAPE,

				child: Container(
						height:300,
						width:400,
									decoration: BoxDecoration(
											borderRadius: BorderRadius.all(CIRCULAR_RADIUS),
				image: DecorationImage(
								image: ad.image,
								fit:BoxFit.fitWidth
						)
			)
									)
			)
				);
				
}
