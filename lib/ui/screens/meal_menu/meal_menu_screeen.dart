import "package:flutter/material.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";
import "package:restaurant_app/temporary_blocs/meal_menu_bloc.dart";
import "package:restaurant_app/temporary_blocs/cart_bloc.dart";
import "package:restaurant_app/database/index.dart";
import "package:restaurant_app/ui/widgets/search_field.dart";
import "package:restaurant_app/ui/widgets/cart_button/cart_button.dart";
import "package:restaurant_app/ui/routing/route_names.dart";
import "local_widgets/meal_list/index.dart";

class MealMenuScreen extends StatefulWidget {
  static const String RESTAURANT_ID = "restaurant_id";
  final String? restaurantId;
  MealMenuScreen({this.restaurantId, Key? key}) : super(key: key);
  @override
  _MealMenuScreenState createState() => _MealMenuScreenState();
}

class _MealMenuScreenState extends State<MealMenuScreen> {
  final MealMenuBloc _bloc = MealMenuBloc();
  final CartBloc _cartBloc = CartBloc();
  @override
  void initState() {
    super.initState();
    _bloc.restaurantId = widget.restaurantId;
    _bloc.searchMeals("");
    _cartBloc.updateCart();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: FutureBuilder(
          future: _bloc.inited,
          builder: (context, fsnapshot) {
            _bloc.searchMeals("");
            print("fsnapshot data: $fsnapshot.data");
            print("mealListStream ${_bloc.mealListStream}");
            return (fsnapshot.connectionState != ConnectionState.done)
                ? SizedBox.expand(child: ColoredBox(color: Colors.red))
                : CustomScrollView(slivers: [
                    SliverAppBar(
                        title: Text("Меню"),
                        expandedHeight: 55.dp,
                        actions: [
                          StreamBuilder<int>(
                              stream: _cartBloc.productCountStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData)
                                  return CartButton(
                                      productCount: snapshot.data,
                                      onPressed: () => Navigator.of(context)
                                          .pushNamed(cart_route)
                                          .then((_) => _cartBloc.updateCart()));
                                else
                                  return SizedBox();
                              }),
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                                alignment: Alignment.bottomCenter,
                                width: 30.dp,
                                child: SearchField(
                                  _bloc.searchMeals,
                                )))),
                    SliverToBoxAdapter(),
                    StreamBuilder<List<Meal>>(
                        stream: _bloc.mealListStream,
                        builder: (context, snapshot) {
                          print("snapshot data: $snapshot.data");
                          return !snapshot.hasData
                              ? SliverFillRemaining()
                              : MealList(
                                  meals: snapshot.data,
                                  onAddToCart: (m) => _cartBloc.addToCart(m),
                                );
                        })
                  ]);
          }));
  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    _cartBloc.dispose();
  }
}
