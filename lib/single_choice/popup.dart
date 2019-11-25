import 'package:flutter/material.dart';
import './radios.dart';

class SmartSelectPopup extends StatelessWidget {

  final String title;
  final dynamic value;
  final List<Map<String,dynamic>> options;

  SmartSelectPopup({
    Key key,
    this.title,
    this.value,
    this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SmartSelectRadios(
        value: value,
        options: options,
      ),
    );
  }
}
