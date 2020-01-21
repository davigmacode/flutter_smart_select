import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../widgets/card_tile.dart';
import '../options.dart' as options;

class FeaturesTileBuilder extends StatefulWidget {
  @override
  _FeaturesTileBuilderState createState() => _FeaturesTileBuilderState();
}

class _FeaturesTileBuilderState extends State<FeaturesTileBuilder> {

  List<String> _car = [];
  List<String> _categories = [];
  String _sort = 'popular';

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
                child: SmartSelect<String>.multiple(
                  title: 'Categories',
                  value: _categories,
                  options: options.categories,
                  onChange: (val) => setState(() => _categories = val),
                  isTwoLine: true,
                  trailing: Icon(Icons.arrow_drop_down),
                  modalType: SmartSelectModalType.bottomSheet,
                  modalConfig: SmartSelectModalConfig(
                    useHeader: false,
                  ),
                ),
              ),
              Container(
                height: 40,
                child: VerticalDivider(),
              ),
              Expanded(
                child: SmartSelect<String>.single(
                  title: 'Sort By',
                  value: _sort,
                  options: options.sorts,
                  onChange: (val) => setState(() => _sort = val),
                  isTwoLine: true,
                  trailing: Icon(Icons.arrow_drop_down),
                  modalType: SmartSelectModalType.popupDialog,
                  modalConfig: SmartSelectModalConfig(
                    useHeader: false,
                  ),
                ),
              ),
            ],
          ),
        ),
        SmartSelect<String>.multiple(
          title: 'Cars',
          value: _car,
          options: SmartSelectOption.listFrom<Map, String>(
            source: options.cars,
            value: (index, item) => item['value'],
            title: (index, item) => item['title'],
            group: (index, item) => item['body'],
          ),
          onChange: (val) => setState(() => _car = val),
          modalConfig: SmartSelectModalConfig(
            useConfirmation: true,
            useFilter: true,
          ),
          choiceConfig: SmartSelectChoiceConfig(
            isGrouped: true,
          ),
          builder: (context, state, showOptions) {
            return CardTile(
              title: state.title,
              value: state.valueDisplay,
              thumb: Image.network('https://source.unsplash.com/yeVtxxPxzbw/100x100'),
              onTap: () => showOptions(context),
            );
          },
        ),
        Container(height: 7),
      ],
    );
  }
}