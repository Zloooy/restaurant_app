import "package:flutter/material.dart";
import "package:restaurant_app/ui/themes/theme_constants.dart";

class SearchField extends StatefulWidget {
  final void Function(String) _searchCallback;
  SearchField(this._searchCallback, {Key key}) : super(key: key);
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final Key _fieldkey = GlobalKey<_SearchFieldState>();
  final TextEditingController _textController = TextEditingController();
  _SearchFieldState();
  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(key: _fieldkey, children: [
        Expanded(
          child: TextField(
              decoration: InputDecoration(filled: true, border: INPUT_BORDER),
              controller: _textController),
        ),
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () => widget._searchCallback(_textController.text))
      ]));
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
