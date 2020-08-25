import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/widgets/restaurant_list/restaurant_list.dart';
import 'package:restaurant_app/database/models/index.dart';
import 'package:restaurant_app/temporary_blocs/restaurant_search_bloc.dart';
import './local_widgets/holiday_list/holiday_list.dart';
import './local_widgets/ad_list/ad_list.dart';
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
		_bloc.getHolidays();
		_bloc.getAds();
		super.initState();
		print("landing_screen state inited");
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
				StreamBuilder<List<Ad>>(
						stream: _bloc.adStream,
						builder: (context, snapshot) => snapshot.hasData ? AdList(ads: snapshot.data) : SliverToBoxAdapter(child: Container(width:0, height:0)),
						),
				SliverToBoxAdapter(child: Container(width:0, height:50)),
				StreamBuilder<List<Holiday>>(
						stream:_bloc.holidayStream,
						builder: (context, snapshot) => snapshot.hasData ? HolidayList(holidays: snapshot.data) : SliverToBoxAdapter(child: Container(width:0, height:0))
				),
				SliverToBoxAdapter(child: Container(width:0, height:20)),
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
		print("landing_screen state sidposed");
	}
}
