import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './single_page.dart';
import './single_sheet.dart';
import './single_popup.dart';
import './single_chips.dart';
import '../features_header.dart';

class FeaturesSingle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child:ListView(
        children: <Widget>[
          StickyHeader(
            header: FeaturesHeader('Open in Full Page'),
            content: FeaturesSinglePage(),
          ),
          StickyHeader(
            header: FeaturesHeader('Open in Bottom Sheet'),
            content: FeaturesSingleSheet(),
          ),
          StickyHeader(
            header: FeaturesHeader('Open in Popup Dialog'),
            content: FeaturesSinglePopup(),
          ),
          StickyHeader(
            header: FeaturesHeader('Use Chips'),
            content: FeaturesSingleChips(),
          ),
        ],
      ),
    );
  }
}

