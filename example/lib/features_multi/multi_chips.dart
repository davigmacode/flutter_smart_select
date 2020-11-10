import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../choices.dart' as choices;

class FeaturesMultiChips extends StatefulWidget {
  @override
  _FeaturesMultiChipsState createState() => _FeaturesMultiChipsState();
}

class _FeaturesMultiChipsState extends State<FeaturesMultiChips> {

  List<String> _car = [];
  List<String> _smartphone = [];
  List<String> _day = ['fri'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Car',
          value: _car,
          onChange: (state) => setState(() => _car = state.value),
          choiceItems: S2Choice.listFrom<String, Map>(
            source: choices.cars,
            value: (index, item) => item['value'],
            title: (index, item) => item['title'],
            group: (index, item) => item['brand'],
          ),
          choiceType: S2ChoiceType.chips,
          choiceGrouped: true,
          modalFilter: true,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/yeVtxxPxzbw/100x100'),
              ),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Smartphones',
          value: _smartphone,
          onChange: (state) => setState(() => _smartphone = state.value),
          choiceType: S2ChoiceType.chips,
          choiceItems: S2Choice.listFrom<String, Map>(
            source: choices.smartphones,
            value: (index, item) => item['id'],
            title: (index, item) => item['name'],
          ),
          modalConfig: S2ModalConfig(
            type: S2ModalType.bottomSheet,
            useFilter: true,
            maxHeightFactor: .7
          ),
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
          title: 'Days',
          value: _day,
          onChange: (state) => setState(() => _day = state.value),
          choiceItems: choices.days,
          choiceType: S2ChoiceType.chips,
          modalType: S2ModalType.popupDialog,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              leading: Container(
                width: 40,
                alignment: Alignment.center,
                child: const Icon(Icons.calendar_today),
              ),
            );
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}