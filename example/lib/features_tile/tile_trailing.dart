import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesTileTrailing extends StatefulWidget {
  @override
  _FeaturesTileTrailingState createState() => _FeaturesTileTrailingState();
}

class _FeaturesTileTrailingState extends State<FeaturesTileTrailing> {

  String _day = 'fri';
  List _month = ['apr'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Days',
          value: _day,
          trailing: Icon(Icons.keyboard_arrow_down),
          option: SmartSelectOptionConfig(options.days),
          onChange: (val) => setState(() => _day = val)
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Month',
          value: _month,
          isTwoLine: true,
          isMultiChoice: true,
          trailing: Icon(Icons.arrow_drop_down_circle),
          option: SmartSelectOptionConfig(options.months),
          onChange: (val) => setState(() => _month = val)
        ),
        Container(height: 7),
      ],
    );
  }
}