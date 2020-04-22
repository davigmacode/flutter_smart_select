import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesMultiSwitches extends StatefulWidget {
  @override
  _FeaturesMultiSwitchesState createState() => _FeaturesMultiSwitchesState();
}

class _FeaturesMultiSwitchesState extends State<FeaturesMultiSwitches> {

  List<String> _car = [];
  List<String> _smartphone = [];
  List<String> _days = [];

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
          onChange: (state) => setState(() => _car = state.value),
          modalFilter: true,
          choiceType: S2ChoiceType.switches,
          choiceGrouped: true,
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
          onChange: (state) => setState(() => _smartphone = state.value),
          modalType: S2ModalType.bottomSheet,
          modalFilter: true,
          choiceType: S2ChoiceType.switches,
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
          value: _days,
          options: options.days,
          choiceType: S2ChoiceType.switches,
          modalType: S2ModalType.popupDialog,
          onChange: (state) => setState(() => _days = state.value),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
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