// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import '../model/choice_item.dart';

// class S2Choices<T> extends ChangeNotifier {

//   final List<S2Choice<T>> predefined;

//   final S2ChoiceLoader<T> loader;

//   final Duration delay;

//   final bool grouped;

//   final int limit;

//   int page = 1;

//   List<S2Choice<T>> items;

//   String query;

//   bool refreshing = false;

//   bool appending = false;

//   S2Choices({
//     this.predefined,
//     this.loader,
//     this.grouped = false,
//     this.delay = const Duration(milliseconds: 200),
//     this.limit,
//   });

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

//   // return a list of options
//   Future<List<S2Choice<T>>> find(S2ChoiceLoaderInfo<T> info) async {
//     return loader != null
//       ? _hide(await loader(info))
//       : _filter(_hide(predefined), info.query);
//   }

//   // return a sorted list of group keys
//   List<String> get groups {
//     if (!grouped) return <String>[];

//     Set groups = Set();
//     items.forEach((S2Choice<T> item) => groups.add(item.group));

//     return groups
//       .toList()
//       .cast<String>()
//       ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
//   }

//   // filter option items
//   List<S2Choice<T>> _filter(List<S2Choice<T>> items, String query) {
//     return query != null
//       ? items
//           .where((S2Choice<T> item) => item.contains(query))
//           .toList().cast<S2Choice<T>>()
//       : items;
//   }

//   // remove hidden choice items
//   List<S2Choice<T>> _hide(List<S2Choice<T>> items) {
//     return items..removeWhere((S2Choice<T> item) => item.hidden == true);
//   }
// }