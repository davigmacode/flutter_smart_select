import 'package:flutter/material.dart';
import './radios.dart';

class SmartSelectSheet extends StatelessWidget {

  final String title;
  final dynamic value;
  final List<Map<String,dynamic>> options;

  SmartSelectSheet({
    Key key,
    this.title,
    this.value,
    this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartSelectRadios(
      value: value,
      options: options,
    );
  }
}