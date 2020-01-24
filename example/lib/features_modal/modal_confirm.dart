import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesModalConfirm extends StatefulWidget {
  @override
  _FeaturesModalConfirmState createState() => _FeaturesModalConfirmState();
}

class _FeaturesModalConfirmState extends State<FeaturesModalConfirm> {

  List<String> _day = ['fri'];
  List<String> _fruit = ['mel'];
  String _hero = 'iro';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect<String>.multiple(
          title: 'Days',
          value: _day,
          isTwoLine: true,
          options: options.days,
          modalType: SmartSelectModalType.fullPage,
          modalConfig: SmartSelectModalConfig(
            useConfirmation: true,
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
          ),
          onChange: (val) => setState(() => _day = val)
        ),
        Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Fruit',
          value: _fruit,
          isTwoLine: true,
          options: options.fruits,
          modalType: SmartSelectModalType.popupDialog,
          modalConfig: SmartSelectModalConfig(
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
        SmartSelect<String>.single(
          title: 'Super Hero',
          value: _hero,
          isTwoLine: true,
          options: options.heroes,
          modalType: SmartSelectModalType.bottomSheet,
          modalConfig: SmartSelectModalConfig(
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