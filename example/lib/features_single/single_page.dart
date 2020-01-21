import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesSinglePage extends StatefulWidget {
  @override
  _FeaturesSinglePageState createState() => _FeaturesSinglePageState();
}

class _FeaturesSinglePageState extends State<FeaturesSinglePage> {

  String _day = 'fri';
  String _month = 'apr';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect<String>.single(
          title: 'Days',
          value: _day,
          options: options.days,
          onChange: (val) => setState(() => _day = val)
        ),
        Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Month',
          value: _month,
          options: options.months,
          onChange: (val) => setState(() => _month = val)
        ),
        Container(height: 7),
      ],
    );
  }
}