import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/themes/theme_constants.dart';

class SearchField extends StatefulWidget {
  final void Function(String) _searchCallback;
  SearchField(this._searchCallback, {Key key}) : super(key: key);
  @override
  _SearchFieldState createState() =>
      new _SearchFieldState(this._searchCallback);
}

class _SearchFieldState extends State<SearchField> {
  final void Function(String) _searchCallback;
  final Key _fieldkey = new GlobalKey<_SearchFieldState>();
  final TextEditingController _textController = new TextEditingController();
  _SearchFieldState(this._searchCallback);
  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(key: _fieldkey, children: [
        Expanded(
          flex: 8,
          child: TextField(
              decoration:
                  new InputDecoration(filled: true, border: INPUT_BORDER),
              controller: _textController),
        ),
        Expanded(flex: 1, child: SizedBox()),
        Expanded(
            flex: 1,
            child: FlatButton(
                shape: BORDER_SHAPE,
                child: Icon(Icons.search),
                onPressed: () => _searchCallback(_textController.text)))
      ]));
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
