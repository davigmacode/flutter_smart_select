import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesMultiSwitches extends StatefulWidget {
  @override
  _FeaturesMultiSwitchesState createState() => _FeaturesMultiSwitchesState();
}

class _FeaturesMultiSwitchesState extends State<FeaturesMultiSwitches> {

  List<String> _car = [];
  List<String> _smartphone = [];
  List<String> _days = [];

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
          modalConfig: SmartSelectModalConfig(
            useFilter: true,
          ),
          choiceType: SmartSelectChoiceType.switches,
          choiceConfig: SmartSelectChoiceConfig(isGrouped: true),
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
            useFilter: true,
          ),
          choiceType: SmartSelectChoiceType.switches,
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
          ),
          onChange: (val) => setState(() => _smartphone = val),
        ),
        Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Days',
          value: _days,
          isTwoLine: true,
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.calendar_today),
          ),
          options: options.days,
          choiceType: SmartSelectChoiceType.switches,
          modalType: SmartSelectModalType.popupDialog,
          onChange: (val) => setState(() => _days = val)
        ),
        Container(height: 7),
      ],
    );
  }
}