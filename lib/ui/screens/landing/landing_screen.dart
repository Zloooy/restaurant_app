import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/widgets/restaurant_list/restaurant_list.dart';
import 'package:restaurant_app/database/models/index.dart';
import 'package:restaurant_app/temporary_blocs/restaurant_search_bloc.dart';
class LandingScreen extends StatefulWidget
{

	@override
	_LandingScreenState createState() => new _LandingScreenState();
}
class _LandingScreenState extends State<LandingScreen>
{
	final RestaurantSearchBloc _bloc = RestaurantSearchBloc();
	@override
	void initState()
	{
		_bloc.getAll();
		super.initState();
	}
	@override
	Widget build(BuildContext context)=>Scaffold(
			appBar: AppBar(
				title: Text("Рестораны и кафе"),
				actions: [
					IconButton(
							icon:Icon(Icons.search),
							onPressed:()=>{}
							)
				]
					),
			body: CustomScrollView(
			slivers : [
				StreamBuilder<List<Restaurant>>(
						stream:_bloc.restaurantListStream,
						builder: (context, snapshot) => snapshot.hasData ? RestaurantList(snapshot.data) : SliverToBoxAdapter(child: Container(width:0,height:0))
				)
						])
			);
	@override
	void dispose()
	{	
		_bloc.dispose();
		super.dispose();
	}
}