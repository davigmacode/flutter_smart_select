import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';

class FeaturesOptionListOfMap extends StatefulWidget {
  @override
  _FeaturesOptionListOfMapState createState() =>
      _FeaturesOptionListOfMapState();
}

class _FeaturesOptionListOfMapState extends State<FeaturesOptionListOfMap> {
  List<String>? _day = ['fri'];
  List<Map<String, String>> _days = [
    {'value': 'mon', 'title': 'Monday'},
    {'value': 'tue', 'title': 'Tuesday'},
    {'value': 'wed', 'title': 'Wednesday'},
    {'value': 'thu', 'title': 'Thursday'},
    {'value': 'fri', 'title': 'Friday'},
    {'value': 'sat', 'title': 'Saturday'},
    {'value': 'sun', 'title': 'Sunday'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Days',
          selectedValue: _day,
          onChange: (selected) => setState(() => _day = selected?.value),
          choiceItems: S2Choice.listFrom<String, Map<String, String>>(
            source: _days,
            value: (index, item) => item['value'] ?? '',
            title: (index, item) => item['title'] ?? '',
          ),
          choiceType: S2ChoiceType.switches,
          modalType: S2ModalType.bottomSheet,
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
