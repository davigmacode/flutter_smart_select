import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../choices.dart' as choices;

class FeaturesMultiPage extends StatefulWidget {
  @override
  _FeaturesMultiPageState createState() => _FeaturesMultiPageState();
}

class _FeaturesMultiPageState extends State<FeaturesMultiPage> {

  List<String> _day = ['fri'];
  List<String> _month = ['apr'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Days',
          value: _day,
          choiceItems: choices.days,
          onChange: (state) => setState(() => _day = state.value),
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Month',
          value: _month,
          choiceItems: choices.months,
          modalType: S2ModalType.fullPage,
          onChange: (state) => setState(() => _month = state.value),
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}