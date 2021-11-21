import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import '../widgets/icon_badge.dart';
import '../choices.dart' as choices;

class FeaturesChoicesTheme extends StatefulWidget {
  @override
  _FeaturesChoicesThemeState createState() => _FeaturesChoicesThemeState();
}

class _FeaturesChoicesThemeState extends State<FeaturesChoicesTheme> {
  List<String>? _smartphones = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Smartphones',
          selectedValue: _smartphones,
          onChange: (selected) {
            setState(() => _smartphones = selected?.value);
          },
          choiceItems: S2Choice.listFrom<String, Map<String, String>>(
            source: choices.smartphones,
            value: (index, item) => item['id'] ?? '',
            title: (index, item) => item['name'] ?? '',
            group: (index, item) => item['brand'] ?? '',
          ),
          choiceConfig: S2ChoiceConfig(
            type: S2ChoiceType.switches,
            useDivider: true,
            overscrollColor: Colors.green,
            style: const S2ChoiceStyle(
              titleStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              color: Colors.white,
            ),
            activeStyle: const S2ChoiceStyle(
              color: Colors.green,
            ),
          ),
          groupEnabled: true,
          groupHeaderStyle: S2GroupHeaderStyle(
            backgroundColor: Colors.blueGrey[600],
            textStyle: const TextStyle(color: Colors.white),
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
          choiceDividerBuilder: (context, i) {
            return const Divider(
              color: Colors.white24,
              indent: 0.0,
              endIndent: 0.0,
            );
          },
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: IconBadge(
                icon: const Icon(Icons.shopping_cart),
                color: Theme.of(context).primaryColor,
                counter: state.selected?.length ?? 0,
              ),
            );
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}
