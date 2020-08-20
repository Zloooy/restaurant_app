import 'package:flutter/material.dart';
import 'package:restaurant_app/database/models/restaurant.dart';
import 'package:restaurant_app/ui/themes/theme_constants.dart';
class RestaurantItem extends StatelessWidget
{
	final Restaurant _restaurant;	
	RestaurantItem(this._restaurant, {Key key}):
		super(key:key);
	@override
	Widget build(BuildContext context)=> Card(
					shape: BORDER_SHAPE,
					child: Column(
						children: [
							Container(
									decoration: BoxDecoration(
											borderRadius: BorderRadius.only(
													topLeft:CIRCULAR_RADIUS,
													topRight:CIRCULAR_RADIUS),
											image: DecorationImage(
											image:_restaurant.mainImage,
										fit: BoxFit.fitWidth,
										),
											),
										width:double.infinity,
										height:300
									),
						Align(
								alignment:Alignment.centerLeft,
						child: Padding(
								padding:EdgeInsets.only(left:10.0),
								child:Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								mainAxisAlignment: MainAxisAlignment.start,
					children: [
						Text(_restaurant.name,
								style: Theme.of(context).textTheme.headline6
								),
						Row(
								children:[
								Icon(Icons.star),
								Text(_restaurant.rating.toString(),
										style:Theme.of(context).textTheme.headline6.copyWith(color:Theme.of(context).accentColor)),
								SizedBox(width:7.0),
							Text(_restaurant.cuisine,
									style: Theme.of(context).textTheme.caption,
									textAlign:TextAlign.right
									)
						]
						)
					]
						)
						)
			)
			]
			)
			);
}
