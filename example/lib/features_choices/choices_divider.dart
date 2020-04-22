import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesChoicesDivider extends StatefulWidget {
  @override
  _FeaturesChoicesDividerState createState() => _FeaturesChoicesDividerState();
}

class _FeaturesChoicesDividerState extends State<FeaturesChoicesDivider> {

  String _car = '';
  List<String> _smartphone = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.single(
          title: 'Car',
          placeholder: 'Choose one',
          value: _car,
          options: S2Option.listFrom<String, Map>(
            source: options.cars,
            value: (index, item) => item['value'],
            title: (index, item) => item['title'],
            group: (index, item) => item['body'],
          ),
          choiceGrouped: true,
          choiceDivider: true,
          onChange: (state) => setState(() => _car = state.value),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/yeVtxxPxzbw/100x100'),
              ),
            );
          }
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Smartphones',
          placeholder: 'Choose one',
          value: _smartphone,
          options: S2Option.listFrom<String, Map>(
            source: options.smartphones,
            value: (index, item) => item['id'],
            title: (index, item) => item['name'],
            group: (index, item) => item['brand'],
          ),
          modalType: S2ModalType.bottomSheet,
          modalFilter: true,
          choiceGrouped: true,
          choiceConfig: const S2ChoiceConfig(
            useDivider: true,
          ),
          onChange: (state) => setState(() => _smartphone = state.value),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
              ),
            );
          }
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}