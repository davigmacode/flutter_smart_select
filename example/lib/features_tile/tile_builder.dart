import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../widgets/card_tile.dart';
import '../options.dart' as options;

class FeaturesTileBuilder extends StatefulWidget {
  @override
  _FeaturesTileBuilderState createState() => _FeaturesTileBuilderState();
}

class _FeaturesTileBuilderState extends State<FeaturesTileBuilder> {

  List _car = [];
  List _hero = ['bat', 'spi'];
  List _categories = [];
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
                child: SmartSelect.sheet(
                  title: 'Categories',
                  value: _categories,
                  isTwoLine: true,
                  trailing: Icon(Icons.arrow_drop_down),
                  option: SmartSelectOption(
                    options.categories,
                    isMultiChoice: true,
                    useHeader: false,
                    value: 'slug',
                    label: 'caption',
                  ),
                  onChange: (val) => setState(() => _categories = val),
                ),
              ),
              Container(
                height: 40,
                child: VerticalDivider(),
              ),
              Expanded(
                child: SmartSelect.popup(
                  title: 'Sort By',
                  value: _sort,
                  isTwoLine: true,
                  trailing: Icon(Icons.arrow_drop_down),
                  option: SmartSelectOption(
                    options.sorts,
                    useHeader: false,
                    value: 'id',
                    label: 'name',
                  ),
                  onChange: (val) => setState(() => _sort = val),
                ),
              ),
            ],
          ),
        ),
        SmartSelect(
          title: 'Cars',
          value: _car,
          option: SmartSelectOption(
            options.cars,
            groupBy: 'body',
            isMultiChoice: true,
            useConfirmation: true,
            useFilter: true,
          ),
          onChange: (val) => setState(() => _car = val),
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