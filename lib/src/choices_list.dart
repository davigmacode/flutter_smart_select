import 'package:flutter/material.dart';
import './model/option_item.dart';
import './model/choice_config.dart';
import './choices_item.dart';

class SmartSelectChoicesList extends StatelessWidget {

  final bool useConfirmation;
  final bool isMultiChoice;
  final List<SmartSelectOptionItem> items;
  final SmartSelectChoiceConfig config;

  SmartSelectChoicesList(
    this.useConfirmation,
    this.isMultiChoice,
    this.items,
    this.config,
    { Key key }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return config.useWrap || config.type == SmartSelectChoiceType.chips
      ? _listWrap()
      : config.useDivider
        ? _listSeparated()
        : _listDefault();
  }

  Widget _listWrap() {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child: Wrap(
          spacing: 12.0, // gap between adjacent chips
          runSpacing: 0.0, // gap between lines
          children: List<Widget>.generate(
            items.length,
            (i) => ChoicesItem(useConfirmation, isMultiChoice, items[i], config),
          ).toList(),
        ),
      ),
    );
  }

  Widget _listDefault() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      itemCount: items.length,
      itemBuilder: (context, i) => ChoicesItem(useConfirmation, isMultiChoice, items[i], config),
    );
  }

  Widget _listSeparated() {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      itemCount: items.length,
      itemBuilder: (context, i) => ChoicesItem(useConfirmation, isMultiChoice, items[i], config),
      separatorBuilder: config.dividerBuilder ?? _dividerBuilderDefault,
    );
  }

  Widget _dividerBuilderDefault(BuildContext context, int index) {
    return Divider();
  }
}
