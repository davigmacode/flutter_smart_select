import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesModalHeaderless extends StatefulWidget {
  @override
  _FeaturesModalHeaderlessState createState() => _FeaturesModalHeaderlessState();
}

class _FeaturesModalHeaderlessState extends State<FeaturesModalHeaderless> {

  List _fruit = ['mel'];
  List _hero = ['bat', 'spi'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Fruit',
          value: _fruit,
          isTwoLine: true,
          isMultiChoice: true,
          option: SmartSelectOptionConfig(
            options.fruits,
          ),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.popupDialog,
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
        SmartSelect(
          title: 'Super Hero',
          value: _hero,
          isTwoLine: true,
          isMultiChoice: true,
          option: SmartSelectOptionConfig(
            options.heroes,
          ),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.bottomSheet,
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