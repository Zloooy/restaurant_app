import 'package:flutter/material.dart';
import './restaurant_list/restaurant_list.dart';
import 'package:restaurant_app/ui/widgets/search_field.dart';
import 'package:restaurant_app/ui/widgets/tags_field.dart';
import 'package:restaurant_app/database/restaurant_database.dart';
import 'package:restaurant_app/database/models/restaurant.dart';
import 'dart:async';
class RestaurantSearch extends StatefulWidget
{
	@override
	_RestaurantSearchState createState() => new _RestaurantSearchState();
}
class _RestaurantSearchState extends State<RestaurantSearch>
{
	final RestaurantDatabase _db = RestaurantDatabase();
	final StreamController<List<Restaurant>> _controller = new StreamController<List<Restaurant>>();
	@override
	void initState()
	{
		super.initState();
	}
	@override
	Widget build(BuildContext context)=>CustomScrollView(
			slivers : [
				SliverAppBar(
						floating: true,
						pinned: false,
						snap: true,
						expandedHeight: 150.0,
						backgroundColor:Colors.white,
						elevation:5.0,
						flexibleSpace: FlexibleSpaceBar(
								background: Column(
										children: [
											SearchField((query)=>_controller.add(_db.getRestaurantsByName(query))),
											TagsField(_db.getRestaurantTags(),(tag)=>_controller.add(_db.getRestaurantsByTag(tag)))
										]
										)
						)
						),
				StreamBuilder<List<Restaurant>>(
						stream:_controller.stream,
						initialData:[],
						builder: (context, snapshot) => RestaurantList(snapshot.data)
				)
			]);
	@override
	void dispose()
	{	
		_controller.close();
		super.dispose();
	}
}
