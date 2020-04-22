import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesModalHeaderless extends StatefulWidget {
  @override
  _FeaturesModalHeaderlessState createState() => _FeaturesModalHeaderlessState();
}

class _FeaturesModalHeaderlessState extends State<FeaturesModalHeaderless> {

  List<String> _fruit = ['mel'];
  List<String> _hero = ['bat', 'spi'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Fruit',
          value: _fruit,
          options: options.fruits,
          modalType: S2ModalType.popupDialog,
          modalHeader: false,
          onChange: (state) => setState(() => _fruit = state.value),
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
          }
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Super Hero',
          value: _hero,
          options: options.heroes,
          modalType: S2ModalType.bottomSheet,
          modalHeader: false,
          onChange: (state) => setState(() => _hero = state.value),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/8I-ht65iRww/100x100'),
              ),
            );
          }
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}