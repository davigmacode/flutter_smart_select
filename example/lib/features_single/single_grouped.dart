import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesSingleGrouped extends StatefulWidget {
  @override
  _FeaturesSingleGroupedState createState() => _FeaturesSingleGroupedState();
}

class _FeaturesSingleGroupedState extends State<FeaturesSingleGrouped> {

  String _car = '';
  String _smartphone = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect.sheet(
          title: 'Smartphones',
          placeholder: 'Choose one',
          isTwoLine: true,
          value: _smartphone,
          option: SmartSelectOption(
            options.smartphones,
            value: 'id',
            label: 'name',
            groupBy: 'brand',
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
          ),
          onChange: (val) => setState(() => _smartphone = val),
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Cars',
          placeholder: 'Choose one',
          isTwoLine: true,
          value: _car,
          option: SmartSelectOption(
            options.cars,
            groupBy: 'brand',
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