import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../widgets/icon_badge.dart';
import '../options.dart' as options;

class FeaturesChoicesTheme extends StatefulWidget {
  @override
  _FeaturesChoicesThemeState createState() => _FeaturesChoicesThemeState();
}

class _FeaturesChoicesThemeState extends State<FeaturesChoicesTheme> {

  List _smartphones = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Smartphones',
          value: _smartphones,
          isTwoLine: true,
          isMultiChoice: true,
          leading: IconBadge(
            icon: const Icon(Icons.shopping_cart),
            counter: _smartphones.length,
          ),
          option: SmartSelectOptionConfig(
            options.smartphones,
            value: 'id',
            title: 'name',
            groupBy: 'brand',
          ),
          modal: SmartSelectModalConfig(
            useFilter: true,
            type: SmartSelectModalType.fullPage,
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
          choice: SmartSelectChoiceConfig(
            useDivider: true,
            type: SmartSelectChoiceType.switches,
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