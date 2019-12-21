import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './modal_filter.dart';
import './modal_confirm.dart';
import './modal_shape.dart';
import './modal_header.dart';
import './modal_headerless.dart';
import '../features_header.dart';

class FeaturesModal extends StatefulWidget {
  @override
  _FeaturesModalState createState() => _FeaturesModalState();
}

class _FeaturesModalState extends State<FeaturesModal> with AutomaticKeepAliveClientMixin<FeaturesModal> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scrollbar(
      child:ListView(
        children: <Widget>[
          StickyHeader(
            header: FeaturesHeader('Use Filter'),
            content: FeaturesModalFilter(),
          ),
          StickyHeader(
            header: FeaturesHeader('Need to Confirm'),
            content: FeaturesModalConfirm(),
          ),
          StickyHeader(
            header: FeaturesHeader('Modal Shape'),
            content: FeaturesModalShape(),
          ),
          StickyHeader(
            header: FeaturesHeader('Modal Header'),
            content: FeaturesModalHeader(),
          ),
          StickyHeader(
            header: FeaturesHeader('Without Header'),
            content: FeaturesModalHeaderless(),
          ),
        ],
      ),
    );
  }
}

