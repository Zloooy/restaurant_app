import "package:flutter/material.dart";
import "package:restaurant_app/database/models/kit.dart";
import "kit_item.dart";
class KitList extends StatelessWidget
{
	final List<Kit> kits;
	KitList({this.kits, Key key}):super(key:key);
	@override
	Widget build(BuildContext context) =>
			ListView.builder(
				itemBuilder: (context, i) => KitItem(kits[i]),
				itemCount: kits.length
					);
}
