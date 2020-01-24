import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class FeaturesOptionDisabled extends StatefulWidget {
  @override
  _FeaturesOptionDisabledState createState() => _FeaturesOptionDisabledState();
}

class _FeaturesOptionDisabledState extends State<FeaturesOptionDisabled> {

  List<int> _categories = [];

  int _sort = 0;

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
                    disabled: (index, item) => [0, 2, 5].contains(index),
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
                    disabled: (index, item) => item.toLowerCase().contains('price'),
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