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
        const SizedBox(height: 7),
        SmartSelect<String>.single(
          title: 'Days',
          value: _day,
          options: options.days,
          onChange: (state) => setState(() => _day = state.value),
        ),
        const Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Month',
          value: _month,
          options: options.months,
          onChange: (state) => setState(() => _month = state.value),
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}