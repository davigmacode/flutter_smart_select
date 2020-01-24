import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class FeaturesOptionListOfString extends StatefulWidget {
  @override
  _FeaturesOptionListOfStringState createState() => _FeaturesOptionListOfStringState();
}

class _FeaturesOptionListOfStringState extends State<FeaturesOptionListOfString> {

  List<int> _categories = [];

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
                child: SmartSelect<int>.multiple(
                  title: 'Categories',
                  value: _categories,
                  isTwoLine: true,
                  trailing: Icon(Icons.arrow_drop_down),
                  options: SmartSelectOption.listFrom<int, String>(
                    source: _categoriesOption,
                    value: (index, item) => index,
                    title: (index, item) => item,
                  ),
                  choiceType: SmartSelectChoiceType.switches,
                  modalType: SmartSelectModalType.popupDialog,
                  modalConfig: SmartSelectModalConfig(
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
                child: SmartSelect<int>.single(
                  title: 'Sort By',
                  value: _sort,
                  isTwoLine: true,
                  trailing: Icon(Icons.arrow_drop_down),
                  options: SmartSelectOption.listFrom<int, String>(
                    source: _sortOption,
                    value: (index, item) => index,
                    title: (index, item) => item,
                  ),
                  modalType: SmartSelectModalType.popupDialog,
                  modalConfig: SmartSelectModalConfig(
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