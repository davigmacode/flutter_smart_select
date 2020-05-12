import 'package:flutter/foundation.dart';
import 'choice_item.dart';

typedef Future<List<S2Choice<T>>> S2SourceLoader<T>(String query);

class S2Source<T> {
  final List<S2Choice<T>> items;
  final S2SourceLoader<T> loader;
  final bool grouped;

  const S2Source({
    this.items,
    this.loader,
    this.grouped = false,
  }) :
    // assert(items != null || loader != null, 'items and loader must not be both null'),
    assert(grouped != null);

  const S2Source.internal({
    @required this.items,
    this.grouped = false,
  }) : loader = null;

  const S2Source.external({
    @required this.loader,
    this.grouped = false,
  }) : items = null;

  /// Creates a copy of this [S2Source] but with
  /// the given fields replaced with the new values.
  S2Source<T> copyWith({
    List<S2Choice<T>> items,
    S2SourceLoader<T> loader,
    bool grouped,
  }) {
    return S2Source<T>(
      items: items ?? this.items,
      loader: loader ?? this.loader,
      grouped: grouped ?? this.grouped,
    );
  }

  /// Returns a new [S2Source] that is
  /// a combination of this object and the given [other] style.
  S2Source<T> merge(S2Source<T> other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      items: other.items,
      loader: other.loader,
      grouped: other.grouped,
    );
  }

  // return a list of options
  Future<List<S2Choice<T>>> find(String query) async {
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

  // bool get isGrouped {
  //   return grouped && _groupKeys != null && _groupKeys.isNotEmpty;
  // }

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
}