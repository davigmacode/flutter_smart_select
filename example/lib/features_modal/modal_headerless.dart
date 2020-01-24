import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesModalHeaderless extends StatefulWidget {
  @override
  _FeaturesModalHeaderlessState createState() => _FeaturesModalHeaderlessState();
}

class _FeaturesModalHeaderlessState extends State<FeaturesModalHeaderless> {

  List<String> _fruit = ['mel'];
  List<String> _hero = ['bat', 'spi'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect<String>.multiple(
          title: 'Fruit',
          value: _fruit,
          isTwoLine: true,
          options: options.fruits,
          modalType: SmartSelectModalType.popupDialog,
          modalConfig: SmartSelectModalConfig(
            useHeader: false,
          ),
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.shopping_cart),
          ),
          onChange: (val) => setState(() => _fruit = val),
        ),
        Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Super Hero',
          value: _hero,
          isTwoLine: true,
          options: options.heroes,
          modalType: SmartSelectModalType.bottomSheet,
          modalConfig: SmartSelectModalConfig(
            useHeader: false,
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