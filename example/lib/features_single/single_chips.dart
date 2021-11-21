import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import '../choices.dart' as choices;

class FeaturesSingleChips extends StatefulWidget {
  @override
  _FeaturesSingleChipsState createState() => _FeaturesSingleChipsState();
}

class _FeaturesSingleChipsState extends State<FeaturesSingleChips> {
  String? _car = '';
  String? _category = '';
  String? _day = 'fri';

  @override
  Widget build(BuildContext context) {
    final test = S2Choice.listFrom<String, Map<String, String>>(
      source: choices.cars,
      value: (index, item) => item['value'] ?? '',
      title: (index, item) => item['title'] ?? '',
      group: (index, item) => item['brand'] ?? '',
    );

    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String?>.single(
          selectedValue: _car,
          choiceItems: test,
          modalTitle: 'Cars Option',
          modalType: S2ModalType.bottomSheet,
          choiceType: S2ChoiceType.chips,
          choiceGrouped: true,
          choiceDirection: Axis.horizontal,
          onChange: (selected) => setState(() => _car = selected.value),
          tileBuilder: (context, state) => S2Tile<dynamic>(
            title: const Text('Car'),
            value: state.selected?.toWidget() ?? Container(),
            isTwoLine: true,
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://source.unsplash.com/yeVtxxPxzbw/100x100',
              ),
            ),
            onTap: state.showModal,
          ),
        ),
        const Divider(indent: 20),
        SmartSelect<String?>.single(
          title: 'Category',
          selectedValue: _category,
          choiceItems: choices.categories,
          modalType: S2ModalType.bottomSheet,
          choiceType: S2ChoiceType.chips,
          choiceStyle: S2ChoiceStyle(outlined: true, showCheckmark: true),
          onChange: (selected) => setState(() => _category = selected.value),
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
        SmartSelect<String?>.single(
          title: 'Days',
          selectedValue: _day,
          choiceItems: choices.days,
          onChange: (selected) => setState(() => _day = selected.value),
          modalType: S2ModalType.popupDialog,
          choiceType: S2ChoiceType.chips,
          choiceStyle: S2ChoiceStyle(
            color: Colors.blueGrey,
            raised: true,
          ),
          choiceActiveStyle: S2ChoiceStyle(
            color: Theme.of(context).primaryColor,
            raised: true,
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
