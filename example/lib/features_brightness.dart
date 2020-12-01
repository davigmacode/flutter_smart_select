import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:theme_patrol/theme_patrol.dart';

class FeaturesBrightness extends StatefulWidget {
  @override
  _FeaturesBrightnessState createState() => _FeaturesBrightnessState();
}

class _FeaturesBrightnessState extends State<FeaturesBrightness> {

  ThemeData get theme => Theme.of(context);

  final List<S2Choice<int>> modes = [
    S2Choice(value: 0, title: 'System', meta: Icons.brightness_auto),
    S2Choice(value: 1, title: 'Light', meta: Icons.brightness_low),
    S2Choice(value: 2, title: 'Dark', meta: Icons.brightness_2),
  ];

  @override
  Widget build(BuildContext context) {
    return SmartSelect<int>.single(
      title: 'Brightness',
      value: ThemePatrol.of(context).themeMode.index,
      onChange: (state) => ThemePatrol.of(context).setMode(ThemeMode.values[state.value]),
      modalType: S2ModalType.bottomSheet,
      modalHeader: false,
      choiceItems: modes,
      choiceConfig: const S2ChoiceConfig(
        type: S2ChoiceType.cards,
        layout: S2ChoiceLayout.grid,
        gridCount: 3,
        gridSpacing: 5,
      ),
      choiceStyle: S2ChoiceStyle(
        spacing: 7
      ),
      choiceActiveStyle: S2ChoiceStyle(
        titleStyle: TextStyle(color: Colors.white)
      ),
      choiceSecondaryBuilder: (context, state, choice) {
        return Icon(
          choice.meta,
          size: 48,
          color: choice.selected ? Colors.white : null
        );
      },
      tileBuilder: (context, state) {
        return IconButton(
          icon: Icon(modes[state.value].meta),
          onPressed: state.showModal
        );
      },
    );
  }
}