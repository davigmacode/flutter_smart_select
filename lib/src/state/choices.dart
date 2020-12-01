import 'dart:async';
import 'package:flutter/foundation.dart';
import '../model/choice_item.dart';
import '../model/choice_loader.dart';
import '../model/group_data.dart';
import '../model/group_config.dart';

class S2Choices<T> extends ChangeNotifier {

  final S2ChoiceLoader<T> loader;

  final List<S2Choice<T>> preloaded;

  final Duration delay;

  final int limit;

  int page = 1;

  List<S2Choice<T>> items;

  bool refreshing = false;

  bool appending = false;

  S2Choices({
    List<S2Choice<T>> items,
    this.loader,
    this.delay = const Duration(seconds: 3),
    this.limit,
  }) : preloaded = items;

  List<T> get values => items?.map((S2Choice<T> choice) => choice.value)?.toList();

  int get length => items?.length ?? 0;

  bool get isEmpty => items?.isEmpty == true;

  bool get isNotEmpty => items?.isNotEmpty == true;

  bool get initializing => refreshing && isEmpty;

  void load({ String query }) async {
    try {
      List<S2Choice<T>> choices = await find(S2ChoiceLoaderInfo<T>(query: query));
      items = List.from(choices);
    } catch (e) {
      throw e;
    }
  }

  // void refresh({ String query, bool init = false }) async {
  //   if (refreshing != true) {
  //     refreshing = true;
  //     if (init == true) items = null;
  //     page = 1;
  //     notifyListeners();
  //     try {
  //       List<S2Choice<T>> choices = await find(S2ChoiceLoaderInfo<T>(query: query));
  //       items = List.from(choices);
  //       page = 2;
  //     } catch (e) {
  //       throw e;
  //     } finally {
  //       await Future.delayed(delay, () {
  //         refreshing = false;
  //         notifyListeners();
  //       });
  //     }
  //   }
  // }

  // void append({ String query }) async {
  //   if (appending != true) {
  //     appending = true;
  //     notifyListeners();
  //     try {
  //       List<S2Choice<T>> choices = await find(S2ChoiceLoaderInfo<T>(query: query));
  //       items.addAll(choices);
  //       page += 1;
  //     } catch (e) {
  //       throw e;
  //     } finally {
  //       Timer(delay, () {
  //         appending = false;
  //         notifyListeners();
  //       });
  //     }
  //   }
  // }

  /// return a list of options
  Future<List<S2Choice<T>>> find(S2ChoiceLoaderInfo<T> info) async {
    return loader != null
      ? hide(await loader(info))
      : filter(hide(preloaded), info.query);
  }

  /// filter choice items by search text
  List<S2Choice<T>> filter(List<S2Choice<T>> choices, String query) {
    return query != null
      ? choices
        .where((S2Choice<T> choice) => choice.contains(query))
        .toList().cast<S2Choice<T>>()
      : choices;
  }

  /// remove hidden choice items
  List<S2Choice<T>> hide(List<S2Choice<T>> choices) {
    return choices..removeWhere((S2Choice<T> choice) => choice.hidden == true);
  }

  /// return a list of group
  List<S2Group<T>> groupItems(S2GroupConfig config) {
    if (groupKeys?.isEmpty == true) return null;

    final List<S2Group<T>> groups = groupKeys
      .map((String groupKey) => S2Group<T>(
        name: groupKey,
        choices: groupChoices(groupKey),
        headerStyle: config.headerStyle,
      ))
      .toList()
      .cast<S2Group<T>>();

    // sort the list when the comparator is provided
    if (config.sortBy != null)
      return groups..sort(config.sortBy.compare);

    return groups;
  }

  /// return a unique list of group keys
  List<String> get groupKeys {
    return items
      .map((S2Choice<T> choice) => choice.group)
      .toSet()
      .toList()
      .cast<String>();
  }

  /// return a list of group choice items
  List<S2Choice<T>> groupChoices(String key) {
    return items.where((S2Choice<T> choice) => choice.group == key).toList();
  }
}