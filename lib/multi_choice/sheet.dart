import 'package:flutter/material.dart';
import './checkboxes.dart';

class SmartSelectSheet extends StatefulWidget {

  final String title;
  final List<dynamic> value;
  final List<Map<String,dynamic>> options;

  SmartSelectSheet({
    Key key,
    this.title,
    this.value,
    this.options,
  }) : super(key: key);

  @override
  _SmartSelectSheetState createState() => _SmartSelectSheetState();
}

class _SmartSelectSheetState extends State<SmartSelectSheet> {

  GlobalKey<SmartSelectCheckboxesState> _checkerKey = GlobalKey<SmartSelectCheckboxesState>();

  @override
  Widget build(BuildContext context) {
    return SmartSelectCheckboxes(
      key: _checkerKey,
      value: widget.value,
      options: widget.options,
    );
  }
}