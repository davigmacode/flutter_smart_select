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
        Container(height: 7),
        SmartSelect<String>.multiple(
          title: 'Smartphones',
          value: _smartphones,
          isTwoLine: true,
          leading: IconBadge(
            icon: const Icon(Icons.shopping_cart),
            counter: _smartphones.length,
          ),
          options: SmartSelectOption.listFrom<String, Map>(
            source: options.smartphones,
            value: (index, item) => item['id'],
            title: (index, item) => item['name'],
            group: (index, item) => item['brand'],
          ),
          modalType: SmartSelectModalType.fullPage,
          modalConfig: SmartSelectModalConfig(
            useFilter: true,
            style: SmartSelectModalStyle(
              backgroundColor: Colors.blueGrey[800],
            ),
            headerStyle: SmartSelectModalHeaderStyle(
              elevation: 4,
              centerTitle: true,
              backgroundColor: Colors.green,
              textStyle: TextStyle(color: Colors.white),
              iconTheme: IconThemeData(color: Colors.white),
              actionsIconTheme: IconThemeData(color: Colors.white),
            ),
          ),
          choiceType: SmartSelectChoiceType.switches,
          choiceConfig: SmartSelectChoiceConfig(
            isGrouped: true,
            useDivider: true,
            glowingOverscrollIndicatorColor: Colors.green,
            style: SmartSelectChoiceStyle(
              titleStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              inactiveColor: Colors.white,
              activeColor: Colors.green,
            ),
            dividerBuilder: (context, i) => Divider(
              color: Colors.white24,
              indent: 0.0,
              endIndent: 0.0,
            ),
            groupHeaderStyle: SmartSelectChoiceGroupHeaderStyle(
              backgroundColor: Colors.blueGrey[600],
              textStyle: TextStyle(color: Colors.white)
            )
          ),
          onChange: (val) => setState(() => _smartphones = val)
        ),
        Container(height: 7),
      ],
    );
  }
}