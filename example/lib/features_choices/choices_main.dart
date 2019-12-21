import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './choices_grouped.dart';
import './choices_divider.dart';
import './choices_theme.dart';
import '../features_header.dart';

class FeaturesChoices extends StatefulWidget {
  @override
  _FeaturesChoicesState createState() => _FeaturesChoicesState();
}

class _FeaturesChoicesState extends State<FeaturesChoices> with AutomaticKeepAliveClientMixin<FeaturesChoices> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scrollbar(
      child:ListView(
        children: <Widget>[
          StickyHeader(
            header: FeaturesHeader('Grouped Items'),
            content: FeaturesChoicesGrouped(),
          ),
          StickyHeader(
            header: FeaturesHeader('Use Divider Between Item'),
            content: FeaturesChoicesDivider(),
          ),
          StickyHeader(
            header: FeaturesHeader('Customize Theme'),
            content: FeaturesChoicesTheme(),
          ),
        ],
      ),
    );
  }
}

