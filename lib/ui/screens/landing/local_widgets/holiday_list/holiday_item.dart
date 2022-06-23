import "package:flutter/material.dart";
import "package:restaurant_app/ui/screens/restaurant_list/restaurant_list_screen.dart";
import "package:restaurant_app/ui/routing/route_names.dart";
import "package:restaurant_app/database/models/index.dart";
import "package:restaurant_app/ui/themes/theme_constants.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";

class HolidayItem extends StatelessWidget {
  final Holiday holiday;
  HolidayItem(this.holiday, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () {
        print("HolidayItem tapped");
        Navigator.of(context).pushNamed(restaurant_list_route, arguments: {
          RestaurantListScreen.TITLE: holiday.name,
          RestaurantListScreen.QUERY_CALLBACK: (bloc) =>
              bloc.searchByHoliday(holiday)
        });
      },
      child: Card(
          elevation: ELEVATION,
          shape: BORDER_SHAPE,
          child: Padding(
            padding: EdgeInsets.all(1.dp),
            child: Column(children: [
              Image(height: 20.dp, image: holiday.icon as ImageProvider<Object>),
              Text(holiday.name, style: Theme.of(context).textTheme.subtitle1)
            ]),
          )));
}
