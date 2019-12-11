import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesMultiConfirm extends StatefulWidget {
  @override
  _FeaturesMultiConfirmState createState() => _FeaturesMultiConfirmState();
}

class _FeaturesMultiConfirmState extends State<FeaturesMultiConfirm> {

  List _day = ['fri'];
  List _fruit = ['mel'];
  List _hero = ['bat', 'spi'];

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
            isMultiChoice: true,
            useConfirmation: true,
          ),
          isTwoLine: true,
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
          ),
          onChange: (val) => setState(() => _day = val)
        ),
        Divider(indent: 20),
        SmartSelect.popup(
          title: 'Fruit',
          value: _fruit,
          isTwoLine: true,
          option: SmartSelectOption(
            options.fruits,
            isMultiChoice: true,
            useConfirmation: true,
          ),
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.shopping_cart),
          ),
          onChange: (val) => setState(() => _fruit = val),
        ),
        Divider(indent: 20),
        SmartSelect.sheet(
          title: 'Super Hero',
          value: _hero,
          isTwoLine: true,
          option: SmartSelectOption(
            options.heroes,
            isMultiChoice: true,
            useConfirmation: true,
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