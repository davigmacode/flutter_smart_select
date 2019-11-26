import 'package:flutter/material.dart';
import './checkboxes.dart';

class SmartSelectSheet extends StatefulWidget {
  final String title;
  final List<dynamic> value;
  final List<Map<String, dynamic>> options;

  SmartSelectSheet({
    Key key,
    this.title,
    this.value,
    this.options,
  }) : super(key: key);

  @override
  SmartSelectSheetState createState() => SmartSelectSheetState();
}

class SmartSelectSheetState extends State<SmartSelectSheet> {
  GlobalKey<SmartSelectCheckboxesState> checkboxesController =
      GlobalKey<SmartSelectCheckboxesState>();

  @override
  Widget build(BuildContext context) {
    return SmartSelectCheckboxes(
      key: checkboxesController,
      value: widget.value,
      options: widget.options,
    );
  }
}
