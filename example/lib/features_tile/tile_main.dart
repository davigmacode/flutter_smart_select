import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './tile_one_line.dart';
import './tile_two_line.dart';
import './tile_loading.dart';
import './tile_leading.dart';
import './tile_trailing.dart';
import './tile_builder.dart';
import '../features_header.dart';

class FeaturesTile extends StatefulWidget {
  @override
  _FeaturesTileState createState() => _FeaturesTileState();
}

class _FeaturesTileState extends State<FeaturesTile> with AutomaticKeepAliveClientMixin<FeaturesTile> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          StickyHeader(
            header: FeaturesHeader('One Line'),
            content: FeaturesTileOneLine(),
          ),
          StickyHeader(
            header: FeaturesHeader('Two Line'),
            content: FeaturesTileTwoLine(),
          ),
          StickyHeader(
            header: FeaturesHeader('Leading Widget'),
            content: FeaturesTileLeading(),
          ),
          StickyHeader(
            header: FeaturesHeader('Custom Trailing Widget'),
            content: FeaturesTileTrailing(),
          ),
          StickyHeader(
            header: FeaturesHeader('Loading Stats'),
            content: FeaturesTileLoading(),
          ),
          StickyHeader(
            header: FeaturesHeader('Custom Tile Builder'),
            content: FeaturesTileBuilder(),
          ),
        ],
      ),
    );
  }
}

