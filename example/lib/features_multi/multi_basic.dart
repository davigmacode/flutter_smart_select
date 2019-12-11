import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesMultiBasic extends StatefulWidget {
  @override
  _FeaturesMultiBasicState createState() => _FeaturesMultiBasicState();
}

class _FeaturesMultiBasicState extends State<FeaturesMultiBasic> {

  List _day = ['fri'];
  List _month = ['apr'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Days',
          value: _day,
          option: SmartSelectOption(
            options.days,
            isMultiChoice: true,
          ),
          onChange: (val) => setState(() => _day = val)
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Month',
          value: _month,
          option: SmartSelectOption(
            options.months,
            isMultiChoice: true,
          ),
          onChange: (val) => setState(() => _month = val)
        ),
        Container(height: 7),
      ],
    );
  }
}