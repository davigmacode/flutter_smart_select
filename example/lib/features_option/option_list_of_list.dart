import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class FeaturesOptionListOfList extends StatefulWidget {
  @override
  _FeaturesOptionListOfListState createState() => _FeaturesOptionListOfListState();
}

class _FeaturesOptionListOfListState extends State<FeaturesOptionListOfList> {

  String _month = 'apr';

  List<List<String>> monthsOption = [
    ['jan', 'January'],
    ['feb', 'February'],
    ['mar', 'March'],
    ['apr', 'April'],
    ['may', 'May'],
    ['jun', 'June'],
    ['jul', 'July'],
    ['aug', 'August'],
    ['sep', 'September'],
    ['oct', 'October'],
    ['nov', 'November'],
    ['dec', 'December'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Month',
          value: _month,
          option: SmartSelectOptionConfig(monthsOption),
          onChange: (val) => setState(() => _month = val)
        ),
        Container(height: 7),
      ],
    );
  }
}