import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import '../choices.dart' as choices;

class FeaturesModalChoices extends StatefulWidget {
  @override
  _FeaturesModalChoicesState createState() => _FeaturesModalChoicesState();
}

class _FeaturesModalChoicesState extends State<FeaturesModalChoices> {
  List<String>? _fruit = ['mel'];
  List<String>? _hero = ['bat', 'spi'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Fruit',
          selectedValue: _fruit,
          onChange: (selected) => setState(() => _fruit = selected?.value),
          choiceItems: choices.fruits,
          modalType: S2ModalType.popupDialog,
          modalHeader: false,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: Container(
                width: 40,
                alignment: Alignment.center,
                child: const Icon(Icons.shopping_cart),
              ),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Super Hero',
          selectedValue: _hero,
          onChange: (selected) => setState(() => _hero = selected?.value),
          choiceItems: choices.heroes,
          modalType: S2ModalType.bottomSheet,
          modalHeader: false,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://source.unsplash.com/8I-ht65iRww/100x100',
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}
