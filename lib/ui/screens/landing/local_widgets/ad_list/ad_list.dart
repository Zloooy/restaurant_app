import "package:flutter/material.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";
import "package:restaurant_app/database/models/index.dart";
import "ad_item.dart";

class AdList extends StatelessWidget {
  final List<Ad> ads;
  final AdCallback onTap;
  AdList({@required this.ads, this.onTap, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
      child: (ads.length > 0)
          ? SizedBox(
              height: 50.dp,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ads.length,
                  itemBuilder: (context, i) => AdItem(ads[i], onTap: onTap)))
          : SizedBox(width: 0, height: 0));
}
