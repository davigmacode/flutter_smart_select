import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesSingleHeaderless extends StatefulWidget {
  @override
  _FeaturesSingleHeaderlessState createState() => _FeaturesSingleHeaderlessState();
}

class _FeaturesSingleHeaderlessState extends State<FeaturesSingleHeaderless> {

  String _fruit = 'mel';
  String _os = 'win';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect.sheet(
          title: 'Fruit',
          value: _fruit,
          option: SmartSelectOption(
            options.fruits,
            useHeader: false,
          ),
          leading: const Icon(Icons.shopping_cart),
          onChange: (val) => setState(() => _fruit = val),
        ),
        Divider(indent: 20),
        SmartSelect.popup(
          title: 'OS',
          value: _os,
          option: SmartSelectOption(
            options.os,
            useHeader: false,
          ),
          isTwoLine: true,
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
          ),
          onChange: (val) => setState(() => _os = val)
        ),
        Container(height: 7),
      ],
    );
  }
}