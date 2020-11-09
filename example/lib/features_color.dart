import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:theme_patrol/theme_patrol.dart';

class FeaturesColor extends StatefulWidget {
  @override
  _FeaturesColorState createState() => _FeaturesColorState();
}

class _FeaturesColorState extends State<FeaturesColor> {

  Color _themeColor = Colors.red;

  ThemeData get theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return SmartSelect<Color>.single(
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
      choiceBuilder: (context, choice, _) {
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
        return IconButton(
          icon: Icon(Icons.color_lens),
          onPressed: state.showModal
        );
      },
    );
  }
}