import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './multi_page.dart';
import './multi_sheet.dart';
import './multi_popup.dart';
import './multi_chips.dart';
import './multi_switches.dart';
import '../features_header.dart';

class FeaturesMulti extends StatefulWidget {
  @override
  _FeaturesMultiState createState() => _FeaturesMultiState();
}

class _FeaturesMultiState extends State<FeaturesMulti> with AutomaticKeepAliveClientMixin<FeaturesMulti> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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

