import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:theme_patrol/theme_patrol.dart';

class FeaturesBrightness extends StatefulWidget {
  @override
  _FeaturesBrightnessState createState() => _FeaturesBrightnessState();
}

class _FeaturesBrightnessState extends State<FeaturesBrightness> {

  ThemeData get theme => Theme.of(context);

  List<List> modes = [
    ['System', Icons.brightness_auto],
    ['Light', Icons.brightness_low],
    ['Dark', Icons.brightness_2],
  ];

  @override
  Widget build(BuildContext context) {
    return SmartSelect<int>.single(
      title: 'Brightness',
      value: ThemePatrol.of(context).themeMode.index,
      onChange: (state) => ThemePatrol.of(context).setMode(ThemeMode.values[state.value]),
      modalType: S2ModalType.bottomSheet,
      modalHeader: false,
      choiceItems: S2Choice.listFrom<int, List>(
        source: modes,
        value: (i, v) => i,
        title: (i, v) => v[0],
        meta: (i, v) => v[1],
      ),
      choiceConfig: const S2ChoiceConfig(
        layout: S2ChoiceLayout.grid,
        gridCount: 3,
        gridSpacing: 5,
      ),
      choiceBuilder: (context, choice, _) {
        return Card(
          elevation: 3,
          color: choice.selected
            ? theme.primaryColor
            : theme.cardColor,
          child: InkWell(
            onTap: () => choice.select(true),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  choice.meta,
                  size: 48,
                  color: choice.selected ? Colors.white : null
                ),
                const SizedBox(height: 5),
                Text(
                  choice.title,
                  style: TextStyle(color: choice.selected ? Colors.white : null)
                ),
              ],
            ),
          ),
        );
      },
      tileBuilder: (context, state) {
        return IconButton(
          icon: Icon(modes[state.value][1]),
          onPressed: state.showModal
        );
      },
    );
  }
}