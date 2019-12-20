import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesMultiChips extends StatefulWidget {
  @override
  _FeaturesMultiChipsState createState() => _FeaturesMultiChipsState();
}

class _FeaturesMultiChipsState extends State<FeaturesMultiChips> {

  List _car = [];
  List _smartphone = [];
  List _day = ['fri'];

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
          modal: SmartSelectModalConfig(useFilter: true),
          choice: SmartSelectChoiceConfig(type: SmartSelectChoiceType.chips),
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
            useFilter: true
          ),
          choice: SmartSelectChoiceConfig(type: SmartSelectChoiceType.chips),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
          ),
          onChange: (val) => setState(() => _smartphone = val),
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Days',
          value: _day,
          isMultiChoice: true,
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