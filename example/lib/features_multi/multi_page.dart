import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesMultiPage extends StatefulWidget {
  @override
  _FeaturesMultiPageState createState() => _FeaturesMultiPageState();
}

class _FeaturesMultiPageState extends State<FeaturesMultiPage> {

  List<String> _day = ['fri'];
  List<String> _month = ['apr'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect<String>.multiple(
          title: 'Days',
          value: _day,
          options: options.days,
          onChange: (val) => setState(() => _day = val)
        ),
        Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Month',
          value: _month,
          options: options.months,
          modalType: SmartSelectModalType.fullPage,
          onChange: (val) => setState(() => _month = val)
        ),
        Container(height: 7),
      ],
    );
  }
}