import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './model/builder.dart';
import './model/choice_item.dart';
import './model/choice_config.dart';
import './choices_grouped.dart';
import './choices_list.dart';
// import './choices_empty.dart';

class S2ChoicesWrapper<T> extends StatelessWidget {

  final Widget Function(S2Choice<T>) itemBuilder;
  final S2ChoiceLoader<T> loader;
  final List<S2Choice<T>> items;
  final S2ChoiceConfig config;
  final S2Builder<T> builder;
  final Widget loadingWidget;
  final Widget emptyWidget;
  final String query;

  S2ChoicesWrapper({
    Key key,
    @required this.itemBuilder,
    @required this.loader,
    @required this.items,
    @required this.config,
    @required this.builder,
    @required this.loadingWidget,
    @required this.emptyWidget,
    @required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<S2Choice<T>>>(
      future: findChoices(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget;
        }
        if (snapshot.hasData) {
          final List<S2Choice<T>> items = snapshot.data;
          final List<String> groups = findGroups(items, query);
          final bool grouped = config.isGrouped && groups != null && groups.isNotEmpty;
          return grouped == true
            ? S2ChoicesGrouped<T>(
                items: items,
                itemBuilder: itemBuilder,
                groupKeys: groups,
                config: config,
                builder: builder,
                query: query,
              )
            : S2ChoicesList<T>(
                items: items,
                itemBuilder: itemBuilder,
                config: config,
                builder: builder,
              );
        } else {
          return emptyWidget;
        }
      },
    );
    // return _filteredItems.length > 0
    //   ? _isGrouped == true
    //     ? S2ChoicesGrouped<T>(
    //         items: _filteredItems,
    //         itemBuilder: itemBuilder,
    //         groupKeys: _groupKeys,
    //         config: config,
    //         builder: builder,
    //         query: query,
    //       )
    //     : S2ChoicesList<T>(
    //         items: _filteredItems,
    //         itemBuilder: itemBuilder,
    //         config: config,
    //         builder: builder,
    //       )
    //   : builder.choiceEmptyBuilder?.call(context, query)
    //     ?? const S2ChoicesEmpty();
  }

  // return a list of options
  Future<List<S2Choice<T>>> findChoices(String query) async {
    return await loader?.call(query) ?? _filter(_hide(items), query);
  }

  // return a sorted list of group keys
  List<String> findGroups(List<S2Choice<T>> items, String query) {
    Set groups = Set();
    items.forEach((S2Choice<T> item) => groups.add(item.group));

    return groups
      .toList()
      .cast<String>()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  }

  // filter option items
  List<S2Choice<T>> _filter(List<S2Choice<T>> items, String query) {
    return query != null
      ? items
          .where((S2Choice<T> item) => item.contains(query))
          .toList().cast<S2Choice<T>>()
      : items;
  }

  // remove hidden choice items
  List<S2Choice<T>> _hide(List<S2Choice<T>> items) {
    return items..removeWhere((S2Choice<T> item) => item.hidden == true);
  }

  // /// return a filtered list of options
  // List<S2Option<T>> get _filteredItems {
  //   return query != null
  //     ? _nonHiddenItems
  //       .where((S2Option<T> item) => item.contains(query))
  //       .toList().cast<S2Option<T>>()
  //     : _nonHiddenItems;
  // }

  // // return a non hidden option item
  // List<S2Option<T>> get _nonHiddenItems {
  //   return items..removeWhere((S2Option<T> item) => item.hidden == true);
  // }

  // // return a sorted list of group keys
  // List<String> get _groupKeys {
  //   Set groups = Set();
  //   _filteredItems.forEach((S2Option<T> item) => groups.add(item.group));

  //   return groups
  //     .toList()
  //     .cast<String>()
  //     ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  // }

  // bool get _isGrouped {
  //   return config.isGrouped && _groupKeys != null && _groupKeys.isNotEmpty;
  // }
}
