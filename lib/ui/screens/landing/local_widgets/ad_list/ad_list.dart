import 'package:flutter/material.dart';
import 'package:restaurant_app/database/models/index.dart';
import 'ad_item.dart';
class AdList extends StatelessWidget
{
	
	final List<Ad> ads;
	AdList({this.ads, Key key}):super(key:key);
	@override
	Widget build(BuildContext context) => SliverToBoxAdapter(
				child:Container(
						height: 250,
						child:ListView.builder(
				scrollDirection: Axis.horizontal,
				itemCount: ads.length,
				itemBuilder: (context,i)=> AdItem(ads[i])
			)
				)
		);
}
