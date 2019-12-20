import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class FeaturesOptionListOfMap extends StatefulWidget {
  @override
  _FeaturesOptionListOfMapState createState() => _FeaturesOptionListOfMapState();
}

class _FeaturesOptionListOfMapState extends State<FeaturesOptionListOfMap> {

  List _day = ['fri'];
  List<Map<String,dynamic>> _days = [
    { 'value': 'mon', 'title': 'Monday' },
    { 'value': 'tue', 'title': 'Tuesday' },
    { 'value': 'wed', 'title': 'Wednesday' },
    { 'value': 'thu', 'title': 'Thursday' },
    { 'value': 'fri', 'title': 'Friday' },
    { 'value': 'sat', 'title': 'Saturday' },
    { 'value': 'sun', 'title': 'Sunday' },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Days',
          value: _day,
          isTwoLine: true,
          isMultiChoice: true,
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.calendar_today),
          ),
          option: SmartSelectOptionConfig(_days),
          choice: SmartSelectChoiceConfig(type: SmartSelectChoiceType.switches),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.bottomSheet,
            // useFilter: true
          ),
          onChange: (val) => setState(() => _day = val)
        ),
        Container(height: 7),
      ],
    );
  }
}