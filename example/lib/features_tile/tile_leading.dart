import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../widgets/icon_badge.dart';
import '../options.dart' as options;

class FeaturesTileLeading extends StatefulWidget {
  @override
  _FeaturesTileLeadingState createState() => _FeaturesTileLeadingState();
}

class _FeaturesTileLeadingState extends State<FeaturesTileLeading> {

  String _day = 'fri';
  List<String> _month = ['apr'];
  String _framework = 'flu';
  List<String> _hero = ['bat', 'spi'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.single(
          title: 'Days',
          value: _day,
          options: options.days,
          onChange: (state) => setState(() => _day = state.value),
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
          value: _month,
          options: options.months,
          onChange: (state) => setState(() => _month = state.value),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: IconBadge(
                icon: const Icon(Icons.calendar_today),
                counter: _month.length,
              ),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Frameworks',
          value: _framework,
          options: options.frameworks,
          onChange: (state) => setState(() => _framework = state.value),
          modalType: S2ModalType.popupDialog,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  '${state.valueDisplay[0]}',
                  style: TextStyle(color: Colors.white)
                ),
              ),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Super Hero',
          value: _hero,
          options: options.heroes,
          onChange: (state) => setState(() => _hero = state.value),
          modalType: S2ModalType.bottomSheet,
          modalFilter: true,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/8I-ht65iRww/100x100'),
              ),
            );
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}