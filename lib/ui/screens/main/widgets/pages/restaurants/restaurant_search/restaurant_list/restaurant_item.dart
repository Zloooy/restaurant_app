import 'package:flutter/material.dart';
import 'package:restaurant_app/database/models/restaurant.dart';
class RestaurantItem extends StatelessWidget
{
	final Restaurant _restaurant;	
	RestaurantItem(this._restaurant, {Key key}):
		super(key:key);
	@override
	Widget build(BuildContext context)=>Container(height:100.0,
			child: Card(
						shape: RoundedRectangleBorder(
								borderRadius: BorderRadius.all(Radius.circular(18.0)),
						),
					child: Container(
							decoration:BoxDecoration(
									borderRadius: BorderRadius.all(Radius.circular(18.0)),
									image:DecorationImage(
											image: _restaurant.mainImage,
											fit:BoxFit.fitWidth //TODO switch to cover if doesen't work
											),
									),
						child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								mainAxisAlignment: MainAxisAlignment.center,
					children: [
						Text(_restaurant.name,
								style:TextStyle(
										color: Colors.white,
										fontSize:16.0,
										fontWeight:FontWeight.bold,
										letterSpacing: 0.7
										)
								),
						Text(_restaurant.address,
								style:TextStyle(
										color: Colors.grey,
										fontSize:14.0
										)
								)
					]
				)
			)
			)
	);
}
