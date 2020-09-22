import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../choices.dart' as choices;

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
        const SizedBox(height: 7),
        SmartSelect<String>.single(
          title: 'Days',
          value: _day,
          choiceItems: choices.days,
          onChange: (state) => setState(() => _day = state.value),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              trailing: const Icon(Icons.keyboard_arrow_down),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Month',
          value: _month,
          choiceItems: choices.months,
          onChange: (state) => setState(() => _month = state.value),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              trailing: const Icon(Icons.arrow_drop_down_circle),
              isTwoLine: true,
            );
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}