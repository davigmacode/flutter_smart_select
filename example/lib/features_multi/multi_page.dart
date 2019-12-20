import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesMultiPage extends StatefulWidget {
  @override
  _FeaturesMultiPageState createState() => _FeaturesMultiPageState();
}

class _FeaturesMultiPageState extends State<FeaturesMultiPage> {

  List _day = ['fri'];
  List _month = ['apr'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Days',
          value: _day,
          isMultiChoice: true,
          option: SmartSelectOptionConfig(
            options.days,
          ),
          onChange: (val) => setState(() => _day = val)
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Month',
          value: _month,
          isMultiChoice: true,
          option: SmartSelectOptionConfig(
            options.months,
          ),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.fullPage,
          ),
          onChange: (val) => setState(() => _month = val)
        ),
        Container(height: 7),
      ],
    );
  }
}