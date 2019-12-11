import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesMultiGrouped extends StatefulWidget {
  @override
  _FeaturesMultiGroupedState createState() => _FeaturesMultiGroupedState();
}

class _FeaturesMultiGroupedState extends State<FeaturesMultiGrouped> {

  List _car = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Cars',
          placeholder: 'Choose one or more',
          isTwoLine: true,
          value: _car,
          option: SmartSelectOption(
            options.cars,
            groupBy: 'body',
            isMultiChoice: true,
            useConfirmation: true,
            useFilter: true,
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/yeVtxxPxzbw/100x100'),
          ),
          onChange: (val) => setState(() => _car = val),
        ),
        Container(height: 7),
      ],
    );
  }
}