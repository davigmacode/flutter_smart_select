import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../choices.dart' as choices;

class FeaturesSingleChips extends StatefulWidget {
  @override
  _FeaturesSingleChipsState createState() => _FeaturesSingleChipsState();
}

class _FeaturesSingleChipsState extends State<FeaturesSingleChips> {

  String _car = '';
  String _category = '';
  String _day = 'fri';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.single(
          value: _car,
          choiceItems: S2Choice.listFrom<String, Map>(
            source: choices.cars,
            value: (index, item) => item['value'],
            title: (index, item) => item['title'],
            group: (index, item) => item['brand'],
          ),
          modalTitle: 'Cars Option',
          modalType: S2ModalType.bottomSheet,
          choiceType: S2ChoiceType.chips,
          choiceGrouped: true,
          choiceDirection: Axis.horizontal,
          onChange: (state) => setState(() => _car = state.value),
          tileBuilder: (context, state) => S2Tile(
            title: const Text('Car'),
            value: state.valueDisplay,
            isTwoLine: true,
            leading: const CircleAvatar(
              backgroundImage: NetworkImage('https://source.unsplash.com/yeVtxxPxzbw/100x100'),
            ),
            onTap: state.showModal,
          ),
        ),
        const Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Category',
          value: _category,
          choiceItems: choices.categories,
          modalType: S2ModalType.bottomSheet,
          choiceType: S2ChoiceType.chips,
          choiceStyle: S2ChoiceStyle(
            brightness: Brightness.light
          ),
          choiceActiveStyle: S2ChoiceStyle(
            brightness: Brightness.dark,
            showCheckmark: true
          ),
          onChange: (state) => setState(() => _category = state.value),
          tileBuilder: (context, state) => S2Tile.fromState(
            state,
            isTwoLine: true,
            leading: Container(
              width: 40,
              alignment: Alignment.center,
              child: const Icon(Icons.label_outline),
            ),
          ),
        ),
        const Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Days',
          value: _day,
          choiceItems: choices.days,
          onChange: (state) => setState(() => _day = state.value),
          modalType: S2ModalType.popupDialog,
          choiceType: S2ChoiceType.chips,
          choiceStyle: S2ChoiceStyle(
            color: Colors.blueGrey[400],
            brightness: Brightness.dark,
          ),
          choiceActiveStyle: S2ChoiceStyle(
            color: Theme.of(context).primaryColor
          ),
          tileBuilder: (context, state) => S2Tile.fromState(
            state,
            isTwoLine: true,
            leading: Container(
              width: 40,
              alignment: Alignment.center,
              child: const Icon(Icons.calendar_today),
            ),
          ),
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}