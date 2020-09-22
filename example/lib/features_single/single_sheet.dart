import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../choices.dart' as choices;

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
        const SizedBox(height: 7),
        SmartSelect<String>.single(
          title: 'OS',
          value: _os,
          choiceItems: choices.os,
          onChange: (state) => setState(() => _os = state.value),
          modalType: S2ModalType.bottomSheet,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
              ),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Super Hero',
          value: _hero,
          choiceItems: choices.heroes,
          modalType: S2ModalType.bottomSheet,
          onChange: (state) => setState(() => _hero = state.value),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/8I-ht65iRww/100x100'),
              ),
            );
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}