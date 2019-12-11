import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesMultiSheet extends StatefulWidget {
  @override
  _FeaturesMultiSheetState createState() => _FeaturesMultiSheetState();
}

class _FeaturesMultiSheetState extends State<FeaturesMultiSheet> {

  List _os = ['and', 'tux'];
  List _hero = ['bat', 'spi'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect.sheet(
          title: 'OS',
          value: _os,
          isTwoLine: true,
          option: SmartSelectOption(
            options.os,
            isMultiChoice: true,
          ),
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
            isMultiChoice: true,
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