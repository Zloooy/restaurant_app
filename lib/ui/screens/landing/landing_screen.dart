import "package:flutter/material.dart";
import "package:restaurant_app/ui/widgets/restaurant_list/restaurant_list.dart";
import "package:restaurant_app/database/models/index.dart";
import "package:restaurant_app/temporary_blocs/restaurant_search_bloc.dart";
import "package:restaurant_app/ui/routing/route_names.dart";
import "package:restaurant_app/ui/screens/restaurant_details/restaurant_details_screen.dart";
import "package:restaurant_app/ui/screens/ad_details/ad_details_screen.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";
import "package:restaurant_app/ui/screens/restaurant_list/restaurant_list_screen.dart";
import "./local_widgets/ad_list/ad_list.dart";
import "./local_widgets/holiday_list/holiday_list.dart";

class LandingScreen extends StatefulWidget {
  LandingScreen({Key? key}) : super(key: key);
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final RestaurantSearchBloc _bloc = RestaurantSearchBloc();
  @override
  void initState() {
    _bloc.getAll();
    _bloc.getHolidays();
    _bloc.getAds();
    super.initState();
    print("landing_screen state inited");
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text("Рестораны и кафе"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Navigator.of(context)
                      .pushNamed(restaurant_list_route, arguments: {
                    RestaurantListScreen.TITLE: "Поиск",
                    RestaurantListScreen.QUERY_CALLBACK: (q) => {},
                    RestaurantListScreen.IS_CLICKABLE: true,
                    RestaurantListScreen.SHOW_SEARCH_BAR: true
                  }))
        ],
      ),
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(), // Don"t touch: it"s Flutter bug. Read https://github.com/flutter/flutter/issues/55170 .
        StreamBuilder<List<Ad>?>(
          stream: _bloc.adStream,
          builder: (context, snapshot) => snapshot.hasData
              ? AdList(
                  ads: snapshot.data,
                  onTap: (ad) => Navigator.of(context).pushNamed(
                      ad_details_route,
                      arguments: {AdDetailsScreen.AD_ID: ad.id}))
              : SliverToBoxAdapter(child: SizedBox(width: 0, height: 0)),
        ),
        SliverToBoxAdapter(child: SizedBox(width: 0, height: 7.dp)),
        StreamBuilder<List<Holiday>?>(
            stream: _bloc.holidayStream,
            builder: (context, snapshot) => snapshot.hasData
                ? HolidayList(holidays: snapshot.data)
                : SliverToBoxAdapter(child: SizedBox(width: 0, height: 0))),
        SliverToBoxAdapter(child: SizedBox(width: 0, height: 5.dp)),
        StreamBuilder<List<Restaurant>?>(
            stream: _bloc.restaurantListStream,
            builder: (context, snapshot) => snapshot.hasData
                ? RestaurantList(snapshot.data,
                    onTap: (r) => Navigator.of(context)
                            .pushNamed(restaurant_details_route, arguments: {
                          RestaurantDetailsScreen.RESTAURANT_ID: r.id
                        }))
                : SliverToBoxAdapter(child: SizedBox(width: 0, height: 0)))
      ]));
  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
    print("landing_screen state sidposed");
  }
}
