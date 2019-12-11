import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesSingleConfirm extends StatefulWidget {
  @override
  _FeaturesSingleConfirmState createState() => _FeaturesSingleConfirmState();
}

class _FeaturesSingleConfirmState extends State<FeaturesSingleConfirm> {

  String _day = 'fri';
  String _hero = 'iro';
  String _fruit = 'mel';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Days',
          value: _day,
          option: SmartSelectOption(
            options.days,
            useConfirmation: true
          ),
          isTwoLine: true,
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
          ),
          onChange: (val) => setState(() => _day = val)
        ),
        Divider(indent: 20),
        SmartSelect.sheet(
          title: 'Super Hero',
          value: _hero,
          isTwoLine: true,
          option: SmartSelectOption(
            options.heroes,
            useConfirmation: true
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/8I-ht65iRww/100x100'),
          ),
          onChange: (val) => setState(() => _hero = val),
        ),
        Divider(indent: 20),
        SmartSelect.popup(
          title: 'Fruit',
          value: _fruit,
          option: SmartSelectOption(
            options.fruits,
            useConfirmation: true
          ),
          leading: const Icon(Icons.shopping_cart),
          onChange: (val) => setState(() => _fruit = val),
        ),
        Container(height: 7),
      ],
    );
  }
}