import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';

class FeaturesOptionListOfList extends StatefulWidget {
  @override
  _FeaturesOptionListOfListState createState() =>
      _FeaturesOptionListOfListState();
}

class _FeaturesOptionListOfListState extends State<FeaturesOptionListOfList> {
  String? _month = 'apr';

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
        const SizedBox(height: 7),
        SmartSelect<String?>.single(
          title: 'Month',
          selectedValue: _month,
          onChange: (selected) => setState(() => _month = selected.value),
          choiceItems: S2Choice.listFrom<String, List<String>>(
            source: monthsOption,
            value: (index, item) => item[0],
            title: (index, item) => item[1],
          ),
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}
