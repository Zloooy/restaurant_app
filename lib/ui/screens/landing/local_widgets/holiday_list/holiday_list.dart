import 'package:flutter/material.dart';
import 'package:restaurant_app/database/models/index.dart';
import './holiday_item.dart';
import 'package:restaurant_app/utils/dp_extension/index.dart';

class HolidayList extends StatelessWidget {
  final List<Holiday> holidays;
  HolidayList({this.holidays, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
      child: Container(
          height: 30.dp,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: holidays.length,
              itemBuilder: (context, i) => HolidayItem(holidays[i]))));
}
