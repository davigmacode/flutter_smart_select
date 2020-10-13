import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './single_page.dart';
import './single_sheet.dart';
import './single_popup.dart';
import './single_chips.dart';
import './single_switches.dart';
import '../features_header.dart';
import '../keep_alive.dart';

class FeaturesSingle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        addAutomaticKeepAlives: true,
        children: <Widget>[
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Open in Full Page'),
              content: FeaturesSinglePage(),
            ),
          ),
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Open in Bottom Sheet'),
              content: FeaturesSingleSheet(),
            ),
          ),
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Open in Popup Dialog'),
              content: FeaturesSinglePopup(),
            ),
          ),
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Use Chips'),
              content: FeaturesSingleChips(),
            ),
          ),
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Use Switches'),
              content: FeaturesSingleSwitches(),
            ),
          ),
        ],
      ),
    );
  }
}

