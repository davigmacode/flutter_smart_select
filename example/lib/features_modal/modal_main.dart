import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './modal_filter.dart';
import './modal_confirm.dart';
import './modal_validation.dart';
import './modal_selector.dart';
import './modal_shape.dart';
import './modal_header.dart';
import './modal_choices.dart';
import './modal_widget.dart';
import '../features_header.dart';
import '../keep_alive.dart';

class FeaturesModal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        addAutomaticKeepAlives: true,
        children: <Widget>[
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Use Filter'),
              content: FeaturesModalFilter(),
            ),
          ),
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Need to Confirm'),
              content: FeaturesModalConfirm(),
            ),
          ),
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Validation'),
              content: FeaturesModalValidation(),
            ),
          ),
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Choice Selector'),
              content: FeaturesModalSelector(),
            ),
          ),
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Modal Shape'),
              content: FeaturesModalShape(),
            ),
          ),
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Modal Header'),
              content: FeaturesModalHeader(),
            ),
          ),
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Custom Modal Header & Footer Widget'),
              content: FeaturesModalWidget(),
            ),
          ),
          KeepAliveWidget(
            child: StickyHeader(
              header: const FeaturesHeader('Only Choices, Without Header & Footer'),
              content: FeaturesModalChoices(),
            ),
          ),
        ],
      ),
    );
  }
}

