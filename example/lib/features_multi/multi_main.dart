import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './multi_page.dart';
import './multi_sheet.dart';
import './multi_popup.dart';
import './multi_chips.dart';
import './multi_switches.dart';
import '../features_header.dart';

class FeaturesMulti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child:ListView(
        children: <Widget>[
          StickyHeader(
            header: FeaturesHeader('Open in Full Page'),
            content: FeaturesMultiPage(),
          ),
          StickyHeader(
            header: FeaturesHeader('Open in Bottom Sheet'),
            content: FeaturesMultiSheet(),
          ),
          StickyHeader(
            header: FeaturesHeader('Open in Popup Dialog'),
            content: FeaturesMultiPopup(),
          ),
          StickyHeader(
            header: FeaturesHeader('Use Chips'),
            content: FeaturesMultiChips(),
          ),
          StickyHeader(
            header: FeaturesHeader('Use Switches'),
            content: FeaturesMultiSwitches(),
          ),
        ],
      ),
    );
  }
}

