import 'package:flutter/material.dart';
import './radios.dart';

class SmartSelectPage extends StatefulWidget {

  final String title;
  final dynamic value;
  final List<Map<String,dynamic>> options;
  final bool searchable;
  final bool closeOnSelect;

  SmartSelectPage({
    Key key,
    this.title,
    this.value,
    this.options,
    this.searchable,
    this.closeOnSelect = true,
  }) : super(key: key);

  @override
  _SmartSelectPageState createState() => _SmartSelectPageState();
}

class _SmartSelectPageState extends State<SmartSelectPage> {

  GlobalKey<SmartSelectRadiosState> _checkerKey = GlobalKey<SmartSelectRadiosState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          !widget.closeOnSelect ? IconButton(
            tooltip: 'Done',
            icon: const Icon(Icons.check),
            onPressed: () => Navigator.pop(context, _checkerKey.currentState.selected),
          ) : Container(),
        ],
      ),
      body: Container(
        child: SmartSelectRadios(
          key: _checkerKey,
          value: widget.value,
          options: widget.options,
          closeOnSelect: widget.closeOnSelect,
        ),
      ),
    );
  }
}