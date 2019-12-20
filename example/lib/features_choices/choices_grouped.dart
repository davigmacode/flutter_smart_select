import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesChoicesGrouped extends StatefulWidget {
  @override
  _FeaturesChoicesGroupedState createState() => _FeaturesChoicesGroupedState();
}

class _FeaturesChoicesGroupedState extends State<FeaturesChoicesGrouped> {

  String _smartphone = '';
  List _car = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Smartphones',
          placeholder: 'Choose one',
          isTwoLine: true,
          value: _smartphone,
          option: SmartSelectOptionConfig(
            options.smartphones,
            value: 'id',
            title: 'name',
            groupBy: 'brand',
          ),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.bottomSheet,
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
          ),
          onChange: (val) => setState(() => _smartphone = val),
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Cars',
          placeholder: 'Choose one or more',
          isTwoLine: true,
          value: _car,
          isMultiChoice: true,
          option: SmartSelectOptionConfig(
            options.cars,
            groupBy: 'body',
          ),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.bottomSheet,
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