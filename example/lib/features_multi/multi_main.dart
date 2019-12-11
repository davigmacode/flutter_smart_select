import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './multi_basic.dart';
import './multi_sheet.dart';
import './multi_popup.dart';
import './multi_confirm.dart';
import './multi_grouped.dart';
import './multi_headerless.dart';
import '../features_header.dart';

class FeaturesMulti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child:ListView(
        children: <Widget>[
          StickyHeader(
            header: FeaturesHeader('Basic Usage'),
            content: FeaturesMultiBasic(),
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
            header: FeaturesHeader('Need to Confirm'),
            content: FeaturesMultiConfirm(),
          ),
          StickyHeader(
            header: FeaturesHeader('Grouped Options'),
            content: FeaturesMultiGrouped(),
          ),
          StickyHeader(
            header: FeaturesHeader('Without Options Header'),
            content: FeaturesMultiHeaderless(),
          ),
        ],
      ),
    );
  }
}

