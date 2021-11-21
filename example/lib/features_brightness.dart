import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';

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
    return Container();
  }
}
