import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import '../choices.dart' as choices;

class FeaturesTileOneLine extends StatefulWidget {
  @override
  _FeaturesTileOneLineState createState() => _FeaturesTileOneLineState();
}

class _FeaturesTileOneLineState extends State<FeaturesTileOneLine> {
  String? _day = 'fri';
  List<String>? _month = ['apr'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String?>.single(
          title: 'Days',
          selectedValue: _day,
          choiceItems: choices.days,
          onChange: (selected) => setState(() => _day = selected.value),
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Month',
          selectedValue: _month,
          choiceItems: choices.months,
          onChange: (selected) => setState(() => _month = selected?.value),
          tileBuilder: (context, state) {
            return S2Tile.fromState(state);
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}
