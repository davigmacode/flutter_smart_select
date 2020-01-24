import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesTileBuilder extends StatefulWidget {
  @override
  _FeaturesTileBuilderState createState() => _FeaturesTileBuilderState();
}

class _FeaturesTileBuilderState extends State<FeaturesTileBuilder> {

  List<String> _cars = ['bmw-x2', 'bmw-x1', 'honda-hrv', 'honda-jazz', 'hyundai-i10', 'bmw-sgt'];
  List<String> _categories = [];
  String _sort = 'popular';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(height: 7),
          Card(
            elevation: 3,
            margin: EdgeInsets.all(5),
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
            value: _cars,
            options: SmartSelectOption.listFrom<String, Map>(
              source: options.cars,
              value: (index, item) => item['value'],
              title: (index, item) => item['title'],
              group: (index, item) => item['body'],
            ),
            onChange: (val) {
              setState(() => _cars = val);
            },
            modalConfig: SmartSelectModalConfig(
              useConfirmation: true,
              useFilter: true,
            ),
            choiceConfig: SmartSelectChoiceConfig(
              isGrouped: true,
            ),
            builder: (context, state, showChoices) {
              return ChipsTile(
                title: 'Cars',
                state: state,
                showChoices: showChoices,
                onChipsDeleted: (value) {
                  setState(() => _cars.remove(value));
                },
              );
            },
          ),
          Container(height: 7),
        ],
      ),
    );
  }
}

class ChipsTile<T> extends StatelessWidget {

  final String title;
  final SmartSelectState<T> state;
  final SmartSelectShowModal showChoices;
  final Function(T value) onChipsDeleted;

  ChipsTile({
    Key key,
    this.title,
    this.state,
    this.showChoices,
    this.onChipsDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text('Cars'),
            trailing: IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () => showChoices(context),
            ),
          ),
          Divider(height: 1),
          _chips,
        ],
      ),
    );
  }

  Widget get _chips {
    return state.valuesObject?.isNotEmpty ?? false
      ? Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Wrap(
            runAlignment: WrapAlignment.start,
            alignment: WrapAlignment.start,
            spacing: 5,
            runSpacing: 0,
            children: List<Widget>.generate(
              state.valuesObject.length,
              (i) => Chip(
                label: Text(state.valuesObject[i].title),
                backgroundColor: Colors.white,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.black12,
                  ),
                ),
                onDeleted: () {
                  onChipsDeleted?.call(state.valuesObject[i].value);
                },
              ),
            ).toList(),
          ),
        )
      : Container(
          padding: EdgeInsets.all(25),
          child: Center(
            child: Text(state.placeholder),
          ),
        );
  }
}