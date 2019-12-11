import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesSingleSheet extends StatefulWidget {
  @override
  _FeaturesSingleSheetState createState() => _FeaturesSingleSheetState();
}

class _FeaturesSingleSheetState extends State<FeaturesSingleSheet> {

  String _os = 'win';
  String _hero = 'iro';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect.sheet(
          title: 'OS',
          value: _os,
          option: SmartSelectOption(options.os),
          isTwoLine: true,
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
          ),
          onChange: (val) => setState(() => _os = val)
        ),
        Divider(indent: 20),
        SmartSelect.sheet(
          title: 'Super Hero',
          value: _hero,
          isTwoLine: true,
          option: SmartSelectOption(
            options.heroes,
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