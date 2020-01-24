import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesSingleChips extends StatefulWidget {
  @override
  _FeaturesSingleChipsState createState() => _FeaturesSingleChipsState();
}

class _FeaturesSingleChipsState extends State<FeaturesSingleChips> {

  String _car = '';
  String _category = '';
  String _day = 'fri';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect<String>.single(
          title: 'Car',
          value: _car,
          isTwoLine: true,
          options: SmartSelectOption.listFrom<String, Map>(
            source: options.cars,
            value: (index, item) => item['value'],
            title: (index, item) => item['title'],
            group: (index, item) => item['brand'],
          ),
          modalType: SmartSelectModalType.fullPage,
          modalConfig: SmartSelectModalConfig(
            title: 'Cars Option',
            // leading: Container(
            //   padding: EdgeInsets.all(10.0),
            //   child: Text('To hot reload changes while running, press "r". To hot restart (and rebuild state), press "R"'),
            // ),
            // trailing: Container(
            //   padding: EdgeInsets.all(10.0),
            //   child: Text('To hot reload changes while running, press "r". To hot restart (and rebuild state), press "R"'),
            // ),
          ),
          choiceType: SmartSelectChoiceType.chips,
          choiceConfig: SmartSelectChoiceConfig(isGrouped: true),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/yeVtxxPxzbw/100x100'),
          ),
          onChange: (val) => setState(() => _car = val),
        ),
        Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Category',
          isTwoLine: true,
          value: _category,
          options: options.categories,
          modalType: SmartSelectModalType.bottomSheet,
          choiceType: SmartSelectChoiceType.chips,
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.label_outline),
          ),
          onChange: (val) => setState(() => _category = val),
        ),
        Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Days',
          value: _day,
          isTwoLine: true,
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