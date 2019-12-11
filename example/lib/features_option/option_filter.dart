import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesOptionFilter extends StatefulWidget {
  @override
  _FeaturesOptionFilterState createState() => _FeaturesOptionFilterState();
}

class _FeaturesOptionFilterState extends State<FeaturesOptionFilter> {

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
            groupBy: 'brand',
            useFilter: true,
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
            groupBy: 'category',
            useFilter: true,
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