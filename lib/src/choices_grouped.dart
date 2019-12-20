import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './model/choice_config.dart';
import './model/choice_theme.dart';
import './model/option_item.dart';
import './choices_list.dart';

class SmartSelectChoicesGrouped extends StatelessWidget {

  final bool useConfirmation;
  final bool isMultiChoice;
  final List<SmartSelectOptionItem> items;
  final SmartSelectChoiceConfig config;

  SmartSelectChoicesGrouped(
    this.useConfirmation,
    this.isMultiChoice,
    this.items,
    this.config,
    { Key key }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _groupKeys.length,
      itemBuilder: (BuildContext context, int i) {
        String groupKey = _groupKeys[i];
        List<SmartSelectOptionItem> groupItems = _groupItems(groupKey);
        return StickyHeader(
          content: SmartSelectChoicesList(useConfirmation, isMultiChoice, groupItems, config),
          header: config.groupHeaderBuilder?.call(groupKey, groupItems.length)
            ?? SmartSelectChoicesGroupedHeader(
                title: groupKey,
                counter: groupItems.length,
                theme: config.groupHeaderStyle,
              ),
        );
      },
    );
  }

  /// return a list of group keys
  List<String> get _groupKeys {
    Set groups = Set();
    items.forEach((SmartSelectOptionItem item) => groups.add(item.groupBy));
    return groups.toList().cast<String>();
  }

  /// return a list of group items
  List<SmartSelectOptionItem> _groupItems(String key) {
    return items.where((SmartSelectOptionItem item) => item.groupBy == key).toList();
  }
}

class SmartSelectChoicesGroupedHeader extends StatelessWidget {

  final String title;
  final int counter;
  final SmartSelectChoiceGroupHeaderStyle theme;

  SmartSelectChoicesGroupedHeader({
    Key key,
    this.title,
    this.counter,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: theme.height,
      color: theme.backgroundColor,
      padding: theme.padding,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .body2
                .merge(theme.textStyle),
          ),
          Text(
            counter.toString(),
            style: Theme.of(context)
                .textTheme
                .body2
                .merge(theme.textStyle),
          ),
        ],
      ),
    );
  }
}