import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './choices_grouped.dart';
import './choices_divider.dart';
import './choices_builder.dart';
import './choices_theme.dart';
import '../features_header.dart';
import '../keep_alive.dart';

class FeaturesChoices extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        addAutomaticKeepAlives: true,
        children: <Widget>[
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Grouped Items'),
              content: FeaturesChoicesGrouped(),
            ),
          ),
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Divider Between Item'),
              content: FeaturesChoicesDivider(),
            ),
          ),
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Custom Choice Widget and Layout'),
              content: FeaturesChoicesBuilder(),
            ),
          ),
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Customize Theme'),
              content: FeaturesChoicesTheme(),
            ),
          ),
        ],
      ),
    );
  }

}

