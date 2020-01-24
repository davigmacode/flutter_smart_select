import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class FeaturesOptionListOfMap extends StatefulWidget {
  @override
  _FeaturesOptionListOfMapState createState() => _FeaturesOptionListOfMapState();
}

class _FeaturesOptionListOfMapState extends State<FeaturesOptionListOfMap> {

  List<String> _day = ['fri'];
  List<Map<String, String>> _days = [
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
        SmartSelect<String>.multiple(
          title: 'Days',
          value: _day,
          isTwoLine: true,
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.calendar_today),
          ),
          options: SmartSelectOption.listFrom<String, Map<String, String>>(
            source: _days,
            value: (index, item) => item['value'],
            title: (index, item) => item['title'],
          ),
          choiceType: SmartSelectChoiceType.switches,
          modalType: SmartSelectModalType.bottomSheet,
          onChange: (val) => setState(() => _day = val)
        ),
        Container(height: 7),
      ],
    );
  }
}