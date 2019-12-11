import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../widgets/icon_badge.dart';
import '../options.dart' as options;

class FeaturesOptionEverything extends StatefulWidget {
  @override
  _FeaturesOptionEverythingState createState() => _FeaturesOptionEverythingState();
}

class _FeaturesOptionEverythingState extends State<FeaturesOptionEverything> {

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
          leading: IconBadge(
            icon: const Icon(Icons.shopping_cart),
            counter: _smartphones.length,
          ),
          option: SmartSelectOption(
            options.smartphones,
            value: 'id',
            label: 'name',
            groupBy: 'brand',
            isMultiChoice: true,
            useFilter: true,
            useDivider: true,
            backgroundColor: Colors.blueGrey[800],
            glowingOverscrollIndicatorColor: Colors.green,
            headerTheme: SmartSelectOptionHeaderTheme(
              elevation: 4,
              centerTitle: true,
              backgroundColor: Colors.green,
              textStyle: TextStyle(color: Colors.white),
              iconTheme: IconThemeData(color: Colors.white),
              actionsIconTheme: IconThemeData(color: Colors.white),
            ),
            itemTheme: SmartSelectOptionItemTheme(
              titleStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              unselectedColor: Colors.white,
              activeColor: Colors.green,
            ),
            dividerBuilder: (context, i) => Divider(
              color: Colors.white24,
              indent: 0.0,
              endIndent: 0.0,
            ),
            groupHeaderTheme: SmartSelectOptionGroupHeaderTheme(
              backgroundColor: Colors.blueGrey[600],
              titleStyle: TextStyle(color: Colors.white)
            )
          ),
          onChange: (val) => setState(() => _smartphones = val)
        ),
        Container(height: 7),
      ],
    );
  }
}