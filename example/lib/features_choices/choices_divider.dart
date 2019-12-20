import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesChoicesDivider extends StatefulWidget {
  @override
  _FeaturesChoicesDividerState createState() => _FeaturesChoicesDividerState();
}

class _FeaturesChoicesDividerState extends State<FeaturesChoicesDivider> {

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
          option: SmartSelectOptionConfig(
            options.cars,
            groupBy: 'body',
          ),
          choice: SmartSelectChoiceConfig(useDivider: true),
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
            groupBy: 'brand',
          ),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.bottomSheet,
            useFilter: true
          ),
          choice: SmartSelectChoiceConfig(useDivider: true),
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