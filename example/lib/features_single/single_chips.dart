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
        SmartSelect(
          title: 'Car',
          value: _car,
          isTwoLine: true,
          option: SmartSelectOptionConfig(options.cars),
          modal: SmartSelectModalConfig(
            title: 'Cars Option',
            type: SmartSelectModalType.fullPage,
            // leading: Container(
            //   padding: EdgeInsets.all(10.0),
            //   child: Text('To hot reload changes while running, press "r". To hot restart (and rebuild state), press "R"'),
            // ),
            // trailing: Container(
            //   padding: EdgeInsets.all(10.0),
            //   child: Text('To hot reload changes while running, press "r". To hot restart (and rebuild state), press "R"'),
            // ),
          ),
          choice: SmartSelectChoiceConfig(type: SmartSelectChoiceType.chips),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/yeVtxxPxzbw/100x100'),
          ),
          onChange: (val) => setState(() => _car = val),
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Category',
          isTwoLine: true,
          value: _category,
          option: SmartSelectOptionConfig(
            options.categories,
            value: 'slug',
            title: 'caption',
            // groupBy: 'category',
          ),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.bottomSheet,
            // useFilter: true
          ),
          choice: SmartSelectChoiceConfig(type: SmartSelectChoiceType.chips),
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.label_outline),
          ),
          onChange: (val) => setState(() => _category = val),
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Days',
          value: _day,
          isTwoLine: true,
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.calendar_today),
          ),
          option: SmartSelectOptionConfig(options.days),
          choice: SmartSelectChoiceConfig(type: SmartSelectChoiceType.chips),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.popupDialog,
            // useFilter: true
          ),
          onChange: (val) => setState(() => _day = val)
        ),
        Container(height: 7),
      ],
    );
  }
}