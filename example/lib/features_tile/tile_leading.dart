import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../widgets/icon_badge.dart';
import '../options.dart' as options;

class FeaturesTileLeading extends StatefulWidget {
  @override
  _FeaturesTileLeadingState createState() => _FeaturesTileLeadingState();
}

class _FeaturesTileLeadingState extends State<FeaturesTileLeading> {

  String _day = 'fri';
  List<String> _month = ['apr'];
  String _framework = 'flu';
  List<String> _hero = ['bat', 'spi'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect<String>.single(
          title: 'Days',
          value: _day,
          options: options.days,
          onChange: (val) => setState(() => _day = val),
          leading: const Icon(Icons.calendar_today),
        ),
        Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Month',
          value: _month,
          options: options.months,
          onChange: (val) => setState(() => _month = val),
          isTwoLine: true,
          leading: IconBadge(
            icon: const Icon(Icons.calendar_today),
            counter: _month.length,
          ),
        ),
        Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Frameworks',
          value: _framework,
          options: options.frameworks,
          onChange: (val) => setState(() => _framework = val),
          modalType: SmartSelectModalType.popupDialog,
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              '${_framework[0]}',
              style: TextStyle(color: Colors.white)
            ),
          ),
        ),
        Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Super Hero',
          value: _hero,
          options: options.heroes,
          onChange: (val) => setState(() => _hero = val),
          isTwoLine: true,
          modalType: SmartSelectModalType.bottomSheet,
          modalConfig: SmartSelectModalConfig(
            useFilter: true
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/8I-ht65iRww/100x100'),
          ),
        ),
        Container(height: 7),
      ],
    );
  }
}