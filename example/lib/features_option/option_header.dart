import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../widgets/icon_badge.dart';
import '../options.dart' as options;

class FeaturesOptionHeader extends StatefulWidget {
  @override
  _FeaturesOptionHeaderState createState() => _FeaturesOptionHeaderState();
}

class _FeaturesOptionHeaderState extends State<FeaturesOptionHeader> {

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
          leading: IconBadge(
            icon: const Icon(Icons.calendar_today),
            counter: _month.length,
          ),
          option: SmartSelectOption(
            options.months,
            isMultiChoice: true,
            useFilter: true,
            headerTheme: SmartSelectOptionHeaderTheme(
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
        SmartSelect.popup(
          title: 'Frameworks',
          value: _framework,
          option: SmartSelectOption(
            options.frameworks,
            headerTheme: SmartSelectOptionHeaderTheme(
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
        SmartSelect.sheet(
          title: 'Super Hero',
          value: _hero,
          isTwoLine: true,
          option: SmartSelectOption(
            options.heroes,
            isMultiChoice: true,
            useFilter: true,
            headerTheme: SmartSelectOptionHeaderTheme(
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