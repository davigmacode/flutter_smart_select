import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesMultiSwitches extends StatefulWidget {
  @override
  _FeaturesMultiSwitchesState createState() => _FeaturesMultiSwitchesState();
}

class _FeaturesMultiSwitchesState extends State<FeaturesMultiSwitches> {

  List _car = [];
  List _smartphone = [];
  List _days = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Car',
          value: _car,
          isTwoLine: true,
          isMultiChoice: true,
          option: SmartSelectOptionConfig(
            options.cars,
            groupBy: 'brand',
          ),
          modal: SmartSelectModalConfig(
            useFilter: true,
          ),
          choice: SmartSelectChoiceConfig(
            type: SmartSelectChoiceType.switches
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/yeVtxxPxzbw/100x100'),
          ),
          onChange: (val) => setState(() => _car = val),
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Smartphones',
          value: _smartphone,
          isTwoLine: true,
          isMultiChoice: true,
          option: SmartSelectOptionConfig(
            options.smartphones,
            value: 'id',
            title: 'name',
          ),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.bottomSheet,
            useFilter: true,
          ),
          choice: SmartSelectChoiceConfig(
            type: SmartSelectChoiceType.switches
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
          ),
          onChange: (val) => setState(() => _smartphone = val),
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Days',
          value: _days,
          isTwoLine: true,
          isMultiChoice: true,
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.calendar_today),
          ),
          option: SmartSelectOptionConfig(options.days),
          choice: SmartSelectChoiceConfig(type: SmartSelectChoiceType.switches),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.popupDialog,
          ),
          onChange: (val) => setState(() => _days = val)
        ),
        Container(height: 7),
      ],
    );
  }
}