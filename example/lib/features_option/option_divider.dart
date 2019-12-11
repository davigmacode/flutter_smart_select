import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesOptionDivider extends StatefulWidget {
  @override
  _FeaturesOptionDividerState createState() => _FeaturesOptionDividerState();
}

class _FeaturesOptionDividerState extends State<FeaturesOptionDivider> {

  String _car = '';
  List _smartphone = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Car',
          placeholder: 'Choose one',
          isTwoLine: true,
          value: _car,
          option: SmartSelectOption(
            options.cars,
            groupBy: 'body',
            useFilter: true,
            useDivider: true,
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/yeVtxxPxzbw/100x100'),
          ),
          onChange: (val) => setState(() => _car = val),
        ),
        Divider(indent: 20),
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
            useFilter: true,
            useDivider: true,
            isMultiChoice: true,
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
          ),
          onChange: (val) => setState(() => _smartphone = val),
        ),
        Container(height: 7),
      ],
    );
  }
}