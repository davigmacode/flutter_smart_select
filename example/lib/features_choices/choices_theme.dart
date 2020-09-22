import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../widgets/icon_badge.dart';
import '../choices.dart' as choices;

class FeaturesChoicesTheme extends StatefulWidget {
  @override
  _FeaturesChoicesThemeState createState() => _FeaturesChoicesThemeState();
}

class _FeaturesChoicesThemeState extends State<FeaturesChoicesTheme> {

  List<String> _smartphones = [];

  Color _background = Colors.blue;
  List<List> _backgrounds = [
    ['Blue', Colors.blue],
    ['Green', Colors.green],
    ['Orange', Colors.deepOrange],
    ['Red', Colors.redAccent],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Smartphones',
          value: _smartphones,
          onChange: (state) => setState(() => _smartphones = state.value),
          choiceItems: S2Choice.listFrom<String, Map>(
            source: choices.smartphones,
            value: (index, item) => item['id'],
            title: (index, item) => item['name'],
            group: (index, item) => item['brand'],
          ),
          choiceConfig: S2ChoiceConfig(
            type: S2ChoiceType.switches,
            isGrouped: true,
            useDivider: true,
            overscrollColor: Colors.green,
            style: const S2ChoiceStyle(
              titleStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              color: Colors.white,
              activeColor: Colors.green,
            ),
            headerStyle: S2ChoiceHeaderStyle(
              backgroundColor: Colors.blueGrey[600],
              textStyle: const TextStyle(color: Colors.white)
            )
          ),
          modalConfig: S2ModalConfig(
            type: S2ModalType.fullPage,
            useFilter: true,
            style: S2ModalStyle(
              backgroundColor: Colors.blueGrey[800],
            ),
            headerStyle: const S2ModalHeaderStyle(
              elevation: 4,
              centerTitle: true,
              backgroundColor: Colors.green,
              textStyle: TextStyle(color: Colors.white),
              iconTheme: IconThemeData(color: Colors.white),
              actionsIconTheme: IconThemeData(color: Colors.white),
            ),
          ),
          choiceDividerBuilder: (context, i) => const Divider(
            color: Colors.white24,
            indent: 0.0,
            endIndent: 0.0,
          ),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: IconBadge(
                icon: const Icon(Icons.shopping_cart),
                counter: _smartphones.length,
              ),
            );
          }
        ),
        const Divider(indent: 20),
        SmartSelect<Color>.single(
          title: 'Color',
          value: _background,
          choiceItems: S2Choice.listFrom<Color, List>(
            source: _backgrounds,
            value: (i, v) => v[1],
            title: (i, v) => v[0]
          ),
          choiceStyle: S2ChoiceStyle(
            titleStyle: const TextStyle(
              color: Colors.white
            ),
            color: Colors.white.withOpacity(.5),
            activeColor: Colors.white,
          ),
          modalConfirmBuilder: (context, state) {
            return FlatButton(
              onPressed: () => state.closeModal(confirmed: true),
              child: const Text(
                'Change',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            );
          },
          modalStyle: S2ModalStyle(
            backgroundColor: _background,
          ),
          modalHeaderStyle: S2ModalHeaderStyle(
            elevation: 0,
            backgroundColor: _background,
            textStyle: TextStyle(
              color: Colors.white
            )
          ),
          modalType: S2ModalType.popupDialog,
          onChange: (state) => setState(() => _background = state.value),
          tileBuilder: (context, state) {
            return S2Tile<Color>.fromState(
              state,
              isTwoLine: true,
              leading: CircleAvatar(
                backgroundColor: state.value,
              ),
            );
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}