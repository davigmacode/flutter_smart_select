import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesTileTrailing extends StatefulWidget {
  @override
  _FeaturesTileTrailingState createState() => _FeaturesTileTrailingState();
}

class _FeaturesTileTrailingState extends State<FeaturesTileTrailing> {

  String _day = 'fri';
  List<String> _month = ['apr'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect<String>.single(
          title: 'Days',
          value: _day,
          options: options.days,
          onChange: (val) => setState(() => _day = val),
          trailing: Icon(Icons.keyboard_arrow_down),
        ),
        Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Month',
          value: _month,
          options: options.months,
          onChange: (val) => setState(() => _month = val),
          trailing: Icon(Icons.arrow_drop_down_circle),
          isTwoLine: true,
        ),
        Container(height: 7),
      ],
    );
  }
}