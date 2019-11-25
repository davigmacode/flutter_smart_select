import 'package:flutter/material.dart';
import './checkboxes.dart';

class SmartSelectPopup extends StatefulWidget {

  final String title;
  final List<dynamic> value;
  final List<Map<String,dynamic>> options;

  SmartSelectPopup({
    Key key,
    this.title,
    this.value,
    this.options,
  }) : super(key: key);

  @override
  _SmartSelectPopupState createState() => _SmartSelectPopupState();
}

class _SmartSelectPopupState extends State<SmartSelectPopup> {

  GlobalKey<SmartSelectCheckboxesState> _checkerKey = GlobalKey<SmartSelectCheckboxesState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SmartSelectCheckboxes(
        key: _checkerKey,
        value: widget.value,
        options: widget.options,
      ),
    );
  }
}