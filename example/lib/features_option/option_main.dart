import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './option_filter.dart';
import './option_divider.dart';
import './option_modal.dart';
import './option_header.dart';
import './option_everything.dart';
import '../features_header.dart';

class FeaturesOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child:ListView(
        children: <Widget>[
          StickyHeader(
            header: FeaturesHeader('Filter Item'),
            content: FeaturesOptionFilter(),
          ),
          StickyHeader(
            header: FeaturesHeader('Use Divider Between Item'),
            content: FeaturesOptionDivider(),
          ),
          StickyHeader(
            header: FeaturesHeader('Customize Modal'),
            content: FeaturesOptionModal(),
          ),
          StickyHeader(
            header: FeaturesHeader('Customize Header'),
            content: FeaturesOptionHeader(),
          ),
          StickyHeader(
            header: FeaturesHeader('Customize Almost Everything'),
            content: FeaturesOptionEverything(),
          ),
        ],
      ),
    );
  }
}

