import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../widgets/icon_badge.dart';
import '../options.dart' as options;

class FeaturesChoicesTheme extends StatefulWidget {
  @override
  _FeaturesChoicesThemeState createState() => _FeaturesChoicesThemeState();
}

class _FeaturesChoicesThemeState extends State<FeaturesChoicesTheme> {

  List<String> _smartphones = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Smartphones',
          value: _smartphones,
          options: S2Option.listFrom<String, Map>(
            source: options.smartphones,
            value: (index, item) => item['id'],
            title: (index, item) => item['name'],
            group: (index, item) => item['brand'],
          ),
          onChange: (state) => setState(() => _smartphones = state.value),
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
              textStyle: TextStyle(color: Colors.white)
            )
          ),
          choiceDividerBuilder: (context, i) => Divider(
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
        const SizedBox(height: 7),
      ],
    );
  }
}