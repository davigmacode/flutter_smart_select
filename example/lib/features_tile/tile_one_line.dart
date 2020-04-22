import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesTileOneLine extends StatefulWidget {
  @override
  _FeaturesTileOneLineState createState() => _FeaturesTileOneLineState();
}

class _FeaturesTileOneLineState extends State<FeaturesTileOneLine> {

  String _day = 'fri';
  List<String> _month = ['apr'];

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
        SmartSelect<String>.multiple(
          title: 'Month',
          value: _month,
          options: options.months,
          onChange: (state) => setState(() => _month = state.value),
          tileBuilder: (context, state) {
            return S2Tile.fromState(state);
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}