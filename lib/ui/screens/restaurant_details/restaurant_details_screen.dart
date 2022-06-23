import "package:flutter/material.dart";
import "package:restaurant_app/ui/widgets/rating_widget/rating_widget.dart";
import "package:restaurant_app/temporary_blocs/restaurant_search_bloc.dart";
import "package:restaurant_app/temporary_blocs/cart_bloc.dart";
import "package:restaurant_app/database/models/index.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";
import "package:restaurant_app/ui/screens/meal_menu/meal_menu_screeen.dart";
import "package:restaurant_app/ui/routing/route_names.dart";
import "package:restaurant_app/ui/widgets/cart_button/cart_button.dart";
import "./local_blocs/flexible_space_bloc.dart";

class RestaurantDetailsScreen extends StatefulWidget {
  static const String RESTAURANT_ID = "restaurant_id";
  final String? restaurantId;
  RestaurantDetailsScreen({required this.restaurantId, Key? key})
      : super(key: key);
  @override
  _RestaurantDetailsScreenState createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  final RestaurantSearchBloc _bloc = RestaurantSearchBloc();
  final CartBloc _cartBloc = CartBloc();
  final FlexibleSpaceBloc _flexBloc = FlexibleSpaceBloc();
  final ScrollController _controller = ScrollController();
  bool _collapsed = false;
  _RestaurantDetailsScreenState();
  @override
  void initState() {
    super.initState();
    _bloc.getRestaurantById(widget.restaurantId);
    _flexBloc.isCollapsed = _collapsed;
    _cartBloc.updateCart();
    _controller.addListener(() => _flexBloc.isCollapsed =
        _controller.offset > 45.dp && !_controller.position.outOfRange);
  }

  void updateUI() {
    _cartBloc.updateCart();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<Restaurant?>(
      stream: _bloc.singleRestaurantStream,
      builder: (context, snapshot) => (!snapshot.hasData)
          ? Scaffold()
          : Scaffold(
              body: CustomScrollView(controller: _controller, slivers: [
              StreamBuilder<bool>(
                  stream: _flexBloc.isCollapsedStream,
                  builder: (context, boolSnapshot) {
                    return SliverAppBar(
                        iconTheme: (boolSnapshot.hasData && boolSnapshot.data!)
                            ? IconTheme.of(context)
                            : IconTheme.of(context)
                                .copyWith(color: Colors.white),
                        expandedHeight: 70.dp,
                        floating: true,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                            title: (boolSnapshot.hasData && boolSnapshot.data!)
                                ? Text(
                                    snapshot.data!.name,
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
                                  height: 67.dp,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: snapshot.data!.mainImage
                                          as ImageProvider<Object>,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.dp),
                                        child: Text(snapshot.data!.name,
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5)))
                              ],
                            )),
                        actions: [
                          StreamBuilder<int>(
                              stream: _cartBloc.productCountStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData)
                                  return CartButton(
                                      productCount: snapshot.data,
                                      onPressed: () => Navigator.of(context)
                                          .pushNamed(cart_route)
                                          .then((_) => updateUI()));
                                else
                                  return SizedBox();
                              }),
                          IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () => Navigator.of(context)
                                      .pushNamed(meal_menu_route, arguments: {
                                    MealMenuScreen.RESTAURANT_ID:
                                        widget.restaurantId
                                  }).then((_) => updateUI())),
                        ]);
                  }),
              SliverFillRemaining(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.dp),
                      alignment: Alignment.topLeft,
                      child: Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.start,
                          spacing: 3.dp,
                          children: [
                            RatingWidget(rating: snapshot.data!.rating),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(width: 3.dp),
                                  Text(snapshot.data!.address)
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.info),
                                  SizedBox(width: 3.dp),
                                  Text(snapshot.data!.description)
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.phone),
                                  SizedBox(width: 3.dp),
                                  Text(snapshot.data!.phone)
                                ]),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width - 10.dp,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Забронировать столик")))
                          ])))
            ])));

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    _flexBloc.dispose();
  }
}
