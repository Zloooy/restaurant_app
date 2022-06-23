import "package:flutter/material.dart";
import "package:restaurant_app/database/models/ad.dart";
import "package:restaurant_app/ui/routing/route_names.dart";
import "package:restaurant_app/ui/screens/restaurant_details/restaurant_details_screen.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";
import "local_blocs/ad_bloc.dart";

class AdDetailsScreen extends StatefulWidget {
  static const String AD_ID = "ad_id";
  final String? adId;
  AdDetailsScreen({this.adId, Key? key}) : super(key: key);
  @override
  _AdDetailsScreenState createState() => _AdDetailsScreenState();
}

class _AdDetailsScreenState extends State<AdDetailsScreen> {
  final AdBloc _bloc = AdBloc();
  @override
  void initState() {
    _bloc.adId = widget.adId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<Ad>(
      stream: _bloc.adStream,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return Scaffold(
              appBar: AppBar(title: Text(snapshot.data!.title)),
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(image: snapshot.data!.image as ImageProvider<Object>),
                    Padding(
                      padding: EdgeInsets.all(5.dp),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(Icons.info),
                                SizedBox(width: 3.dp),
                                Text(snapshot.data!.description,
                                    textAlign: TextAlign.left),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  child: Text("К ресторану"),
                                  onPressed: () => Navigator.of(context)
                                          .pushNamed(restaurant_details_route,
                                              arguments: {
                                            RestaurantDetailsScreen
                                                    .RESTAURANT_ID:
                                                snapshot.data!.restaurantId
                                          })),
                            )
                          ]),
                    )
                  ]));
        else
          return Scaffold();
      });
  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
