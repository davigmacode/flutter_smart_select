import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesTileTwoLine extends StatefulWidget {
  @override
  _FeaturesTileTwoLineState createState() => _FeaturesTileTwoLineState();
}

class _FeaturesTileTwoLineState extends State<FeaturesTileTwoLine> {

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
          isTwoLine: true,
        ),
        Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Month',
          value: _month,
          options: options.months,
          onChange: (val) => setState(() => _month = val),
          isTwoLine: true,
        ),
        Container(height: 7),
      ],
    );
  }
}