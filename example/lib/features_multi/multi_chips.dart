import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

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
          options: S2Option.listFrom<String, Map>(
            source: options.cars,
            value: (index, item) => item['value'],
            title: (index, item) => item['title'],
            group: (index, item) => item['brand'],
          ),
          choiceType: S2ChoiceType.chips,
          choiceGrouped: true,
          modalFilter: true,
          onChange: (state) => setState(() => _car = state.value),
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
          options: S2Option.listFrom<String, Map>(
            source: options.smartphones,
            value: (index, item) => item['id'],
            title: (index, item) => item['name'],
          ),
          modalType: S2ModalType.bottomSheet,
          modalFilter: true,
          choiceType: S2ChoiceType.chips,
          onChange: (state) => setState(() => _smartphone = state.value),
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
          options: options.days,
          choiceType: S2ChoiceType.chips,
          modalType: S2ModalType.popupDialog,
          onChange: (state) => setState(() => _day = state.value),
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