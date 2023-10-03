import 'package:flutter/material.dart';
import '../model/choice_item.dart';
import '../model/group_data.dart';
import '../model/group_config.dart';

/// modal choice widget
class S2Choices<T> {
  /// list of choice data
  final List<S2Choice<T>> items;

  /// current filter query
  final String query;

  /// configuration of group widget
  final S2GroupConfig groupConfig;

  /// default constructor
  S2Choices({
    required this.items,
    required this.query,
    required this.groupConfig,
  });

  /// return a filtered list of options
  List<S2Choice<T>> get filteredItems {
    return query != null
        ? nonHiddenItems
            .where((S2Choice<T> item) => item.contains(query))
            .toList()
            .cast<S2Choice<T>>()
        : nonHiddenItems;
  }

  /// return a non hidden option item
  List<S2Choice<T>> get nonHiddenItems {
    return items
        .where((S2Choice<T> item) => item.hidden != true)
        .toList()
        .cast<S2Choice<T>>();
  }

  /// return a list of group
  List<S2Group<T>> get groups {
    final List<S2Group<T>> groups = groupKeys
        .map((String groupKey) => S2Group<T>(
              name: groupKey,
              choices: groupItems(groupKey),
              headerStyle: groupConfig.headerStyle,
            ))
        .toList()
        .cast<S2Group<T>>();

    // sort the list when the comparator is provided
    if (groupConfig.sortBy != null)
      return groups..sort(groupConfig.sortBy!.compare);

    return groups;
  }

  /// return a unique list of group keys
  List<String> get groupKeys {
    return filteredItems
        .map((S2Choice<T> item) => item.group)
        .toSet()
        .toList()
        .cast<String>();
  }

  /// return a list of group items
  List<S2Choice<T>> groupItems(String key) {
    return filteredItems
        .where((S2Choice<T> item) => item.group == key)
        .toList();
  }

  /// whether the list need to be grouped or not
  bool get isGrouped {
    return groupConfig.enabled && groupKeys != null && groupKeys.isNotEmpty;
  }
}
