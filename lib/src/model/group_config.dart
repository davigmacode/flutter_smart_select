import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import './group_style.dart';
import './group_sort.dart';

/// Choices configuration
@immutable
class S2GroupConfig with Diagnosticable {
  /// Whether the choices list is grouped or not, based on [S2Choice.group]
  final bool enabled;

  /// If [enabled] is `true`, whether the group header displays the choices selector toggle or not,
  final bool useSelector;

  /// If [enabled] is `true`, whether the group header displays the choices counter or not
  final bool useCounter;

  /// If [enabled] is `true`, comparator function to sort the group keys
  ///
  /// Defaults to `null`, and it means disabled the sorting
  final S2GroupSort? sortBy;

  /// Configure choices group header theme
  final S2GroupHeaderStyle headerStyle;

  /// Create choices configuration
  const S2GroupConfig({
    this.enabled = false,
    this.useSelector = false,
    this.useCounter = true,
    this.sortBy,
    this.headerStyle = const S2GroupHeaderStyle(),
  })  : assert(enabled != null),
        assert(headerStyle != null);

  /// Opposite value of enabled
  bool get disabled => !enabled;

  /// Creates a copy of this [S2GroupConfig] but with
  /// the given fields replaced with the new values.
  S2GroupConfig copyWith({
    bool? enabled,
    bool? useSelector,
    bool? useCounter,
    S2GroupSort? sortBy,
    S2GroupHeaderStyle? headerStyle,
  }) {
    return S2GroupConfig(
      enabled: enabled ?? this.enabled,
      useSelector: useSelector ?? this.useSelector,
      useCounter: useCounter ?? this.useCounter,
      sortBy: sortBy ?? this.sortBy,
      headerStyle: this.headerStyle?.merge(headerStyle) ?? headerStyle!,
    );
  }

  /// Returns a new [S2GroupConfig] that is
  /// a combination of this object and the given [other] style.
  S2GroupConfig merge(S2GroupConfig? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      enabled: other.enabled,
      useSelector: other.useSelector,
      useCounter: other.useCounter,
      sortBy: other.sortBy,
      headerStyle: other.headerStyle,
    );
  }
}
