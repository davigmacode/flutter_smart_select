import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesMultiSheet extends StatefulWidget {
  @override
  _FeaturesMultiSheetState createState() => _FeaturesMultiSheetState();
}

class _FeaturesMultiSheetState extends State<FeaturesMultiSheet> {

  List<String> _os = ['and', 'tux'];
  List<String> _hero = ['bat', 'spi'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          value: _os,
          options: options.os,
          title: 'OS',
          modalType: S2ModalType.bottomSheet,
          onChange: (state) => setState(() => _os = state.value),
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
        SmartSelect<String>.multiple(
          value: _hero,
          options: options.heroes,
          title: 'Super Hero',
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
        Container(height: 7),
      ],
    );
  }
}