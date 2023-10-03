import 'package:flutter/foundation.dart';
import 'choice_item.dart';

typedef Future<List<S2Choice<T>>> S2ChoiceLoader<T>(S2ChoiceLoaderInfo<T> info);

@immutable
class S2ChoiceLoaderInfo<T> with Diagnosticable {
  final List<T>? values;
  final String? query;
  final int? page;
  final int? skip;
  final int? limit;

  S2ChoiceLoaderInfo({
    this.values,
    this.query,
    this.page,
    this.skip,
    this.limit,
  });

  /// Creates a copy of this [S2ChoiceLoaderInfo] but with
  /// the given fields replaced with the new values.
  S2ChoiceLoaderInfo<T> copyWith({
    List<T>? values,
    String? query,
    int? page,
    int? skip,
    int? limit,
  }) {
    return S2ChoiceLoaderInfo<T>(
      values: values ?? this.values,
      query: query ?? this.query,
      page: page ?? this.page,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }

  /// Creates a copy of this [S2ChoiceLoaderInfo] but with
  /// the given fields replaced with the new values.
  S2ChoiceLoaderInfo<T> merge(S2ChoiceLoaderInfo<T> other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      values: other.values,
      query: other.query,
      page: other.page,
      skip: other.skip,
      limit: other.limit,
    );
  }
}
