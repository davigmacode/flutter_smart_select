import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class FeaturesOptionListOfString extends StatefulWidget {
  @override
  _FeaturesOptionListOfStringState createState() => _FeaturesOptionListOfStringState();
}

class _FeaturesOptionListOfStringState extends State<FeaturesOptionListOfString> {

  List _categories = [];

  int _sort = 3;

  List<String> _categoriesOption = [
    'Electronics', 'Accessories', 'Smartwatch',
    'Smartphone', 'Audio & Video', 'Scientific'
  ];

  List<String> _sortOption = [
    'Popular', 'Most Reviews', 'Newest',
    'Low Price', 'High Price',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        Card(
          elevation: 3,
          margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SmartSelect(
                  title: 'Categories',
                  value: _categories,
                  isTwoLine: true,
                  isMultiChoice: true,
                  trailing: Icon(Icons.arrow_drop_down),
                  option: SmartSelectOptionConfig(_categoriesOption),
                  choice: SmartSelectChoiceConfig(type: SmartSelectChoiceType.switches),
                  modal: SmartSelectModalConfig(
                    type: SmartSelectModalType.popupDialog,
                    useHeader: false,
                  ),
                  onChange: (val) => setState(() => _categories = val),
                ),
              ),
              Container(
                height: 40,
                child: VerticalDivider(),
              ),
              Expanded(
                child: SmartSelect(
                  title: 'Sort By',
                  value: _sort,
                  isTwoLine: true,
                  trailing: Icon(Icons.arrow_drop_down),
                  option: SmartSelectOptionConfig(_sortOption),
                  modal: SmartSelectModalConfig(
                    type: SmartSelectModalType.popupDialog,
                    useHeader: false,
                  ),
                  onChange: (val) => setState(() => _sort = val),
                ),
              ),
            ],
          ),
        ),
        Container(height: 7),
      ],
    );
  }
}