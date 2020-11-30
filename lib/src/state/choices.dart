// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import '../model/choice_item.dart';
// import '../model/choice_loader.dart';
// import '../model/group_data.dart';
// import '../model/group_config.dart';

// class S2Choices<T> extends ChangeNotifier {

//   final S2ChoiceLoader<T> loader;

//   final List<S2Choice<T>> predefined;

//   final Duration delay;

//   final int limit;

//   int page = 1;

//   List<S2Choice<T>> items;

//   List<S2Group<T>> groups;

//   String query;

//   bool refreshing = false;

//   bool appending = false;

//   S2Choices({
//     List<S2Choice<T>> items,
//     this.loader,
//     this.delay = const Duration(milliseconds: 200),
//     this.limit,
//   }) : predefined = items;

//   bool get initializing => refreshing && items == null;

//   void refresh({ String query, bool init = false }) async {
//     if (refreshing != true) {
//       refreshing = true;
//       if (init == true) items = null;
//       page = 1;
//       notifyListeners();
//       try {
//         List<S2Choice<T>> res = await find(S2ChoiceLoaderInfo<T>(query: query));
//         items = List.from(res);
//         page = 2;
//       } catch (e) {
//         throw e;
//       } finally {
//         Timer(delay, () {
//           refreshing = false;
//           notifyListeners();
//         });
//       }
//     }
//   }

//   void append({ String query }) async {
//     if (appending != true) {
//       appending = true;
//       notifyListeners();
//       try {
//         List<S2Choice<T>> res = await find(S2ChoiceLoaderInfo<T>(query: query));
//         items.addAll(res);
//         page += 1;
//       } catch (e) {
//         throw e;
//       } finally {
//         Timer(delay, () {
//           appending = false;
//           notifyListeners();
//         });
//       }
//     }
//   }

//   /// return a list of options
//   Future<List<S2Choice<T>>> find(S2ChoiceLoaderInfo<T> info) async {
//     return loader != null
//       ? hide(await loader(info))
//       : filter(hide(predefined), info.query);
//   }

//   /// filter choice items by search text
//   List<S2Choice<T>> filter(List<S2Choice<T>> choices, String query) {
//     return query != null
//       ? choices
//         .where((S2Choice<T> choice) => choice.contains(query))
//         .toList().cast<S2Choice<T>>()
//       : choices;
//   }

//   /// remove hidden choice items
//   List<S2Choice<T>> hide(List<S2Choice<T>> choices) {
//     return choices..removeWhere((S2Choice<T> choice) => choice.hidden == true);
//   }

//   /// whether the list need to be grouped or not
//   bool isGrouped({
//     List<String> keys,
//     S2GroupConfig config,
//   }) {
//     return config.enabled && keys != null && keys.isNotEmpty;
//   }

//   /// return a list of group
//   List<S2Group<T>> groupItems({
//     List<String> keys,
//     List<S2Choice<T>> choices,
//     S2GroupConfig config,
//   }) {
//     final List<S2Group<T>> groups = keys
//       .map((String groupKey) => S2Group<T>(
//         name: groupKey,
//         choices: groupChoices(groupKey, choices),
//         headerStyle: config.headerStyle,
//       ))
//       .toList()
//       .cast<S2Group<T>>();

//     // sort the list when the comparator is provided
//     if (config.sort != null)
//       return groups..sort(config.sort.compare);

//     return groups;
//   }

//   /// return a unique list of group keys
//   List<String> groupKeys(List<S2Choice<T>> choices) {
//     return choices
//       .map((S2Choice<T> choice) => choice.group)
//       .toSet()
//       .toList()
//       .cast<String>();
//   }

//   /// return a list of group choice items
//   List<S2Choice<T>> groupChoices(String key, List<S2Choice<T>> choices) {
//     return choices.where((S2Choice<T> choice) => choice.group == key).toList();
//   }
// }