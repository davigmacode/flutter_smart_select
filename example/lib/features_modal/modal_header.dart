import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../widgets/icon_badge.dart';
import '../options.dart' as options;

class FeaturesModalHeader extends StatefulWidget {
  @override
  _FeaturesModalHeaderState createState() => _FeaturesModalHeaderState();
}

class _FeaturesModalHeaderState extends State<FeaturesModalHeader> {

  List _month = ['apr'];
  String _framework = 'flu';
  List _hero = ['bat', 'spi'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Month',
          value: _month,
          isTwoLine: true,
          isMultiChoice: true,
          leading: IconBadge(
            icon: const Icon(Icons.calendar_today),
            counter: _month.length,
          ),
          option: SmartSelectOptionConfig(options.months),
          modal: SmartSelectModalConfig(
            useFilter: true,
            headerStyle: SmartSelectModalHeaderStyle(
              elevation: 4,
              centerTitle: true,
              backgroundColor: Colors.red,
              textStyle: TextStyle(color: Colors.white),
              iconTheme: IconThemeData(color: Colors.white),
              actionsIconTheme: IconThemeData(color: Colors.white),
            ),
          ),
          onChange: (val) => setState(() => _month = val)
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Frameworks',
          value: _framework,
          option: SmartSelectOptionConfig(options.frameworks),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.popupDialog,
            headerStyle: SmartSelectModalHeaderStyle(
              backgroundColor: Colors.blueGrey[50],
              centerTitle: true,
              elevation: 0,
            ),
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              '${_framework[0]}',
              style: TextStyle(color: Colors.white)
            ),
          ),
          onChange: (val) => setState(() => _framework = val),
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Super Hero',
          value: _hero,
          isTwoLine: true,
          isMultiChoice: true,
          option: SmartSelectOptionConfig(options.heroes),
          modal: SmartSelectModalConfig(
            useFilter: true,
            type: SmartSelectModalType.bottomSheet,
            headerStyle: SmartSelectModalHeaderStyle(
              centerTitle: true,
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/8I-ht65iRww/100x100'),
          ),
          onChange: (val) => setState(() => _hero = val),
        ),
        Container(height: 7),
      ],
    );
  }
}