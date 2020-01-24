import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesMultiChips extends StatefulWidget {
  @override
  _FeaturesMultiChipsState createState() => _FeaturesMultiChipsState();
}

class _FeaturesMultiChipsState extends State<FeaturesMultiChips> {

  List<String> _car = [];
  List<String> _smartphone = [];
  List<String> _day = ['fri'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect<String>.multiple(
          title: 'Car',
          value: _car,
          isTwoLine: true,
          options: SmartSelectOption.listFrom<String, Map>(
            source: options.cars,
            value: (index, item) => item['value'],
            title: (index, item) => item['title'],
            group: (index, item) => item['brand'],
          ),
          choiceType: SmartSelectChoiceType.chips,
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
          value: _smartphone,
          isTwoLine: true,
          options: SmartSelectOption.listFrom<String, Map>(
            source: options.smartphones,
            value: (index, item) => item['id'],
            title: (index, item) => item['name'],
          ),
          modalType: SmartSelectModalType.bottomSheet,
          modalConfig: SmartSelectModalConfig(
            useFilter: true
          ),
          choiceType: SmartSelectChoiceType.chips,
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
          ),
          onChange: (val) => setState(() => _smartphone = val),
        ),
        Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Days',
          value: _day,
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.calendar_today),
          ),
          options: options.days,
          choiceType: SmartSelectChoiceType.chips,
          modalType: SmartSelectModalType.popupDialog,
          onChange: (val) => setState(() => _day = val)
        ),
        Container(height: 7),
      ],
    );
  }
}