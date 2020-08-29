import "package:flutter/material.dart";
import "package:restaurant_app/temporary_blocs/restaurant_search_bloc.dart";
import "package:restaurant_app/ui/widgets/restaurant_list/restaurant_list.dart";
import "package:restaurant_app/database/models/index.dart";

class RestaurantListScreen extends StatefulWidget {
  //keys to pass arguments
  static const String TITLE = "title";
  static const String QUERY_CALLBACK = "query_callback";
  final String title;
  final void Function(RestaurantSearchBloc) queryCallback;
  RestaurantListScreen(
      {@required this.title, @required this.queryCallback, Key key})
      : super(key: key);
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final RestaurantSearchBloc _bloc = RestaurantSearchBloc();
  @override
  void initState() {
    print("rls initing state");
    widget.queryCallback(_bloc);
    super.initState();
    print("rls state inited");
  }

  @override
  Widget build(BuildContext context) {
    print("rls building rls");
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: CustomScrollView(slivers: [
          StreamBuilder<List<Restaurant>>(
              stream: _bloc.restaurantListStream,
              initialData: [],
              builder: (context, snapshot) => snapshot.hasData
                  ? RestaurantList(snapshot.data)
                  : SliverToBoxAdapter(child: SizedBox(width: 0, height: 0)))
        ]));
  }

  @override
  void dispose() {
    print("rls disposing");
    super.dispose();
    _bloc.dispose();
  }
}
