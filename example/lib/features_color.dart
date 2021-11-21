import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';

class FeaturesColor extends StatefulWidget {
  @override
  _FeaturesColorState createState() => _FeaturesColorState();
}

class _FeaturesColorState extends State<FeaturesColor> {
  Color? _themeColor = Colors.red;

  List<S2Choice<Color>> colors = S2Choice.listFrom<Color, Color>(
    source: Colors.primaries,
    value: (i, v) => v,
    title: (i, v) => '',
  );

  ThemeData get theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
