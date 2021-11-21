import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import '../choices.dart' as choices;

class FeaturesSingleSwitches extends StatefulWidget {
  @override
  _FeaturesSingleSwitchesState createState() => _FeaturesSingleSwitchesState();
}

class _FeaturesSingleSwitchesState extends State<FeaturesSingleSwitches> {
  String? _car;
  String? _smartphone;
  String? _days;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String?>.single(
          title: 'Car',
          selectedValue: _car,
          onChange: (selected) => setState(() => _car = selected.value),
          choiceItems: S2Choice.listFrom<String, Map<String, String>>(
            source: choices.cars,
            value: (index, item) => item['value'] ?? '',
            title: (index, item) => item['title'] ?? '',
            group: (index, item) => item['brand'] ?? '',
          ),
          choiceType: S2ChoiceType.switches,
          choiceGrouped: true,
          modalFilter: true,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://source.unsplash.com/yeVtxxPxzbw/100x100',
                ),
              ),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String?>.single(
          title: 'Smartphones',
          selectedValue: _smartphone,
          onChange: (selected) {
            setState(() => _smartphone = selected.value);
          },
          choiceType: S2ChoiceType.switches,
          choiceItems: S2Choice.listFrom<String, Map<String, String>>(
            source: choices.smartphones,
            value: (index, item) => item['id'] ?? '',
            title: (index, item) => item['name'] ?? '',
          ),
          modalType: S2ModalType.bottomSheet,
          modalFilter: true,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://source.unsplash.com/xsGxhtAsfSA/100x100',
                ),
              ),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String?>.single(
          title: 'Days',
          selectedValue: _days,
          onChange: (selected) => setState(() => _days = selected.value),
          choiceItems: choices.days,
          choiceType: S2ChoiceType.switches,
          modalType: S2ModalType.popupDialog,
          modalConfirm: true,
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
