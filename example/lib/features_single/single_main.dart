import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './single_basic.dart';
import './single_sheet.dart';
import './single_popup.dart';
import './single_confirm.dart';
import './single_grouped.dart';
import './single_headerless.dart';
import '../features_header.dart';

class FeaturesSingle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child:ListView(
        children: <Widget>[
          StickyHeader(
            header: FeaturesHeader('Basic Usage'),
            content: FeaturesSingleBasic(),
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
            header: FeaturesHeader('Need to Confirm'),
            content: FeaturesSingleConfirm(),
          ),
          StickyHeader(
            header: FeaturesHeader('Grouped Options'),
            content: FeaturesSingleGrouped(),
          ),
          StickyHeader(
            header: FeaturesHeader('Without Options Header'),
            content: FeaturesSingleHeaderless(),
          ),
        ],
      ),
    );
  }
}

