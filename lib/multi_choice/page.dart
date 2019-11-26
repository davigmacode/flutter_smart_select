import 'package:flutter/material.dart';
import './checkboxes.dart';

class SmartSelectPage extends StatefulWidget {
  final String title;
  final List<dynamic> value;
  final List<Map<String, dynamic>> options;
  final bool searchable;

  SmartSelectPage({
    Key key,
    this.title,
    this.value,
    this.options,
    this.searchable,
  }) : super(key: key);

  @override
  _SmartSelectPageState createState() => _SmartSelectPageState();
}

class _SmartSelectPageState extends State<SmartSelectPage> {
  GlobalKey<SmartSelectCheckboxesState> _checkerKey =
      GlobalKey<SmartSelectCheckboxesState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            tooltip: 'Done',
            icon: const Icon(Icons.check),
            onPressed: () =>
                Navigator.pop(context, _checkerKey.currentState.selectedList),
          ),
        ],
      ),
      body: Container(
        child: SmartSelectCheckboxes(
          key: _checkerKey,
          value: widget.value,
          options: widget.options,
        ),
      ),
    );
  }
}
