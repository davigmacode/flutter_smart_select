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
  List _month = ['apr'];
  String _framework = 'flu';
  List _hero = ['bat', 'spi'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Days',
          value: _day,
          leading: const Icon(Icons.calendar_today),
          option: SmartSelectOptionConfig(options.days),
          onChange: (val) => setState(() => _day = val)
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Month',
          value: _month,
          isTwoLine: true,
          isMultiChoice: true,
          leading: IconBadge(
            icon: const Icon(Icons.calendar_today),
            counter: _month.length,
          ),
          option: SmartSelectOptionConfig(
            options.months,
          ),
          onChange: (val) => setState(() => _month = val)
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Frameworks',
          value: _framework,
          option: SmartSelectOptionConfig(options.frameworks),
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              '${_framework[0]}',
              style: TextStyle(color: Colors.white)
            ),
          ),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.popupDialog,
          ),
          onChange: (val) => setState(() => _framework = val),
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Super Hero',
          value: _hero,
          isTwoLine: true,
          isMultiChoice: true,
          option: SmartSelectOptionConfig(options.heroes),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.bottomSheet,
            useFilter: true
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/8I-ht65iRww/100x100'),
          ),
          onChange: (val) => setState(() => _hero = val),
        ),
        Container(height: 7),
      ],
    );
  }
}