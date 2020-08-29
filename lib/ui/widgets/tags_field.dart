import 'package:flutter/material.dart';

class TagsField extends StatelessWidget {
  final void Function(String) _tagCallback;
  final List<String> _tags;
  TagsField(this._tags, this._tagCallback, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Wrap(
      children: _tags
          .map((tag) => ChoiceChip(
                label: Text(tag),
                selected: false,
                onSelected: (sel) => (sel) ? _tagCallback(tag) : null,
              ))
          .toList());
}
