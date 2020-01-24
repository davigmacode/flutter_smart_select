import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './option_disabled.dart';
import './option_hidden.dart';
import './option_list_of_string.dart';
import './option_list_of_map.dart';
import './option_list_of_list.dart';
import './option_async.dart';
import '../features_header.dart';

class FeaturesOption extends StatefulWidget {
  @override
  _FeaturesOptionState createState() => _FeaturesOptionState();
}

class _FeaturesOptionState extends State<FeaturesOption> with AutomaticKeepAliveClientMixin<FeaturesOption> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          StickyHeader(
            header: FeaturesHeader('Disabled Options'),
            content: FeaturesOptionDisabled(),
          ),
          StickyHeader(
            header: FeaturesHeader('Hidden Options'),
            content: FeaturesOptionHidden(),
          ),
          StickyHeader(
            header: FeaturesHeader('Build Options from List of String'),
            content: FeaturesOptionListOfString(),
          ),
          StickyHeader(
            header: FeaturesHeader('Build Options from List of Map'),
            content: FeaturesOptionListOfMap(),
          ),
          StickyHeader(
            header: FeaturesHeader('Build Options from List of List'),
            content: FeaturesOptionListOfList(),
          ),
          StickyHeader(
            header: FeaturesHeader('Async Options'),
            content: FeaturesOptionAsync(),
          ),
        ],
      ),
    );
  }
}

