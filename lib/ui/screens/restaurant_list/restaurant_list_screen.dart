import "package:flutter/material.dart";
import "package:restaurant_app/temporary_blocs/restaurant_search_bloc.dart";
import "package:restaurant_app/ui/widgets/restaurant_list/restaurant_list.dart";
import "package:restaurant_app/database/models/index.dart";
import "package:restaurant_app/ui/widgets/search_field.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";
import "package:restaurant_app/ui/screens/restaurant_details/restaurant_details_screen.dart";
import "package:restaurant_app/ui/routing/route_names.dart";

class RestaurantListScreen extends StatefulWidget {
  //keys to pass arguments
  static const String TITLE = "title";
  static const String QUERY_CALLBACK = "query_callback";
  static const String IS_CLICKABLE = "is_clickable";
  static const String SHOW_SEARCH_BAR = "show_search_bar";
  final String? title;
  final bool isClickable;
  final bool showSearchBar;
  final void Function(RestaurantSearchBloc)? queryCallback;
  RestaurantListScreen(
      {required this.title,
      required this.queryCallback,
      this.isClickable = false,
      this.showSearchBar = false,
      Key? key})
      : super(key: key);
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final RestaurantSearchBloc _bloc = RestaurantSearchBloc();
  @override
  void initState() {
    print("rls initing state");
    widget.queryCallback!(_bloc);
    super.initState();
    print("rls state inited");
  }

  @override
  Widget build(BuildContext context) {
    print("rls building rls");
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
          title: Text(widget.title!),
          pinned: true,
          expandedHeight: (widget.showSearchBar) ? 55.dp : null,
          flexibleSpace: (widget.showSearchBar)
              ? FlexibleSpaceBar(
                  background: Container(
                      alignment: Alignment.bottomCenter,
                      child: SearchField((q) => _bloc.searchByName(q))))
              : null),
      StreamBuilder<List<Restaurant>?>(
          stream: _bloc.restaurantListStream,
          initialData: [],
          builder: (context, snapshot) => snapshot.hasData
              ? RestaurantList(snapshot.data,
                  onTap: (widget.isClickable)
                      ? (r) => Navigator.of(context)
                              .pushNamed(restaurant_details_route, arguments: {
                            RestaurantDetailsScreen.RESTAURANT_ID: r.id
                          })
                      : null)
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
