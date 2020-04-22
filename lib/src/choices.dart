import 'package:flutter/material.dart';
import './model/builder.dart';
import './model/option.dart';
import './model/choice_config.dart';
import './choices_grouped.dart';
import './choices_list.dart';
import './choices_empty.dart';

class S2Choices<T> extends StatelessWidget {

  final Widget Function(S2Option<T>) itemBuilder;
  final List<S2Option<T>> items;
  final S2ChoiceConfig config;
  final S2Builder<T> builder;
  final String query;

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
      ? _isGrouped == true
        ? _choicesGrouped
        : _choicesList
      : builder.choiceEmptyBuilder?.call(context, query)
        ?? const S2ChoicesEmpty();
  }

  Widget get _choicesList {
    return S2ChoicesList<T>(
      items: _filteredItems,
      itemBuilder: itemBuilder,
      config: config,
      builder: builder,
    );
  }

  Widget get _choicesGrouped {
    return Scrollbar(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: config.overscrollColor ?? config.style?.activeColor,
          child: S2ChoicesGrouped<T>(
            items: _filteredItems,
            itemBuilder: itemBuilder,
            groupKeys: _groupKeys,
            config: config,
            builder: builder,
            query: query,
          )
        ),
      ),
    );
  }

  /// return a filtered list of options
  List<S2Option<T>> get _filteredItems {
    return query != null
      ? _nonHiddenItems
        .where((S2Option<T> item) => item.contains(query))
        .toList().cast<S2Option<T>>()
      : _nonHiddenItems;
  }

  // return a non hidden option item
  List<S2Option<T>> get _nonHiddenItems {
    return items
      .where((S2Option<T> item) => item.hidden != true)
      .toList().cast<S2Option<T>>();
  }

  // return a sorted list of group keys
  List<String> get _groupKeys {
    Set groups = Set();
    _filteredItems.forEach((S2Option<T> item) => groups.add(item.group));

    return groups
      .toList()
      .cast<String>()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  }

  bool get _isGrouped {
    return config.isGrouped && _groupKeys != null && _groupKeys.isNotEmpty;
  }
}
