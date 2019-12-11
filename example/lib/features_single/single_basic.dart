import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesSingleBasic extends StatefulWidget {
  @override
  _FeaturesSingleBasicState createState() => _FeaturesSingleBasicState();
}

class _FeaturesSingleBasicState extends State<FeaturesSingleBasic> {

  String _day = 'fri';
  String _month = 'apr';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Days',
          value: _day,
          option: SmartSelectOption(options.days),
          onChange: (val) => setState(() => _day = val)
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Month',
          value: _month,
          option: SmartSelectOption(options.months),
          onChange: (val) => setState(() => _month = val)
        ),
        Container(height: 7),
      ],
    );
  }
}