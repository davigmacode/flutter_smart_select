import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../choices.dart' as choices;

class FeaturesChoicesGrouped extends StatefulWidget {
  @override
  _FeaturesChoicesGroupedState createState() => _FeaturesChoicesGroupedState();
}

class _FeaturesChoicesGroupedState extends State<FeaturesChoicesGrouped> {
  String? _smartphone;
  List<String>? _car;

  Color get primaryColor => Theme.of(context).primaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String?>.single(
          title: 'Smartphones',
          placeholder: 'Choose one',
          selectedValue: _smartphone,
          onChange: (selected) {
            setState(() => _smartphone = selected.value);
          },
          choiceItems: S2Choice.listFrom<String, Map<String, String>>(
            source: choices.smartphones,
            value: (index, item) => item['id'] ?? '',
            title: (index, item) => item['name'] ?? '',
            group: (index, item) => item['brand'] ?? '',
          ),
          groupEnabled: true,
          groupSortBy: S2GroupSort.byCountInDesc(),
          modalType: S2ModalType.bottomSheet,
          tileBuilder: (context, state) {
            return S2Tile<dynamic>(
              title: state.titleWidget,
              value: state.selected?.toWidget() ?? Container(),
              onTap: state.showModal,
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
        SmartSelect<String>.multiple(
          title: 'Cars',
          placeholder: 'Choose one or more',
          selectedValue: _car,
          onChange: (selected) => setState(() => _car = selected?.value),
          choiceItems: S2Choice.listFrom<String, Map<String, String>>(
            source: choices.cars,
            value: (index, item) => item['value'] ?? '',
            title: (index, item) => item['title'] ?? '',
            group: (index, item) => item['body'] ?? '',
          ),
          choiceActiveStyle: const S2ChoiceStyle(color: Colors.redAccent),
          modalType: S2ModalType.bottomSheet,
          modalConfirm: true,
          modalFilter: true,
          groupEnabled: true,
          groupSortBy: S2GroupSort.byNameInAsc(),
          groupBuilder: (context, state, group) {
            return StickyHeader(
              header: state.groupHeader(group),
              content: state.groupChoices(group),
            );
          },
          groupHeaderBuilder: (context, state, group) {
            return Container(
              color: primaryColor,
              padding: const EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: S2Text(
                text: group.name,
                highlight: state.filter?.value,
                highlightColor: Colors.teal,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
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
        const SizedBox(height: 7),
      ],
    );
  }
}
