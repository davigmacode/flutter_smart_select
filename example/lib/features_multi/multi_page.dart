import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import '../choices.dart' as choices;

class FeaturesMultiPage extends StatefulWidget {
  @override
  _FeaturesMultiPageState createState() => _FeaturesMultiPageState();
}

class _FeaturesMultiPageState extends State<FeaturesMultiPage> {
  List<String>? _day = ['fri'];
  List<String>? _month = ['apr'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Days',
          selectedValue: _day,
          choiceItems: choices.days,
          onChange: (selected) => setState(() => _day = selected?.value),
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Month',
          selectedValue: _month,
          choiceItems: choices.months,
          modalType: S2ModalType.fullPage,
          onChange: (selected) => setState(() => _month = selected?.value),
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}
