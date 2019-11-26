import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class OptionsList extends StatefulWidget {
  @override
  _OptionsListState createState() => _OptionsListState();
}

class _OptionsListState extends State<OptionsList> {

  String _day = 'fri';
  String _month = 'apr';
  String _os = 'win';
  String _fruit = 'mel';
  List _hero = ['iro', 'hul'];
  List _car = ['maz'];
  List _framework = ['flu'];

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: <Widget>[
          Divider(),
          SmartSelect(
            title: 'Days',
            value: _day,
            options: [
              { 'value': 'mon', 'label': 'Monday' },
              { 'value': 'tue', 'label': 'Tuesday' },
              { 'value': 'wed', 'label': 'Wednesday' },
              { 'value': 'thu', 'label': 'Thursday' },
              { 'value': 'fri', 'label': 'Friday' },
              { 'value': 'sat', 'label': 'Saturday' },
              { 'value': 'sun', 'label': 'Sunday' },
            ],
            onChange: (val) => setState(() => _day = val)
          ),
          Divider(indent: 15),
          SmartSelect(
            title: 'Month',
            value: _month,
            options: [
              { 'value': 'jan', 'label': 'January' },
              { 'value': 'feb', 'label': 'February' },
              { 'value': 'mar', 'label': 'March' },
              { 'value': 'apr', 'label': 'April' },
              { 'value': 'may', 'label': 'May' },
              { 'value': 'jun', 'label': 'June' },
              { 'value': 'jul', 'label': 'July' },
              { 'value': 'aug', 'label': 'August' },
              { 'value': 'sep', 'label': 'September' },
              { 'value': 'oct', 'label': 'October' },
              { 'value': 'nov', 'label': 'November' },
              { 'value': 'dec', 'label': 'December' },
            ],
            closeOnSelect: false,
            onChange: (val) => setState(() => _month = val)
          ),
          Divider(indent: 15),
          SmartSelect.sheet(
            title: 'OS',
            value: _os,
            options: [
              { 'value': 'and', 'label': 'Android' },
              { 'value': 'ios', 'label': 'IOS' },
              { 'value': 'mac', 'label': 'Macintos' },
              { 'value': 'tux', 'label': 'Linux' },
              { 'value': 'win', 'label': 'Windows' },
            ],
            onChange: (val) => setState(() => _os = val)
          ),
          Divider(indent: 15),
          SmartSelect.popup(
            title: 'Fruit',
            value: _fruit,
            options: [
              { 'value': 'app', 'label': 'Apple' },
              { 'value': 'ore', 'label': 'Orange' },
              { 'value': 'mel', 'label': 'Melon' },
            ],
            onChange: (val) => setState(() => _fruit = val),
          ),
          Divider(indent: 15),
          SmartMultiSelect(
            title: 'Cars',
            value: _car,
            options: [
              { 'value': 'hon', 'label': 'Honda' },
              { 'value': 'lex', 'label': 'Lexus' },
              { 'value': 'maz', 'label': 'Mazda' },
              { 'value': 'nis', 'label': 'Nissan' },
              { 'value': 'toy', 'label': 'Toyota' },
              { 'value': 'aud', 'label': 'Audi' },
              { 'value': 'bmw', 'label': 'BMW' },
              { 'value': 'mer', 'label': 'Mercedes' },
              { 'value': 'vwg', 'label': 'Volkswagen' },
              { 'value': 'vol', 'label': 'Volvo' },
              { 'value': 'cad', 'label': 'Cadillac' },
              { 'value': 'chr', 'label': 'Chrysler' },
              { 'value': 'dod', 'label': 'Dodge' },
              { 'value': 'for', 'label': 'Ford' },
              { 'value': 'fer', 'label': 'Ferrari' },
            ],
            onChange: (val) => setState(() => _car = val),
          ),
          Divider(indent: 15),
          SmartMultiSelect.sheet(
            title: 'Super Hero',
            value: _hero,
            options: [
              { 'value': 'bat', 'label': 'Batman' },
              { 'value': 'sup', 'label': 'Superman' },
              { 'value': 'hul', 'label': 'Hulk' },
              { 'value': 'spi', 'label': 'Spiderman' },
              { 'value': 'iro', 'label': 'Ironman' },
              { 'value': 'won', 'label': 'Wonder Woman' },
            ],
            onChange: (val) => setState(() => _hero = val),
          ),
          Divider(indent: 15),
          SmartMultiSelect.popup(
            title: 'Frameworks',
            value: _framework,
            options: [
              { 'value': 'ion', 'label': 'Ionic' },
              { 'value': 'flu', 'label': 'Flutter' },
              { 'value': 'rea', 'label': 'React Native' },
            ],
            onChange: (val) => setState(() => _framework = val),
          ),
          Divider(),
        ],
      ),
    );
  }
}