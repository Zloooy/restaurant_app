import "package:flutter/material.dart";
import "package:restaurant_app/ui/widgets/rating_widget/rating_widget.dart";
import "package:restaurant_app/temporary_blocs/restaurant_search_bloc.dart";
import "package:restaurant_app/database/models/index.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";
import "./local_blocs/flexible_space_bloc.dart";

class RestaurantDetailsScreen extends StatefulWidget {
  static const String RESTAURANT_ID = "restaurant_id";
  final String restaurantId;
  RestaurantDetailsScreen({@required this.restaurantId, Key key})
      : super(key: key);
  @override
  _RestaurantDetailsScreenState createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  final RestaurantSearchBloc _bloc = RestaurantSearchBloc();
  final FlexibleSpaceBloc _flexBloc = FlexibleSpaceBloc();
  final ScrollController _controller = ScrollController();
  bool _collapsed = false;
  _RestaurantDetailsScreenState();
  @override
  void initState() {
    super.initState();
    _bloc.getRestaurantById(widget.restaurantId);
    _flexBloc.isCollapsed = _collapsed;
    _controller.addListener(() => _flexBloc.isCollapsed =
        _controller.offset > 45.dp && !_controller.position.outOfRange);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<Restaurant>(
      stream: _bloc.singleRestaurantStream,
      builder: (context, snapshot) => (!snapshot.hasData)
          ? Scaffold()
          : Scaffold(
              floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.search), onPressed: () => {}),
              body: CustomScrollView(controller: _controller, slivers: [
                SliverAppBar(
                    expandedHeight: 70.dp,
                    floating: true,
                    pinned: true,
                    flexibleSpace: StreamBuilder<bool>(
                        stream: _flexBloc.isCollapsedStream,
                        builder: (context, boolSnapshot) {
                          return FlexibleSpaceBar(
                              title: (boolSnapshot.hasData && boolSnapshot.data)
                                  ? Text(
                                      snapshot.data.name,
                                      textAlign: TextAlign.left,
                                    )
                                  : null,
                              collapseMode: CollapseMode.pin,
                              stretchModes: [
                                StretchMode.fadeTitle,
                                StretchMode.blurBackground
                              ],
                              centerTitle: false,
                              background: Column(
                                children: [
                                  Container(
                                    height: 70.dp,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: snapshot.data.mainImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        snapshot.data.name,
                                        textAlign: TextAlign.left,
                                      ))
                                ],
                              ));
                        })),
                SliverFillRemaining(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RatingWidget(rating: snapshot.data.rating),
                              Text(snapshot.data.description)
                            ])))
              ])));

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    _flexBloc.dispose();
  }
}
