import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:theme_patrol/theme_patrol.dart';

class FeaturesTheme extends StatefulWidget {
  @override
  _FeaturesThemeState createState() => _FeaturesThemeState();
}

class _FeaturesThemeState extends State<FeaturesTheme> {

  Color _themeColor = Colors.red;

  ThemeData get theme => Theme.of(context);

  List<List> modes = [
    [ThemeMode.system, 'System', Icons.brightness_auto],
    [ThemeMode.light, 'Light', Icons.brightness_low],
    [ThemeMode.dark, 'Dark', Icons.brightness_2],
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SmartSelect<ThemeMode>.single(
            title: 'Brightness',
            value: ThemePatrol.of(context).themeMode,
            onChange: (state) => ThemePatrol.of(context).setMode(state.value),
            modalType: S2ModalType.bottomSheet,
            modalHeader: false,
            choiceItems: S2Choice.listFrom<ThemeMode, List>(
              source: modes,
              value: (i, v) => v[0],
              title: (i, v) => v[1],
              meta: (i, v) => v[2],
            ),
            choiceLayout: S2ChoiceLayout.grid,
            choiceGrid: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              crossAxisCount: 3
            ),
            choiceBuilder: (context, state, choice) {
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
              return S2Tile.fromState(
                state,
                isTwoLine: true,
                trailing: ThemePatrol.of(context).isLightMode
                  ? const Icon(Icons.brightness_low)
                  : ThemePatrol.of(context).isDarkMode
                    ? const Icon(Icons.brightness_2)
                    : const Icon(Icons.brightness_auto),
              );
            },
          ),
        ),
        const SizedBox(
          height: 40,
          child: VerticalDivider(width: 1),
        ),
        Expanded(
          child: SmartSelect<Color>.single(
            title: 'Color',
            value: _themeColor,
            onChange: (state) {
              setState(() => _themeColor = state.value);
              ThemePatrol.of(context).setColor(_themeColor);
            },
            choiceItems: S2Choice.listFrom<Color, Color>(
              source: Colors.primaries,
              value: (i, v) => v,
              title: (i, v) => null
            ),
            choiceLayout: S2ChoiceLayout.grid,
            choiceGrid: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              crossAxisCount: 5
            ),
            choiceBuilder: (context, state, choice) {
              return Card(
                color: choice.value,
                child: InkWell(
                  onTap: () => choice.select(true),
                  child: choice.selected
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                    : Container(),
                ),
              );
            },
            modalType: S2ModalType.popupDialog,
            modalHeader: false,
            tileBuilder: (context, state) {
              return S2Tile<Color>.fromState(
                state,
                isTwoLine: true,
                trailing: Card(
                  color: _themeColor,
                  child: const SizedBox(
                    width: 24,
                    height: 24,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}