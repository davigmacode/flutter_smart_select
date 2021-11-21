import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import '../widgets/icon_badge.dart';
import '../choices.dart' as choices;

class FeaturesTileLeading extends StatefulWidget {
  @override
  _FeaturesTileLeadingState createState() => _FeaturesTileLeadingState();
}

class _FeaturesTileLeadingState extends State<FeaturesTileLeading> {
  String? _day = 'fri';
  List<String>? _month = ['apr'];
  String? _framework = 'flu';
  List<String>? _hero = ['bat', 'spi'];

  Color get primaryColor => Theme.of(context).primaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String?>.single(
          title: 'Days',
          selectedValue: _day,
          choiceItems: choices.days,
          onChange: (selected) => setState(() => _day = selected.value),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              leading: const Icon(Icons.calendar_today),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Month',
          selectedValue: _month,
          choiceItems: choices.months,
          onChange: (selected) => setState(() => _month = selected?.value),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: IconBadge(
                icon: const Icon(Icons.calendar_today),
                counter: _month?.length ?? 0,
              ),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String?>.single(
          title: 'Frameworks',
          selectedValue: _framework,
          choiceItems: choices.frameworks,
          onChange: (selected) {
            setState(() => _framework = selected.value);
          },
          modalType: S2ModalType.popupDialog,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              leading: CircleAvatar(
                backgroundColor: primaryColor,
                child: Text(
                  '${state.selected.toString()[0]}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Super Hero',
          selectedValue: _hero,
          choiceItems: choices.heroes,
          onChange: (selected) => setState(() => _hero = selected?.value),
          modalType: S2ModalType.bottomSheet,
          modalFilter: true,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://source.unsplash.com/8I-ht65iRww/100x100',
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
