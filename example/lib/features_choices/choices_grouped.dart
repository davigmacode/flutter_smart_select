import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../choices.dart' as choices;

class FeaturesChoicesGrouped extends StatefulWidget {
  @override
  _FeaturesChoicesGroupedState createState() => _FeaturesChoicesGroupedState();
}

class _FeaturesChoicesGroupedState extends State<FeaturesChoicesGrouped> {

  String _smartphone = '';
  List<String> _car = [];

  Color get primaryColor => Theme.of(context).primaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.single(
          title: 'Smartphones',
          placeholder: 'Choose one',
          value: _smartphone,
          onChange: (state) => setState(() => _smartphone = state.value),
          choiceItems: S2Choice.listFrom<String, Map>(
            source: choices.smartphones,
            value: (index, item) => item['id'],
            title: (index, item) => item['name'],
            group: (index, item) => item['brand'],
          ),
          choiceGrouped: true,
          modalType: S2ModalType.bottomSheet,
          tileBuilder: (context, state) {
            return S2Tile(
              title: state.titleWidget,
              value: state.valueDisplay,
              onTap: state.showModal,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
              ),
            );
          }
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Cars',
          placeholder: 'Choose one or more',
          value: _car,
          onChange: (state) => setState(() => _car = state.value),
          choiceItems: S2Choice.listFrom<String, Map>(
            source: choices.cars,
            value: (index, item) => item['value'],
            title: (index, item) => item['title'],
            group: (index, item) => item['body'],
          ),
          choiceGrouped: true,
          choiceActiveStyle: const S2ChoiceStyle(
            color: Colors.redAccent
          ),
          modalType: S2ModalType.bottomSheet,
          modalConfirm: true,
          modalFilter: true,
          choiceGroupBuilder: (context, header, choices) {
            return StickyHeader(
              header: header,
              content: choices,
            );
          },
          choiceHeaderBuilder: (context, group, searchText) {
            return Container(
              color: primaryColor,
              padding: const EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: S2Text(
                text: group.name,
                highlight: searchText,
                highlightColor: Colors.teal,
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            );
          },
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
        const SizedBox(height: 7),
      ],
    );
  }
}