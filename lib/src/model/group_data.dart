import 'package:flutter/foundation.dart';
import './choice_item.dart';
import './group_style.dart';

/// choice group data
@immutable
class S2Group<T> with Diagnosticable {
  /// Group name
  final String? name;

  /// Group choice items
  final List<S2Choice<T>>? choices;

  /// Group header style
  final S2GroupHeaderStyle? headerStyle;

  /// default constructor
  S2Group({
    this.name,
    this.choices,
    this.headerStyle,
  });

  /// Group choice items length
  int get count => choices?.length ?? 0;

  /// Group choice item values
  List<T> get values => choices?.map((e) => e.value)?.toList()?.cast<T>() ?? [];

  /// Creates a copy of this [S2Group] but with
  /// the given fields replaced with the new values.
  S2Group copyWith({
    String? name,
    List<S2Choice>? choices,
    S2GroupHeaderStyle? headerStyle,
  }) {
    return S2Group(
      name: name ?? this.name,
      choices: choices ?? this.choices,
      headerStyle: headerStyle ?? this.headerStyle,
    );
  }

  /// Creates a copy of this [S2Group] but with
  /// the given fields replaced with the new values.
  S2Group merge(S2Group other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      name: other.name,
      choices: other.choices,
      headerStyle: other.headerStyle,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is S2Group &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
