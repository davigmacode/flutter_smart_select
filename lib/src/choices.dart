import 'package:flutter/material.dart';
import './model/builder.dart';
import './model/choice_item.dart';
import './model/choice_config.dart';
import './choices_grouped.dart';
import './choices_list.dart';
import './choices_empty.dart';

/// modal choice widget
class S2Choices<T> extends StatelessWidget {

  /// builder of single choice widget
  final Widget Function(S2Choice<T>) itemBuilder;

  /// list of choice data
  final List<S2Choice<T>> items;

  /// configuration of choice widget
  final S2ChoiceConfig config;

  /// collection of available builder widget
  final S2Builder<T> builder;

  /// current filter query
  final String query;

  /// default constructor
  S2Choices({
    Key key,
    @required this.itemBuilder,
    @required this.items,
    @required this.config,
    @required this.builder,
    @required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _filteredItems.length > 0
      ? choices
      : builder.choiceEmpty?.call(context, query)
        ?? const S2ChoicesEmpty();
  }

  Widget get choices {
    return ListTileTheme(
      contentPadding: config.style?.padding,
      child: _isGrouped == true
        ? S2ChoicesGrouped<T>(
            items: _filteredItems,
            itemBuilder: itemBuilder,
            groupKeys: _groupKeys,
            config: config,
            builder: builder,
            query: query,
          )
        : S2ChoicesList<T>(
            items: _filteredItems,
            itemBuilder: itemBuilder,
            config: config,
            builder: builder,
          ),
    );
  }

  /// return a filtered list of options
  List<S2Choice<T>> get _filteredItems {
    return query != null
      ? _nonHiddenItems
        .where((S2Choice<T> item) => item.contains(query))
        .toList().cast<S2Choice<T>>()
      : _nonHiddenItems;
  }

  /// return a non hidden option item
  List<S2Choice<T>> get _nonHiddenItems {
    return items
      .where((S2Choice<T> item) => item.hidden != true)
      .toList().cast<S2Choice<T>>();
  }

  /// return a sorted list of group keys
  List<String> get _groupKeys {
    Set groups = Set();
    _filteredItems.forEach((S2Choice<T> item) => groups.add(item.group));

    return groups
      .toList()
      .cast<String>()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  }

  /// whether the list need to be grouped or not
  bool get _isGrouped {
    return config.isGrouped && _groupKeys != null && _groupKeys.isNotEmpty;
  }
}