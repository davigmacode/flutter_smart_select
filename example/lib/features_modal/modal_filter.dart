import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesModalFilter extends StatefulWidget {
  @override
  _FeaturesModalFilterState createState() => _FeaturesModalFilterState();
}

class _FeaturesModalFilterState extends State<FeaturesModalFilter> {

  String _car = '';
  List<String> _smartphone = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect<String>.single(
          title: 'Car',
          placeholder: 'Choose one',
          value: _car,
          isTwoLine: true,
          options: SmartSelectOption.listFrom<String, Map>(
            source: options.cars,
            value: (index, item) => item['value'],
            title: (index, item) => item['title'],
            group: (index, item) => item['brand'],
          ),
          choiceConfig: SmartSelectChoiceConfig(isGrouped: true),
          modalConfig: SmartSelectModalConfig(useFilter: true),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/yeVtxxPxzbw/100x100'),
          ),
          onChange: (val) => setState(() => _car = val),
        ),
        Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Smartphones',
          placeholder: 'Choose one',
          value: _smartphone,
          isTwoLine: true,
          options: SmartSelectOption.listFrom<String, Map>(
            source: options.smartphones,
            value: (index, item) => item['id'],
            title: (index, item) => item['name'],
            group: (index, item) => item['category'],
          ),
          choiceConfig: SmartSelectChoiceConfig(isGrouped: true),
          modalType: SmartSelectModalType.bottomSheet,
          modalConfig: SmartSelectModalConfig(
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