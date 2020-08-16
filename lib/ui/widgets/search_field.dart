import 'package:flutter/material.dart';
class SearchField extends StatefulWidget
{
	final void Function(String) _searchCallback;
	SearchField(this._searchCallback, {Key key}):super(key:key);
	@override
	_SearchFieldState createState() => new _SearchFieldState(this._searchCallback);
}
class _SearchFieldState extends State<SearchField>
{
	final void Function(String) _searchCallback;
	final TextEditingController _textController = new TextEditingController();
	final Key _fieldkey= new GlobalKey<_SearchFieldState>();
	_SearchFieldState(this._searchCallback);
	@override
	Widget build(BuildContext context) =>
	Padding(
	padding: EdgeInsets.all(20.0),
	child: Row(
		key:_fieldkey,
		children:[
		Expanded(
				flex:9,
				child:TextField(
						decoration: new InputDecoration(
								filled:true,
								fillColor: Colors.white,
								border: new OutlineInputBorder(
										borderRadius: const BorderRadius.all(
												const Radius.circular(18.0)),
											borderSide: BorderSide(color:Colors.grey)
									)
						),
						controller: _textController)
			),
		Expanded(
				flex:1,
				child:FlatButton(
						shape: RoundedRectangleBorder(
								side: BorderSide(color:Colors.grey),
								borderRadius: BorderRadius.all(Radius.circular(18.0)),
						),
						child:Icon(Icons.search),
						onPressed: ()=>_searchCallback(_textController.text)
						)
			)
	])
	);
	@override
	void dispose()
	{
	_textController.dispose();
	super.dispose();
	}
}
