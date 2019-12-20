import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesModalFilter extends StatefulWidget {
  @override
  _FeaturesModalFilterState createState() => _FeaturesModalFilterState();
}

class _FeaturesModalFilterState extends State<FeaturesModalFilter> {

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
          value: _car,
          isTwoLine: true,
          option: SmartSelectOptionConfig(
            options.cars,
            groupBy: 'brand',
          ),
          modal: SmartSelectModalConfig(
            useFilter: true,
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/yeVtxxPxzbw/100x100'),
          ),
          onChange: (val) => setState(() => _car = val),
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Smartphones',
          placeholder: 'Choose one',
          value: _smartphone,
          isTwoLine: true,
          isMultiChoice: true,
          option: SmartSelectOptionConfig(
            options.smartphones,
            value: 'id',
            title: 'name',
            groupBy: 'category',
          ),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.bottomSheet,
            useFilter: true,
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