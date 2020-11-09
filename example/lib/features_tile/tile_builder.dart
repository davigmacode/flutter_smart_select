import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../choices.dart' as choices;

class FeaturesTileBuilder extends StatefulWidget {
  @override
  _FeaturesTileBuilderState createState() => _FeaturesTileBuilderState();
}

class _FeaturesTileBuilderState extends State<FeaturesTileBuilder> {

  List<String> _cars = ['bmw-x2', 'bmw-x1', 'honda-hrv', 'honda-jazz', 'hyundai-i10', 'bmw-sgt'];
  List<String> _categories = [];
  String _sort = 'popular';

  Color get primaryColor => Theme.of(context).primaryColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 7),
          Card(
            elevation: 3,
            margin: const EdgeInsets.all(5),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SmartSelect<String>.multiple(
                    title: 'Categories',
                    value: _categories,
                    choiceItems: choices.categories,
                    onChange: (state) => setState(() => _categories = state.value),
                    modalType: S2ModalType.bottomSheet,
                    modalHeader: false,
                    tileBuilder: (context, state) {
                      return S2Tile.fromState(
                        state,
                        trailing: const Icon(Icons.arrow_drop_down),
                        isTwoLine: true,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                  child: VerticalDivider(),
                ),
                Expanded(
                  child: SmartSelect<String>.single(
                    title: 'Sort By',
                    value: _sort,
                    choiceItems: choices.sorts,
                    onChange: (state) => setState(() => _sort = state.value),
                    modalType: S2ModalType.popupDialog,
                    modalHeader: false,
                    tileBuilder: (context, state) {
                      return S2Tile.fromState(
                        state,
                        trailing: const Icon(Icons.arrow_drop_down),
                        isTwoLine: true,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SmartSelect<String>.multiple(
            title: 'Cars',
            value: _cars,
            choiceItems: S2Choice.listFrom<String, Map>(
              source: choices.cars,
              value: (index, item) => item['value'],
              title: (index, item) => item['title'],
              group: (index, item) => item['body'],
            ),
            onChange: (state) => setState(() => _cars = state.value),
            modalType: S2ModalType.bottomSheet,
            modalConfirm: true,
            modalFilter: true,
            choiceGrouped: true,
            tileBuilder: (context, state) {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.all(5),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: S2Tile.fromState(
                  state,
                  hideValue: true,
                  title: const Text('Cars'),
                  trailing: const Icon(Icons.add_circle_outline),
                  body: S2TileChips(
                    chipLength: state.valueObject.length,
                    chipLabelBuilder: (context, i) {
                      return Text(state.valueObject[i].title);
                    },
                    chipOnDelete: (i) {
                      setState(() => _cars.remove(state.valueObject[i].value));
                    },
                    chipColor: primaryColor,
                    chipBrightness: Brightness.dark,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 7),
        ],
      ),
    );
  }
}