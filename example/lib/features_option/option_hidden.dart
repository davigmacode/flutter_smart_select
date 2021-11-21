import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';

class FeaturesOptionHidden extends StatefulWidget {
  @override
  _FeaturesOptionHiddenState createState() => _FeaturesOptionHiddenState();
}

class _FeaturesOptionHiddenState extends State<FeaturesOptionHidden> {
  List<int>? _categories = [];

  int? _sort = 0;

  List<String> _categoriesOption = [
    'Electronics',
    'Accessories',
    'Smartwatch',
    'Smartphone',
    'Audio & Video',
    'Scientific'
  ];

  List<String> _sortOption = [
    'Popular',
    'Most Reviews',
    'Newest',
    'Low Price',
    'High Price',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        Card(
          elevation: 3,
          margin: const EdgeInsets.all(10),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SmartSelect<int>.multiple(
                  title: 'Categories',
                  selectedValue: _categories,
                  onChange: (selected) {
                    setState(() => _categories = selected?.value);
                  },
                  choiceItems: S2Choice.listFrom<int, String>(
                    source: _categoriesOption,
                    value: (index, item) => index,
                    title: (index, item) => item,
                    hidden: (index, item) => [0, 2, 5].contains(index),
                  ),
                  choiceType: S2ChoiceType.switches,
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
              const SizedBox(
                height: 40,
                child: VerticalDivider(),
              ),
              Expanded(
                child: SmartSelect<int?>.single(
                  title: 'Sort By',
                  selectedValue: _sort,
                  onChange: (selected) {
                    setState(() => _sort = selected.value);
                  },
                  choiceItems: S2Choice.listFrom<int, String>(
                    source: _sortOption,
                    value: (index, item) => index,
                    title: (index, item) => item,
                    hidden: (index, item) =>
                        item.toLowerCase().contains('price'),
                  ),
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
        const SizedBox(height: 7),
      ],
    );
  }
}
