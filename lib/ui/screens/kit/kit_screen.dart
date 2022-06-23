import "package:flutter/material.dart";
import "package:restaurant_app/database/models/kit.dart";
import "local_blocs/kit_bloc.dart";
import "local_widgets/kit_list/index.dart";

class KitScreen extends StatefulWidget {
  KitScreen({Key? key}) : super(key: key);
  @override
  _KitScreenState createState() => new _KitScreenState();
}

class _KitScreenState extends State<KitScreen> {
  late KitBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = new KitBloc();
    _bloc.getKits();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("Наборы")),
      body: StreamBuilder<List<Kit>?>(
          stream: _bloc.kitListStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return SizedBox();
            else
              return KitList(kits: snapshot.data);
          }));
  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
