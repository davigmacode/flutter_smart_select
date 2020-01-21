import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './model/choice_config.dart';
import './model/choice_theme.dart';
import './model/option.dart';
import './choices_list.dart';

class SmartSelectChoicesGrouped<T> extends StatelessWidget {

  final List<String> groupKeys;
  final List<SmartSelectOption<T>> items;
  final SmartSelectChoiceType type;
  final SmartSelectChoiceConfig<T> config;

  SmartSelectChoicesGrouped(
    this.groupKeys,
    this.items,
    this.type,
    this.config,
    { Key key }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groupKeys.length,
      itemBuilder: (BuildContext context, int i) {
        String groupKey = groupKeys[i];
        List<SmartSelectOption<T>> groupItems = _groupItems(groupKey);
        return StickyHeader(
          content: SmartSelectChoicesList<T>(groupItems, type, config),
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

  /// return a list of group items
  List<SmartSelectOption<T>> _groupItems(String key) {
    return items.where((SmartSelectOption<T> item) => item.group == key).toList();
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