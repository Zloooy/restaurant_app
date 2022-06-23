import "dart:math";
import "package:flutter/material.dart";
import "package:restaurant_app/ui/screens/restaurant_list/restaurant_list_screen.dart";
import "package:vector_math/vector_math.dart" hide Colors;
import "package:restaurant_app/utils/dp_extension/index.dart";
import "package:restaurant_app/ui/routing/route_names.dart";
import "./local_widgets/hexagonal_button.dart";

class MainMenuScreen extends StatelessWidget {
  static final double buttonDiameter = 40;
  static final double buttonRadius = buttonDiameter / 2;
  static final double padding = 15;
  MainMenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DpExtension(MediaQuery.of(context).devicePixelRatio);
    final size = MediaQuery.of(context).size;
    final Vector2 distanceV = Vector2(0, buttonRadius.dp * sqrt(3) + padding);
    final Vector2 topPosV =
        Vector2(size.width / 2 - padding, size.height / 2 - buttonRadius.dp) -
            Vector2.all(buttonRadius.dp);
    print("top $topPosV");
    //IDK why here padding is needed
    final Vector2 bottomPosV = topPosV + distanceV;
    print("bottom $bottomPosV");
    //
    final Vector2 rightPosV =
        topPosV + (distanceV.clone()..postmultiply(Matrix2.rotation(pi / 3)));
    final Vector2 leftPosV =
        topPosV + (distanceV.clone()..postmultiply(Matrix2.rotation(-pi / 3)));
    return Scaffold(
        body: SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
                alignment: AlignmentDirectional.center,
                fit: StackFit.passthrough,
                clipBehavior: Clip.antiAlias,
                children: [
                  Positioned(
                      left: topPosV.x,
                      top: topPosV.y,
                      child: _mainMenuButton(context,
                          iconPath: "assets/open_air.png",
                          text: "На открытом воздухе",
                          onPressed: () =>
                              Navigator.of(context).pushNamed(landing_route)
                          /*onPressed:()=>Navigator.of(context).pushNamed(
			    restaurant_list_route,
			    arguments:{
										RestaurantListScreen.TITLE:"На открытом воздухе",
										RestaurantListScreen.QUERY_CALLBACK:(q)=>{}
									})*/
                          )),
                  Positioned(
                      left: leftPosV.x,
                      top: leftPosV.y,
                      child: _mainMenuButton(context,
                          iconPath: "assets/meeting.png",
                          text: "Первое свидание",
                          onPressed: () => Navigator.of(context)
                                  .pushNamed(restaurant_list_route, arguments: {
                                RestaurantListScreen.TITLE: "Первое свидание",
                                RestaurantListScreen.QUERY_CALLBACK: (q) => {},
                                RestaurantListScreen.IS_CLICKABLE: true,
                              }))),
                  Positioned(
                      left: rightPosV.x,
                      top: rightPosV.y,
                      child: _mainMenuButton(context,
                          iconPath: "assets/evening.png",
                          text: "Тёплый вечер",
                          onPressed: () => Navigator.of(context)
                                  .pushNamed(restaurant_list_route, arguments: {
                                RestaurantListScreen.TITLE: "Тёплый вечер",
                                RestaurantListScreen.QUERY_CALLBACK: (q) => {},
                                RestaurantListScreen.IS_CLICKABLE: true,
                              }))),
                  Positioned(
                      left: bottomPosV.x,
                      top: bottomPosV.y,
                      child: _mainMenuButton(context,
                          iconPath: "assets/collection.png",
                          text: "Наборы",
                          onPressed: () =>
                              Navigator.of(context).pushNamed(kit_route))),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: _bottomButton(
                          child: Icon(Icons.search),
                          onPressed: () => Navigator.of(context)
                                  .pushNamed(restaurant_list_route, arguments: {
                                RestaurantListScreen.TITLE: "Поиск",
                                RestaurantListScreen.QUERY_CALLBACK: (q) => {},
                                RestaurantListScreen.IS_CLICKABLE: true,
                                RestaurantListScreen.SHOW_SEARCH_BAR: true
                              }))),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: _bottomButton(
                          child: ImageIcon(AssetImage("assets/account.png")),
                          onPressed: () =>
                              Navigator.of(context).pushNamed(account_route)))
                ])));
  }

  Widget _mainMenuButton(context,
          {required String iconPath,
          required String text,
          required VoidCallback onPressed}) =>
      HexagonalButton(
          onPressed: onPressed,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageIcon(AssetImage(
                  iconPath,
                )),
                Text(text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 10.81))
              ]),
          borderRadius: Radius.circular(10),
          diameter: buttonDiameter.dp);
  Widget _bottomButton(
          {required Widget child, VoidCallback? onPressed}) =>
      Padding(
          padding: EdgeInsets.all(10.0),
          child: SizedBox(
              height: 25.dp,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: CircleBorder()),
                  child: child,
                  onPressed: onPressed)));
}
